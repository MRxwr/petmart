import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/model/ServiceDetailsModel.dart';
import 'package:pet_mart/screens/photo-screen.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/pet_mart_service.dart';
import '../localization/localization_methods.dart';
import '../model/share_model.dart';
import '../providers/model_hud.dart';
import '../utilities/call_services.dart';
import '../utilities/constants.dart';
import '../utilities/service_locator.dart';
import 'login_screen.dart';
class ServiceDetailsScreen extends StatefulWidget {
  String id;
  String name;
  ServiceDetailsScreen({Key key,@required this.id,@required this.name}): super(key: key);

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  String mLanguage;

  ServiceDetailsModel hospitalDetailsModel;
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  ScreenUtil screenUtil = ScreenUtil();
  Future<ServiceDetailsModel> getHospitals()async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    PetMartService petMartService = PetMartService();
    ServiceDetailsModel hospitalModel =await petMartService.serviceDetails(widget.id);
    ShareModel petsModel = await petMartService.sharePet("view","hospital",widget.id);
    return hospitalModel;
  }
  String noOfShares="";
  String noOfViews ="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHospitals().then((value) {
      setState(() {
        hospitalDetailsModel = value;
        noOfShares = hospitalDetailsModel.data.services[0].shares;
        noOfViews = hospitalDetailsModel.data.services[0].views;
        noOfViews = "${int.parse(noOfViews)+1}";
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return
      ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
          appBar:  AppBar(
            backgroundColor: kMainColor,
            title: Container(
              alignment: AlignmentDirectional.center,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.h),
                child: Text(
                  widget.name,
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
              child: hospitalDetailsModel == null?
              Container(
                child: CircularProgressIndicator(


                ),
                alignment: AlignmentDirectional.center,
              ):
              Container(
                margin: EdgeInsets.all(10.w),
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: (){
                        String url = KImageUrl+hospitalDetailsModel.data.services[0].logo;
                        if(url.isNotEmpty) {
                          Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                            return new PhotoScreen(imageProvider: NetworkImage(
                                '${KImageUrl+hospitalDetailsModel.data.services[0].logo}'
                            ),);
                          }));
                        }
                      },
                      child: Container(
                        width: screenUtil.screenWidth,
                        height: 150.h,
                        child: CachedNetworkImage(
                          width: screenUtil.screenWidth,
                          height: 150.h,

                          fit: BoxFit.fill,
                          imageUrl:'${KImageUrl+hospitalDetailsModel.data.services[0].logo}',
                          imageBuilder: (context, imageProvider) => Container(
                              width: screenUtil.screenWidth,


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
                                      height: 150.h,
                                      width: screenUtil.screenWidth,


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
                              height: 150.h,
                              width: screenUtil.screenWidth,
                              alignment: FractionalOffset.center,
                              child: Icon(Icons.image_not_supported)),

                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        children: [

                          Text(
                            widget.name,
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: screenUtil.setSp(18),
                                fontWeight: FontWeight.normal
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          callButton(getTranslated(context, 'call_now'),context),

                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(mLanguage=="en"?hospitalDetailsModel.data.services[0].enDetails:
                      hospitalDetailsModel.data.services[0].arDetails,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: screenUtil.setSp(18),
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h,
                      width: screenUtil.screenWidth,
                      child: Container(
                        color: Color(0x88AAAAAA),
                      ),),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: (){
                              share(context);

                            },
                            child: Column(
                              children: [
                                Image(
                                  image: new AssetImage("assets/images/share.png"),
                                  width: 30.w,
                                  height: 30.h,
                                  color: Color(0xFF000000),
                                  fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                ),
                                Text(
                                  '${noOfShares} ${getTranslated(context, 'shares')}',
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: screenUtil.setSp(18),
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Image(
                                image: new AssetImage("assets/images/img_view.png"),
                                width: 30.w,
                                height: 30.h,
                                color: Color(0xFF000000),
                                fit: BoxFit.fill,
                                alignment: Alignment.center,
                              ),
                              Text(
                                "${noOfViews} ${getTranslated(context, 'views')}",
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: screenUtil.setSp(18),
                                    fontWeight: FontWeight.normal
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.h,
                      width: screenUtil.screenWidth,
                      child: Container(
                        color: Color(0x88AAAAAA),
                      ),),
                  ],
                ),
              )
          ),
        ),
      );
  }
  TextButton callButton(String text,BuildContext context){
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
        _service.call(hospitalDetailsModel.data.services[0].mobile.replaceAll('+', ''));


      },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
    );
  }
  TextButton details(String text,BuildContext context){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: kMainColor,
      minimumSize: Size(65.w, 35.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: kMainColor,
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {



      },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
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
            ShareHospital();
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
  Future<void> ShareHospital() async{

    String description;
    String title;
    if (mLanguage == 'ar') {
      description = hospitalDetailsModel.data.services[0].arDetails;
      title = hospitalDetailsModel.data.services[0].arTitle;
    } else {
      description = hospitalDetailsModel.data.services[0].enDetails;;
      title = hospitalDetailsModel.data.services[0].enTitle;
    }
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeIsLoading(true);


    PetMartService petMartService = PetMartService();
    ShareModel petsModel = await petMartService.sharePet("share","hospital",hospitalDetailsModel.data.services[0].id);
    setState(() {
      noOfShares = "${int.parse(noOfShares)+1}";

    });
    modelHud.changeIsLoading(false);
    if (Platform.isIOS) {
      Share.share(
          '${title}' '\n ${description}' '\n market://details?id=com.createq8.petMart');
    } else {
      Share.share(
          '${title}' '\n ${description}' '\n https://play.google.com/store/apps/details?id=com.createq8.petMart');
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
            getTranslated(context, 'reg_now'),
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

      ],
    );
    alert.show();

  }
}
