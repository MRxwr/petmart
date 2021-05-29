import 'dart:convert';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/pets_model.dart' as Model;
import 'package:pet_mart/model/post_details_model.dart';
import 'package:pet_mart/model/share_model.dart';
import 'package:pet_mart/model/view_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/message_screen.dart';
import 'package:pet_mart/screens/photo-screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
class PetsDetailsScreen extends StatefulWidget {
  static String id = 'PetsDetailsScreen';
 String  postId;

  PetsDetailsScreen({Key key,@required this.postId}) : super(key: key);


  @override
  _PetsDetailsScreenState createState() => _PetsDetailsScreenState();
}

class _PetsDetailsScreenState extends State<PetsDetailsScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  var imageProvider = null;
  double itemWidth;
  double itemHeight;
  String noOfViews ="";
  String noOfShares = "";
      TextButton previewButton(String text,BuildContext context,ContactDetail contactDetail){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFFFFC300),
      minimumSize: Size(88.w, 35.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: Color(0xFFFFC300),
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {
showDialog(contactDetail);

      },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
    );
  }
  PostDetailsModel postDetailsModel;
  TextButton callButton(String text,BuildContext context,String phone) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFFFFC300),
      minimumSize: Size(88.w, 35.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: Color(0xFFFFC300),
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: ()async {
        if (await canLaunch('tel://+${phone}')) {
          await launch('tel://+${phone}');
        } else {
          print(' could not launch ');
        }


     Navigator.pop(context);

      },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
    );
  }

  final CarouselController _controller = CarouselController();
  Future<PostDetailsModel> pets() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    String loginData = _preferences.getString(kUserModel);
    Map map;
    if(loginData == null) {
      map = {
        'post_id': widget.postId,
        'user_id': "",

        'language': languageCode
      };
    }else{
      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      map = {
        'post_id': widget.postId,
        'user_id': loginModel.data.customerId,

        'language': languageCode
      };
    }
    print('map --> ${map}');

    PetMartService petMartService = PetMartService();
    PostDetailsModel petsModel = await petMartService.petDetails(map);

    return petsModel;
  }
  Future<void> SharePets() async{
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.changeIsLoading(true);

    List<String> imagePaths = [];
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    String loginData = _preferences.getString(kUserModel);
    Map map;

      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      map = {
        'post_id': widget.postId,
        'user_id': loginModel.data.customerId
      };

    print('map --> ${map}');

    PetMartService petMartService = PetMartService();
    ShareModel petsModel = await petMartService.sharePet(map);
    var imageId =
    await ImageDownloader.downloadImage(postDetailsModel.data.gallery[0].image);
    if (imageId == null) {
      return;
    }
    // Below is a method of obtaining saved image information.
    print('imageId-->${imageId}');
    var fileName = await ImageDownloader.findName(imageId);
    var path = await ImageDownloader.findPath(imageId);
    var size = await ImageDownloader.findByteSize(imageId);
    var mimeType = await ImageDownloader.findMimeType(imageId);
    modelHud.changeIsLoading(false);
    // setState(() {
    //   noOfShares = petsModel.data.shareCount;
    // });
    List<String> paths = List();
    paths.add(path);
    print('paths --> ${paths}');
    List<String> mimeTypes = List();
    mimeTypes.add(mimeType);
    print('mimeType --> ${mimeType}');
   Share.shareFiles(paths,mimeTypes: mimeTypes,subject:'${postDetailsModel.data.postName} \\n ${postDetailsModel.data.postDescription}' );





  }
  Future<void> petView() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    String loginData = _preferences.getString(kUserModel);
    Map map;
    if(loginData != null) {
      final body = json.decode(loginData);
      LoginModel loginModel = LoginModel.fromJson(body);
      map = {
        'post_id': widget.postId,
        'user_id': loginModel.data.customerId,

        'language': languageCode
      };

      print('map --> ${map}');

      PetMartService petMartService = PetMartService();
      ViewModel petsModel = await petMartService.viewPet(map);
      setState(() {
        noOfViews = petsModel.data.postCount.toString();

      });
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pets().then((value) {
      setState(() {
        postDetailsModel = value;
        noOfViews = value.data.views;
        noOfShares = value.data.shared;
      });

    }).whenComplete(() {
      petView();
    });
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    itemWidth = width / 2;
    itemHeight = 200.h;
    double height = MediaQuery.of(context).size.height;
    int _current =0;
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
      child: Scaffold(

        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton:  FloatingActionButton(
          onPressed: () {
            print("true");
            Navigator.pop(context);
          },
          tooltip: 'Increment',
          child:Container(
              alignment: AlignmentDirectional.center,
              width: 60.w, height: 60.w, child: Center(child: Icon(Icons.arrow_back_ios,color: Color(0xFFFFFFFF),))),
          elevation: 2.0,
        ),
        body: Container(
          child: postDetailsModel == null?Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          ):
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 250.h,
                width: width,
                child:
                Stack(
                  children: [

                    CarouselSlider(

                      carouselController: _controller,
                      options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 10),

                          scrollPhysics:   const NeverScrollableScrollPhysics(),

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
                      items: postDetailsModel.data.gallery.map((item) =>
                          Stack(

                            children: [
                              GestureDetector(
                                onTap: (){
                                  String url = item.image.trim();
                                  if(url.isNotEmpty) {
                                    Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                                      return new PhotoScreen(imageProvider: NetworkImage(
                                          url
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
                                    imageBuilder: (context, imageProvider) {

                                     return Card(
                                        elevation: 1.h,
                                        child: Container(
                                            width: width,


                                            decoration: BoxDecoration(


                                              image: DecorationImage(


                                                  fit: BoxFit.fill,
                                                  image: imageProvider),
                                            )
                                        ),
                                      );
                                    }
                                        ,
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


                                    errorWidget: (context, url, error) => ClipRRect(
                                        child: Image.asset('assets/images/placeholder_error.png',  fit: BoxFit.fill,
                                          colorBlendMode: BlendMode.difference,)),

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



                  ],
                ),
              ),
              SizedBox(height: 1.h,
                width: width,
                child: Container(
                  color: Color(0x88000000),
                ),),
              Container(
                margin: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     postDetailsModel.data.postName,
                      style: TextStyle(
                          color: Color(0xFF000000),
                        fontSize: screenUtil.setSp(14),
                        fontWeight: FontWeight.normal

                      ),
                    ),
                    Text(
                      '${postDetailsModel.data.categoryName}  ${postDetailsModel.data.subCategoryName}',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(14),
                          fontWeight: FontWeight.normal

                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${postDetailsModel.data.postPrice}',
                          style: TextStyle(
                              color: kMainColor,
                              fontSize: screenUtil.setSp(14),
                              fontWeight: FontWeight.normal

                          ),
                        ),
                        previewButton('Contact Now', context,postDetailsModel.data.contactDetail)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h,
                width: width,
                child: Container(
                  color: Color(0x88000000),
                ),),
              Container(
                margin: EdgeInsets.all(10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(

                      children: [

                          Image.asset('assets/images/img_view.png',
                            height: 30.h,width: 30.w,
                          )

                        ,
                        Text(
                          "${noOfViews} Views" ,
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: screenUtil.setSp(14),
                              fontWeight: FontWeight.normal

                          ),
                        ),
                      ],

                    ),
                    GestureDetector(
                      onTap: (){
                        SharePets();
                      },
                      child: Column(

                        children: [
                          Image.asset('assets/images/img_share.png',
                            height: 30.h,width: 30.w,
                          )
                          ,
                          Text(
                            "${noOfShares} Shared" ,
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: screenUtil.setSp(14),
                                fontWeight: FontWeight.normal

                            ),
                          ),
                        ],

                      ),
                    ),
                    GestureDetector(
                      onTap: ()async{
                        SharedPreferences _preferences = await SharedPreferences.getInstance();
                        String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
                        String loginData = _preferences.getString(kUserModel);
                        Map map;

                        final body = json.decode(loginData);
                        LoginModel   loginModel = LoginModel.fromJson(body);
                        Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                          return new MessageScreen(contactName:postDetailsModel.data.contactDetail.customerName,
                          contactImage:postDetailsModel.data.contactDetail.profileImage ,
                              contactId:postDetailsModel.data.contactDetail.customerId,
                          postId: postDetailsModel.data.postId,
                          userId: loginModel.data.customerId,);
                        }));
                      },
                      child: Column(

                        children: [
                          Image.asset('assets/images/img_contact.png',
                            height: 30.h,width: 30.w,
                          )
                         ,
                          Text(
                            "${postDetailsModel.data.contactCount} Send Messages" ,
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: screenUtil.setSp(14),
                                fontWeight: FontWeight.normal

                            ),
                          ),
                        ],

                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 1.h,
                width: width,
                child: Container(
                  color: Color(0x88000000),
                ),),
              Container(
                margin: EdgeInsets.all(10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Gender : ${postDetailsModel.data.gender}  " ,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(14),
                          fontWeight: FontWeight.normal

                      ),
                    ),
                    Text(
                      "Age : ${postDetailsModel.data.age}  Week" ,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(14),
                          fontWeight: FontWeight.normal

                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h,
                width: width,
                child: Container(
                  color: Color(0x88000000),
                ),),
              Container(
                margin: EdgeInsets.all(10.w),
                child:  Text(
                  "${postDetailsModel.data.postDescription}  " ,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: screenUtil.setSp(14),
                      fontWeight: FontWeight.normal

                  ),
                ),
              ),
              SizedBox(height: 1.h,
                width: width,
                child: Container(
                  color: Color(0x88000000),
                ),),
              Container(
                margin: EdgeInsets.all(10.w),
                child:  Text(
                  "Similar Ads" ,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: screenUtil.setSp(14),
                      fontWeight: FontWeight.normal

                  ),
                ),
              ),
              SizedBox(height: 1.h,
                width: width,
                child: Container(
                  color: Color(0x88000000),
                ),),
              Container(

                child:  GridView.builder(scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,


                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                      childAspectRatio:itemWidth/itemHeight),
                  itemCount: postDetailsModel.data.relatePost.length,

                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                          return new PetsDetailsScreen(postId:postDetailsModel.data.relatePost[index].postId);
                        }));
                        // Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                        //   return new PetsDetailsScreen(petsModel:petsModel.data[index]);
                        // }));
                      },
                      child: Container(
                          margin: EdgeInsets.all(6.w),

                          child:
                          Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 1.w,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0.h),
                              ),
                              color: Color(0xFFFFFFFF),
                              child: buildItem(postDetailsModel.data.relatePost[index],context))),
                    );
                  },
                ),

              )
            ],
          ),
        ),
      ),
    );

  }
  Widget buildItem(RelatePost data, BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: itemWidth,
                  imageUrl:data.postImage,
                  imageBuilder: (context, imageProvider) => Stack(
                    children: [
                      ClipRRect(

                        child: Container(
                            width: itemWidth,

                            decoration: BoxDecoration(

                              shape: BoxShape.rectangle,

                              image: DecorationImage(
                                  fit: BoxFit.fill,

                                  image: imageProvider),
                            )
                        ),
                      ),
                    ],
                  ),
                  placeholder: (context, url) =>
                      Center(
                        child: SizedBox(
                            height: 50.h,
                            width: 50.h,
                            child: new CircularProgressIndicator()),
                      ),


                  errorWidget: (context, url, error) => ClipRRect(
                      child: Image.asset('assets/images/placeholder_error.png',  fit: BoxFit.fill,color: Color(0x80757575).withOpacity(0.5),
                        colorBlendMode: BlendMode.difference,)),

                ),
                Positioned.directional(
                  textDirection:  Directionality.of(context),
                  bottom: 2.h,
                  start: 4.w,
                  child:
                  Text(
                    data.postDate,
                    style: TextStyle(
                        color: Color(0xFFFFFFFF)

                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(flex:1,child: Container(
            child: Column(
              children: [
                Expanded(flex:1,child:
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    data.postName,
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                        fontSize: screenUtil.setSp(12)
                    ),

                  ),
                )),
                Expanded(flex:1,child:
                Row(
                  children: [

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child:
                      Text(
                        '${data.postPrice}',
                        style: TextStyle(
                            color: kMainColor,
                            fontWeight: FontWeight.normal,
                            fontSize: screenUtil.setSp(14)
                        ),

                      ),
                    ),
                  ],
                ))
              ],
            ),
          ))

        ],
      ),
    );

  }
  void showDialog(ContactDetail contactDetail) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 150.h,
              child: Container(
                margin: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'Contact for sell',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontSize: screenUtil.setSp(16)
                        ),

                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CachedNetworkImage(
                          width: 80.w,
                          height: 80.h,
                          imageUrl:contactDetail.profileImage,
                          imageBuilder: (context, imageProvider) => Stack(
                            children: [
                              ClipRRect(

                                child: Container(


                                    decoration: BoxDecoration(

                                      shape: BoxShape.rectangle,

                                      image: DecorationImage(
                                          fit: BoxFit.fill,

                                          image: imageProvider),
                                    )
                                ),
                              ),
                            ],
                          ),
                          placeholder: (context, url) =>
                              Center(
                                child: SizedBox(
                                    height: 20.h,
                                    width: 20.h,
                                    child: new CircularProgressIndicator()),
                              ),


                          errorWidget: (context, url, error) => ClipRRect(
                              child: Image.asset('assets/images/placeholder_error.png',  fit: BoxFit.fill,color: Color(0x80757575).withOpacity(0.5),
                                colorBlendMode: BlendMode.difference,)),

                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                'By ${contactDetail.customerName}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.normal,
                                    fontSize: screenUtil.setSp(12)
                                ),

                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                contactDetail.postCreatedDate,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.normal,
                                    fontSize: screenUtil.setSp(12)
                                ),

                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Text(
                                contactDetail.mobile,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.normal,
                                    fontSize: screenUtil.setSp(12)
                                ),

                              ),
                            ),
                          ],
                        ),
                        callButton('Call Now', context, contactDetail.mobile)
                      ],
                    )
                  ],
                ),
              ),

              margin: EdgeInsets.only(bottom: 20.h, left: 12.w, right: 12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.h),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

}
