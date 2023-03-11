import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/home_model.dart';

import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/push_notification.dart';
import 'package:pet_mart/screens/languagee_screen.dart';
import 'package:pet_mart/screens/login_screen.dart';
import 'package:pet_mart/screens/main_sceen.dart';
import 'package:pet_mart/screens/push_notification_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/utilities/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';

import 'my_message_screen.dart';
import 'notification_details_screen.dart';
class SplashScreen extends StatefulWidget {
  static String id = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  StreamSubscription? sub;
    FirebaseMessaging? _messaging;
  int _counter = 0;
  Future<void> init()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool(kIsLogin)??false;



  }
    @override
  void initState() {
      super.initState();
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        print('remoteMessgae sss${message.toString()}');

        print('remoteMessgae sss${message.toString()}');
        if (message != null) {
          dynamic dataObject=  message.data;
          print('dataObject ---> ${dataObject.toString()}');
          String type = dataObject['push_type'];
          print('type ---> ${type}');
          if (type == 'chatuser'){

              Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                return new MyMessagesScreen();
              }));


          }else if(type == 'rateonuser'){
            String auctionId = dataObject['auction_id'];
            Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
              return new NotificationDetailsScreen(id:auctionId,name: 'Auction Details',);
            }));
          }else{
            home().then((value) {

            }).whenComplete((){
              getLanguageSelected().then((value){
                bool? isSelectLanguage =   value['isSelectLanguage'] ;
                bool? isUserLoginIn =   value['isUserLoginIn'] ;
                if(isSelectLanguage! & isUserLoginIn!){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => MainScreen()));
                }else if(isSelectLanguage & !isUserLoginIn){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => MainScreen()));
                }else if(!isSelectLanguage & !isUserLoginIn){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LanguageScreen()));
                }

              });
            });
          }

        }else{
          home().then((value) {

          }).whenComplete((){
            getLanguageSelected().then((value){
              bool? isSelectLanguage =   value['isSelectLanguage'] ;
              bool? isUserLoginIn =   value['isUserLoginIn'] ;
              if(isSelectLanguage! & isUserLoginIn!){
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => MainScreen()));
              }else if(isSelectLanguage & !isUserLoginIn){
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => MainScreen()));
              }else if(!isSelectLanguage & !isUserLoginIn){
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => LanguageScreen()));
              }



            });
          });
        }
      });



    // Timer(
    //     Duration(seconds: 3),
    //         () {
    //       getLanguageSelected().then((value){
    //         if(value){
    //           Navigator.of(context).pushReplacement(MaterialPageRoute(
    //               builder: (BuildContext context) => MainScreen()));
    //         }else{
    //           Navigator.of(context).pushReplacement(MaterialPageRoute(
    //               builder: (BuildContext context) => LanguageScreen()));
    //         }
    //
    //       });
    //
    //         }
    //
    // );
      }



  Future<Map<String,bool>> getLanguageSelected()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isSelectLanguage = sharedPreferences.getBool("selectLanguage")??false;

    bool isLoggedIn =  sharedPreferences.getBool(kIsLogin)??false;
    Map<String,bool> map ={};
    map['isSelectLanguage'] = isSelectLanguage;
    map['isUserLoginIn'] = isLoggedIn;
    return map;
}
  Future<HomeModel?> home() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? loginData = sharedPreferences.getString(kUserModel);
    String deviceToken =sharedPreferences.getString("token")??"";
    print('loginData --> ${loginData}');
    LoginModel?  loginModel ;
    bool isLoggedIn =  sharedPreferences.getBool(kIsLogin)??false;
    String? id ;
    String? uniqueId;
    if(isLoggedIn){
      String token =deviceToken;
      final body = json.decode(loginData!)??"";
      String fullName = sharedPreferences.getString('email')??"";
      String password= sharedPreferences.getString('password')??"";
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

      PetMartService petMartService = PetMartService();
      String deviceType="";

      if(Platform.isAndroid){
        deviceType = "a";
        uniqueId = await UniqueIdentifier.serial;
      }else{
        deviceType = "i";
        final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
        var data = await deviceInfoPlugin.iosInfo;
        uniqueId = data.identifierForVendor;
      }
      Map<String,dynamic> map = {};
      map['email'] = fullName;
      map['password'] = password;
      map['firebase'] = token;

      dynamic response = await petMartService.loginModel(map);
      bool isOk = response['ok'];

      if(isOk){
        loginModel = LoginModel.fromJson(response);

        SharedPref sharedPref = SharedPref();
        await sharedPref.save(kUserModel, loginModel);

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setBool(kIsLogin,true);
        await sharedPref.saveString("emil", fullName);
        await sharedPref.saveString("password", password);
        id = loginModel.data!.id;
      }else{
        id ="";
        SharedPref sharedPref = SharedPref();
        await sharedPref.save(kUserModel, "");

        await sharedPref.saveBool(kIsLogin, false);
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setBool(kIsLogin,false);
        await sharedPref.saveString("emil", "");
        await sharedPref.saveString("password", "");
      }

    }

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    PetMartService petMartService = PetMartService();

    HomeModel? home = await petMartService.home(id!);
    return home;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Color(0xFFFFFFFF),
        child: Center(

          child: Image.asset('assets/images/img_language_logo.png',height: 200.h,width: 200.w,fit: BoxFit.fill,),
        ),
      ),
    );
  }
}
