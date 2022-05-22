import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/home_model.dart';

import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/screens/advertise_screen.dart';
import 'package:pet_mart/screens/categories_screen.dart';
import 'package:pet_mart/screens/hospitals_screen.dart';
import 'package:pet_mart/screens/photo-screen.dart';
import 'package:pet_mart/screens/services_screen.dart';
import 'package:pet_mart/screens/web_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/widgets/arc_widget.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/notification_count.dart';
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

  int _current =0;
  final CarouselController _controller = CarouselController();
  String languageCode;
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



    final body = json.decode(loginData);
    LoginModel   loginModel = LoginModel.fromJson(body);
    return loginModel;
  }
  Future<HomeModel> home() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
     languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    Map map ;
    String id ="";
    if(loginModel == null){
      id ="";

    }else{
      id = loginModel.data.id;

    }
    print('map --> ${map}');

    PetMartService petMartService = PetMartService();
    HomeModel home = await petMartService.home(id);

    Provider.of<NotificationNotifier>(context,listen: false).addCount(home.data.totalNotifications);
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
            Stack(
              children: [
                Container(
                  height: 120.h,
                  width: width,
                  child:

                  CarouselSlider(

                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),

                        enableInfiniteScroll: true,


                        height: double.infinity,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        disableCenter: true,






                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }
                    ),
                    items: homeModel.data.banners.map((item) =>
                        Stack(

                          children: [
                            GestureDetector(
                              onTap: (){
                                String url = item.image.trim();
                                String link = item.url;
                                String title = languageCode == "en"? item.enTitle:item.arTitle;
                                if(link != null||link.trim() !=""){
                                  Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>  WebScreen(url: link, name: title)));
                                }else{
                                if(url.isNotEmpty) {
                                  Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                                    return new PhotoScreen(imageProvider: NetworkImage(
                                      KImageUrl+url,
                                    ),);
                                  }));

                                }

                              }},


                              child:
                              Container(
                                width: width,

                                child:
                                CachedNetworkImage(
                                  width: width,

                                  fit: BoxFit.fill,
                                  imageUrl:'${KImageUrl+item.image}',
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
                Positioned.directional(textDirection: Directionality.of(context),
                    bottom: 2.w,
                    start: 0,
                    end: 0,

                    child:  Opacity(
                      opacity: homeModel.data.banners.length>1?1.0:0.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: homeModel.data.banners.map((item) {
                          int index = homeModel.data.banners.indexOf(item);
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
                    ),)
              ],
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
                          return new CategoriesScreen(category:homeModel.data.categories[index]);
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
                            imageUrl:KImageUrl+homeModel.data.categories[index].logo,
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
                              color: Color(0x88AAAAAA),
                              height: 30.h,
                              width: width,
                              child: Row(
                                children: [

                                  Padding(
                                    padding:  EdgeInsetsDirectional.only(start: 10.h),
                                    child: Text(languageCode == "en"?
                                      homeModel.data.categories[index].enTitle:
                                    homeModel.data.categories[index].arTitle,
                                      style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontSize: screenUtil.setSp(16),
                                          fontWeight: FontWeight.bold
                                      ),
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
            }, itemCount: homeModel.data.categories.length),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                      return new HospitalScreen();
                    }));
                  },
                  child: Container(
                    height: 120.h,
                    width: width/3-20,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius:BorderRadius.all(Radius.circular(10.w))
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            child: Image.asset('assets/images/shop_icon.png',width: 70.w,
                            height: 70.w,
                              fit: BoxFit.fill,
                             ),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            color: Color(0x88AAAAAA),

                            width: width,
                            child: Text( getTranslated(context, 'shop'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: screenUtil.setSp(14),
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                      return new HospitalsScreen();
                    }));
                  },
                  child: Container(
                    height: 120.h,
                    width: width/3-20,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius:BorderRadius.all(Radius.circular(10.w))
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            child: Image.asset('assets/images/hospital_icon.png',width: 70.w,
                              height: 70.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            color: Color(0x88AAAAAA),
                            height: 30.h,
                            width: width,
                            child: Text( getTranslated(context, 'hospital'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: screenUtil.setSp(14),
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                      return new ServicesScreen();
                    }));
                  },
                  child: Container(
                    height: 120.h,
                    width: width/3-20,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius:BorderRadius.all(Radius.circular(10.w))
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex:2,
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            child: Image.asset('assets/images/services.png',width: 70.w,
                              height: 70.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),

                        Expanded(
                        flex: 1,
                          child: Container(
                            color: Color(0x88AAAAAA),

                            alignment: AlignmentDirectional.center,
                            width: width,
                            child: Text( getTranslated(context, 'service'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: screenUtil.setSp(14),
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h,),


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

          return new AdvertiseScreen(homeModel:homeModel, langCode: languageCode,);
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
