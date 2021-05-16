import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/credit_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/user_model.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyAccountScreen extends StatefulWidget {
  static String id = 'MyAccountScreen';

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  UserModel userModel;
  CreditModel creditModel;
  ScreenUtil screenUtil = ScreenUtil();
  Future<UserModel> user() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String loginData = _preferences.getString(kUserModel);
    Map map ;


      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      map = {
        "id":loginModel.data.customerId,
        "language":languageCode};





    PetMartService petMartService = PetMartService();
    UserModel userModel = await petMartService.user(map);
    return userModel;
  }
  Future<CreditModel> credit() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String loginData = _preferences.getString(kUserModel);
    Map map ;


    final body = json.decode(loginData);
    LoginModel   loginModel = LoginModel.fromJson(body);
    map = {
      "user_id":loginModel.data.customerId,
      "language":languageCode};





    PetMartService petMartService = PetMartService();
    CreditModel creditModel = await petMartService.credit(map);
    return creditModel;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user().then((value){
      userModel = value;
    }).whenComplete((){
     credit().then((value) {
       setState(() {
         creditModel = value;
       });
     });

    });



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: kMainColor,
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
              'My Account',
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

        ],

      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(

        child: creditModel == null?
        Container(
          child: CircularProgressIndicator(


          ),
          alignment: AlignmentDirectional.center,
        ):
            Container(

              child:
              ListView(
                children: [
                  Container(
                    color: Color(0xFFFFC300),
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Your credits : ${creditModel.data.credit}',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.normal,
                            fontSize: screenUtil.setSp(18)
                          ),),
                          Text('Purchase Credit',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.bold,
                                fontSize: screenUtil.setSp(18)
                            ),)
                          
                        ],
                      ),
                    ),
                  )
                ],
              )
              ,

            )


      ),
    );
  }
}
