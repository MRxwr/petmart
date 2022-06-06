import 'dart:convert';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/delete_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/pets_model.dart' as Model;
import 'package:pet_mart/model/post_details_model.dart';
import 'package:pet_mart/model/share_model.dart';
import 'package:pet_mart/model/view_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/edit_post_screen.dart';
import 'package:pet_mart/screens/message_screen.dart';
import 'package:pet_mart/screens/photo-screen.dart';
import 'package:pet_mart/screens/vedio_screen.dart';
import 'package:pet_mart/screens/youtube_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login_screen.dart';
import 'main_sceen.dart';
class MyPostDetailsScreen extends StatefulWidget {
  static String id = 'PetsDetailsScreen';
  String  postId;
  String postName;
   MyPostDetailsScreen({Key key,@required this.postId,@required this.postName}) : super(key: key);

  @override
  State<MyPostDetailsScreen> createState() => _MyPostDetailsScreenState();
}

class _MyPostDetailsScreenState extends State<MyPostDetailsScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  var imageProvider = null;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double itemWidth;
  double itemHeight;
  String noOfViews ="";
  String noOfShares = "";
  String userId="";
  String mLanguage = "";
  TextButton previewButton(String text,BuildContext context,Customer contactDetail){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFFFFC300),
      minimumSize: Size(50.w, 35.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: Color(0xFFFFC300),
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {
        Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
          return new EditPostScreen(postDetailsModel:postDetailsModel,userId: userId);
        }));

      },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
    );
  }
  TextButton deleteButton(String text,BuildContext context,Customer contactDetail){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFFFF0000),
      minimumSize: Size(65.w, 35.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: Color(0xFFFF0000),
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {
        deletePost();


      },
      child: Text(text,style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
    );
  }
  void deletePost()async{
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.changeIsLoading(true);
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    Map map;
    map = {
      'post_id': widget.postId,


      'language': languageCode
    };
    PetMartService petMartService = PetMartService();
    DeleteModel deleteModel = await petMartService.deleteModel(widget.postId);
    bool ok = deleteModel.ok;
    modelHud.changeIsLoading(false);
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(deleteModel.data.msg)));

    if(ok){
      Navigator.pushReplacementNamed(context,MainScreen.id);
    }
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
          await launch('tel://${phone}');
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
    mLanguage = languageCode;
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
      userId = loginModel.data.id;
      map = {
        'post_id': widget.postId,
        'user_id': loginModel.data.id,

        'language': languageCode
      };
    }
    print('map --> ${map}');

    PetMartService petMartService = PetMartService();
    PostDetailsModel petsModel = await petMartService.petDetails(widget.postId);

    return petsModel;
  }
  Future<void> ShareDialog(BuildContext context ) async{
    var alert;
    var alertStyle = AlertStyle(

      animationType: AnimationType.fromBottom,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.normal,
          color: Color(0xFF0000000),
          fontSize: screenUtil.setSp(18)),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.normal,
          fontSize: screenUtil.setSp(16)
      ),
      alertAlignment: AlignmentDirectional.center,
    );
    alert =   Alert(
      context: context,
      style: alertStyle,

      title: getTranslated(context, 'share_message'),


      buttons: [

        DialogButton(
          child: Text(
            getTranslated(context, 'ok'),
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            Navigator.pop(context);
            share(context);
            // Navigator.pushReplacementNamed(context,LoginScreen.id);

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        ),
        DialogButton(
          child: Text(
            getTranslated(context, 'no'),
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            Navigator.pop(context);
            // Navigator.pushReplacementNamed(context,LoginScreen.id);

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        ),
      ],
    );
    alert.show();

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
      'user_id': loginModel.data.id
    };

    print('map --> ${map}');

    PetMartService petMartService = PetMartService();
    ShareModel petsModel = await petMartService.sharePet("share","item",widget.postId);
    modelHud.changeIsLoading(false);
    String title="";
    title = languageCode == "en"?postDetailsModel.data.items[0].enTitle:postDetailsModel.data.items[0].arTitle;
    String description="";
    description = languageCode== "en"?postDetailsModel.data.items[0].enDetails:postDetailsModel.data.items[0].arDetails;
    //
    if(Platform.isIOS){
      Share.share('${title}' '\n ${description}' '\n market://details?id=com.createq8.petMart');

    }else{
      Share.share('${title}' '\n ${description}' '\n https://play.google.com/store/apps/details?id=com.createq8.petMart');

    }
    setState(() {
      noOfShares = "${int.parse(noOfShares)+1}";

    });

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
        'user_id': loginModel.data.id,

        'language': languageCode
      };

      print('map --> ${map}');

      PetMartService petMartService = PetMartService();
      ShareModel petsModel = await petMartService.sharePet("view","item",widget.postId);
      setState(() {
        noOfViews = "${int.parse(noOfViews)+1}";

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
        print(postDetailsModel.data.items[0].image);

        noOfViews = value.data.items[0].views;
        noOfShares = value.data.items[0].shares;
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
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: kMainColor,
          title: Container(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.h),
              child: Text(
                widget.postName,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: screenUtil.setSp(16),
                    fontWeight: FontWeight.bold

                ),


              ),
            ),
          ),
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);

            },
            child: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,size: 20.h,),
          ),


          actions: [
            SizedBox(width: 30.h,)

          ],

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

                          enableInfiniteScroll: false,
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
                      items: postDetailsModel.data.items[0].image.map((item) =>
                          Stack(

                            children: [
                              GestureDetector(
                                onTap: (){
                                  String url = item.trim();
                                  if(url.isNotEmpty) {
                                    Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                                      return new PhotoScreen(imageProvider: NetworkImage(
                                         KImageUrl+ url
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
                                    imageUrl:'${KImageUrl+item}',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mLanguage =="en"?
                          postDetailsModel.data.items[0].enTitle:postDetailsModel.data.items[0].arTitle,
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: screenUtil.setSp(14),
                              fontWeight: FontWeight.normal

                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            String vedioUrl= postDetailsModel.data.items[0].video;
                            String title = "";
                            if(mLanguage == "en"){
                              title = postDetailsModel.data.items[0].enTitle;
                            }else{
                              title = postDetailsModel.data.items[0].arTitle;
                            }
                            if(vedioUrl.trim()!=""){
                              if(vedioUrl.contains("youtu")){
                                Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                                  return new YouTubeScreen(youtubeId:vedioUrl,auctionName: title);
                                }));
                              }else{
                                Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                                  return new VideoScreen(vedioUrl:vedioUrl,auctionName: title,);
                                }));
                              }

                            }

                          },
                          child: Image.asset('assets/images/play-button.png',
                            height: 30.w,width: 30.w,fit: BoxFit.fill,
                            color:postDetailsModel.data.items[0].video== ""?Color(0xFFAAAAAA):kMainColor ,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.w,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:1,
                          child: Opacity(
                            opacity:  postDetailsModel.data.items[0].price == '0.5'?1.0:0.0,
                            child: Text(
                              '${postDetailsModel.data.items[0].price}',
                              style: TextStyle(
                                  color: kMainColor,
                                  fontSize: screenUtil.setSp(14),
                                  fontWeight: FontWeight.normal

                              ),
                            ),
                          ),
                        ),
                        Expanded(

                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              deleteButton(getTranslated(context, 'delete_post'), context,postDetailsModel.data.items[0].customer),
                              SizedBox(width: 2.h,),
                              previewButton(getTranslated(context, 'edit_post'), context,postDetailsModel.data.items[0].customer),


                            ],
                          ),
                        ),

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
                          "${noOfViews} ${getTranslated(context, 'views')}" ,
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
                            "${noOfShares} ${getTranslated(context, 'shared')}" ,
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
                        print('mobile --> ${postDetailsModel.data.items[0].mobile}');
                        _openUrl(url(postDetailsModel.data.items[0].mobile, ""));

                      },
                      child: Column(

                        children: [
                          Image.asset('assets/images/whatsapp.png',
                            height: 30.h,width: 30.w,color: Color(0xAA1E1F20),
                          )
                          ,
                          Text(
                            "${getTranslated(context, "send_messages")}" ,
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
                      "${getTranslated(context, 'gender')} ${mLanguage == "en"?postDetailsModel.data.items[0].gender:postDetailsModel.data.items[0].genderAr}  " ,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(14),
                          fontWeight: FontWeight.normal

                      ),
                    ),
                    Text(
                      "${getTranslated(context, 'age')} ${postDetailsModel.data.items[0].age} ${mLanguage == "en"?postDetailsModel.data.items[0].ageType:postDetailsModel.data.items[0].ageTypeAr}  " ,
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
                  "${mLanguage == "en"?postDetailsModel.data.items[0].enDetails:postDetailsModel.data.items[0].arDetails}  " ,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: screenUtil.setSp(14),
                      fontWeight: FontWeight.normal

                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );

  }

  share(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool(kIsLogin)??false;
    if(isLoggedIn){
      ShareDialog(context);

    }else{
      ShowLoginAlertDialog(context,getTranslated(context, 'not_login'));
    }

  }
  Future<void> ShowLoginAlertDialog(BuildContext context ,String title) async{
    var alert;
    var alertStyle = AlertStyle(

      animationType: AnimationType.fromBottom,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.normal,
          color: Color(0xFF0000000),
          fontSize: screenUtil.setSp(18)),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.normal,
          fontSize: screenUtil.setSp(16)
      ),
      alertAlignment: AlignmentDirectional.center,
    );
    alert =   Alert(
      context: context,
      style: alertStyle,

      title: title,


      buttons: [

        DialogButton(
          child: Text(
            getTranslated(context, 'ok'),
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();
            Navigator.of(context,rootNavigator: true).pushReplacement(new MaterialPageRoute(builder: (BuildContext context){
              return new LoginScreen();
            }));
            // Navigator.pushReplacementNamed(context,LoginScreen.id);

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        ),
        DialogButton(
          child: Text(
            getTranslated(context, 'no'),
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        ),
      ],
    );
    alert.show();

  }


  void showDialog(Customer contactDetail) {
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
                        '${getTranslated(context, 'contact_for_sell')}',
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
                          imageUrl:KImageUrl+contactDetail.logo,
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
                              postDetailsModel.data.items[0].date.split(" ")[0],
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
                                contactDetail.phone,
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
                        callButton(getTranslated(context, 'call_now'), context, contactDetail.phone.replaceAll('+', ''))
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

  String url(String phone,String message) {
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    }
  }
  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
