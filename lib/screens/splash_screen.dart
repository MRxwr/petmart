import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/home_model.dart';
import 'package:pet_mart/model/init_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/screens/languagee_screen.dart';
import 'package:pet_mart/screens/main_sceen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/utilities/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';
class SplashScreen extends StatefulWidget {
  static String id = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription sub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    home().then((value) {

    }).whenComplete((){
      getLanguageSelected().then((value){
        if(value){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => MainScreen()));
        }else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LanguageScreen()));
        }

      });
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
Future<bool> getLanguageSelected()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("selectLanguage")??false;
}
  Future<HomeModel> home() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String loginData = sharedPreferences.getString(kUserModel);
    print('loginData --> ${loginData}');
    LoginModel  loginModel = null;
    String uniqueId;
    if(loginData != null){
      String token ="soksokfojrr3wow";
      final body = json.decode(loginData);
      String fullName = sharedPreferences.getString('email');
      String password= sharedPreferences.getString('password');
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
      Map map = {
        'email':fullName,
        'password':password,
        'device_token':token,
        'imei_number': uniqueId,
        'device_type': deviceType,
        'language':languageCode


      };
       loginModel = await petMartService.loginModel(map);
      String mStatus = loginModel.status;
      if(mStatus.trim() == 'success') {
        SharedPref sharedPref = SharedPref();
        await sharedPref.save(kUserModel, loginModel);
        await sharedPref.saveBool(kIsLogin, true);
        await sharedPref.saveString("emil", fullName);
        await sharedPref.saveString("password", password);
      }
    }

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
    InitModel initModel = await petMartService.init();
    SharedPref sharedPref = SharedPref();
    await sharedPref.save('initModel', initModel);
    HomeModel home = await petMartService.home(map);
    return home;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: kMainColor,
        child: Center(

          child: Image.asset('assets/images/splash_logo.png'),
        ),
      ),
    );
  }
}
