import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/home_model.dart';
import 'package:pet_mart/model/init_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/screens/advertise_screen.dart';
import 'package:pet_mart/screens/categories_screen.dart';
import 'package:pet_mart/screens/hospitals_screen.dart';
import 'package:pet_mart/screens/photo-screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/widgets/arc_widget.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hospital_screen.dart';
class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  LoginModel loginModel = null;
  HomeModel homeModel = null;
  InitModel initModel = null;
  int _current =0;
  final CarouselController _controller = CarouselController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginModel().then((value) {
      loginModel = value;
    }).whenComplete(() {
      home().then((value) {
        setState(() {
          homeModel = value;
        });

      });
    });
  }
  Future<LoginModel> getLoginModel() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String loginData = sharedPreferences.getString(kUserModel);
    String initData = sharedPreferences.getString("initModel");
    final initBody = json.decode(initData);
    initModel = InitModel.fromJson(initBody);

    final body = json.decode(loginData);
    LoginModel   loginModel = LoginModel.fromJson(body);
    return loginModel;
  }
  Future<HomeModel> home() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    Map map ;
    if(loginModel == null){
      map = {'id': "",
        "language":languageCode
      };
    }else{
      map = {'id': loginModel.data.customerId,
        "language":languageCode
      };
    }
    print('map --> ${map}');

    PetMartService petMartService = PetMartService();
    HomeModel home = await petMartService.home(map);
    return home;
  }
  @override
  Widget build(BuildContext context) {
double width = MediaQuery.of(context).size.width;
double height = MediaQuery.of(context).size.height;
    return Scaffold(

      body: Container(
        margin: EdgeInsets.all(10.w),
        child:
        homeModel == null?

        Container(
          child: CircularProgressIndicator(
        

          ),
          alignment: AlignmentDirectional.center,
        ):
        ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,


          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),

          children: [
            Container(
              height: 120.h,
              width: width,
              child:  CarouselSlider(

                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 10),



                    height: double.infinity,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    disableCenter: true,
                    pauseAutoPlayOnTouch: true
                    ,




                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }
                ),
                items: homeModel.data.banner.map((item) =>
                    Stack(

                      children: [
                        GestureDetector(
                          onTap: (){
                            String url = item.image.trim();
                            if(url.isNotEmpty) {
                              Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                                return new PhotoScreen(imageProvider: NetworkImage(
                                  url,
                                ),);
                              }));

                            }

                          },


                          child:
                          Container(
                            width: width,

                            child:
                            CachedNetworkImage(
                              width: width,

                              fit: BoxFit.fill,
                              imageUrl:'${item.image}',
                              imageBuilder: (context, imageProvider) => Card(
                                elevation: 1.h,
                                child: Container(
                                    width: width,


                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8.0.w)),


                                      image: DecorationImage(


                                          fit: BoxFit.fill,
                                          image: imageProvider),
                                    )
                                ),
                              ),
                              placeholder: (context, url) =>
                                  Column(
                                    children: [
                                      Expanded(
                                        flex: 9,
                                        child: Container(
                                          height: height,
                                          width: width,


                                          alignment: FractionalOffset.center,
                                          child: SizedBox(
                                              height: 50.h,
                                              width: 50.h,
                                              child: new CircularProgressIndicator()),
                                        ),
                                      ),
                                    ],
                                  ),


                              errorWidget: (context, url, error) => Container(
                                  height: height,
                                  width: width,
                                  alignment: FractionalOffset.center,
                                  child: Icon(Icons.image_not_supported)),

                            ),
                            // Image.network(
                            //
                            //
                            // '${kBaseUrl}${mAdsPhoto}${item.photo}'  , fit: BoxFit.fitWidth,
                            //   height: 600.h,),
                          ),
                        ),

                      ] ,
                    )).toList(),

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: homeModel.data.banner.map((item) {
                int index = homeModel.data.banner.indexOf(item);
                return Container(
                  width: 8.0.w,
                  height: 8.0.h,
                  margin: EdgeInsets.symmetric(vertical: 10.0.w, horizontal: 2.0.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color(0xFFEFA18B)
                        : Color(0xFF707070),
                  ),
                );
              }).toList(),
            ),
            Row(
              children: [
                previewButton(getTranslated(context, 'view_all'),context),
              ],
            ),
            SizedBox(height: 10.h,),
            ListView.separated(
                scrollDirection: Axis.vertical,


                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                          return new CategoriesScreen(category:homeModel.data.category[index]);
                        }));
                      },

                      child: Container(
                      width: width,


                      child:
                      Stack(
                        children: [


                          CachedNetworkImage(
                            width: width,
                            height: 120.h,

                            fit: BoxFit.fill,
                            imageUrl:homeModel.data.category[index].images[0].image,
                            imageBuilder: (context, imageProvider) => Container(
                                width: width,


                                decoration: BoxDecoration(


                                  image: DecorationImage(


                                      fit: BoxFit.fill,
                                      image: imageProvider),
                                )
                            ),
                            placeholder: (context, url) =>
                                Column(
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        height: height,
                                        width: width,


                                        alignment: FractionalOffset.center,
                                        child: SizedBox(
                                            height: 50.h,
                                            width: 50.h,
                                            child: new CircularProgressIndicator()),
                                      ),
                                    ),
                                  ],
                                ),


                            errorWidget: (context, url, error) => Container(
                                height: height,
                                width: width,
                                alignment: FractionalOffset.center,
                                child: Icon(Icons.image_not_supported)),

                          ),
                          Positioned.directional(
                            textDirection:  Directionality.of(context),
                            bottom: 0,
                            child: Container(
                              color: Color(0x44AAAAAA),
                              height: 30.h,
                              width: width,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left:10.w,right: 10.h),
                                    child: ImageIcon(
                                      AssetImage('assets/images/pawprint.png'
                                      ),size: 20.h,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    homeModel.data.category[index].categoryName,
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: screenUtil.setSp(16),
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),

                            ),
                          ),
                        ],
                      ),

                  ),
                    );
                },

                separatorBuilder: (context,index){
              return Container(height: 10.h,
                color: Color(0xFFFFFFFF),);
            }, itemCount: homeModel.data.category.length),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: 
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                        return new HospitalsScreen();
                      }));
                    },
                    child: Container(
                      height: 150.h,
                      child: Column(
                        children: [
                          Expanded(flex: 4,
                              child:CachedNetworkImage(


                                fit: BoxFit.fill,
                                imageUrl:'${initModel.data.adoptionUrl}',
                                imageBuilder: (context, imageProvider) => Card(
                                  elevation: 1.h,
                                  child: Container(
                                      width: width,


                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(8.0.w)),


                                        image: DecorationImage(


                                            fit: BoxFit.fill,
                                            image: imageProvider),
                                      )
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Column(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Container(
                                            height: height,
                                            width: width,


                                            alignment: FractionalOffset.center,
                                            child: SizedBox(
                                                height: 50.h,
                                                width: 50.h,
                                                child: new CircularProgressIndicator()),
                                          ),
                                        ),
                                      ],
                                    ),


                                errorWidget: (context, url, error) => Container(
                                    height: height,
                                    width: width,
                                    alignment: FractionalOffset.center,
                                    child: Icon(Icons.image_not_supported)),

                              ),
                          ),
                          Expanded(child:   Text(
                            getTranslated(context, 'hospital'),
                            style: TextStyle(
                                color: kMainColor,
                                fontSize: screenUtil.setSp(16),
                                fontWeight: FontWeight.bold
                            ),
                          ),flex: 1,)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child:
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                        return new HospitalScreen();
                      }));
                    },
                    child: Container(
                      height: 150.h,
                      child: Column(
                        children: [
                          Expanded(flex: 4,
                              child: CachedNetworkImage(


                                fit: BoxFit.fill,
                                imageUrl:'${initModel.data.shopUrl}',
                                imageBuilder: (context, imageProvider) => Card(
                                  elevation: 1.h,
                                  child: Container(
                                      width: width,


                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(8.0.w)),


                                        image: DecorationImage(


                                            fit: BoxFit.fill,
                                            image: imageProvider),
                                      )
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Column(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Container(
                                            height: height,
                                            width: width,


                                            alignment: FractionalOffset.center,
                                            child: SizedBox(
                                                height: 50.h,
                                                width: 50.h,
                                                child: new CircularProgressIndicator()),
                                          ),
                                        ),
                                      ],
                                    ),


                                errorWidget: (context, url, error) => Container(
                                    height: height,
                                    width: width,
                                    alignment: FractionalOffset.center,
                                    child: Icon(Icons.image_not_supported)),

                              )
                          ),
                          Expanded(child:   Text(
                            getTranslated(context, 'shop'),
                            style: TextStyle(
                                color: kMainColor,
                                fontSize: screenUtil.setSp(16),
                                fontWeight: FontWeight.bold
                            ),
                          ),flex: 1,)
                        ],
                      ),
                    ),
                  ),
                ),


              ],
            )



          ],
        ),
      )



    );
  }
  TextButton previewButton(String text,BuildContext context){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFFFFFFFF),
      minimumSize: Size(88.w, 35.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: kMainColor,
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {

        Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){

          return new AdvertiseScreen(homeModel:homeModel);
        }));
      },
      child: Text(text,style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
    );
  }
}
