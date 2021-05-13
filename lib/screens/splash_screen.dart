import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/home_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/screens/languagee_screen.dart';
import 'package:pet_mart/screens/main_sceen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    if(loginData != null){

      final body = json.decode(loginData);
      loginModel = LoginModel.fromJson(body);
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
