import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/change_password_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/utilities/shared_prefs.dart';
import 'package:pet_mart/widgets/password_textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ChangePasswordScreen extends StatefulWidget {
  static String id = 'ChangePasswordScreen';
  const ChangePasswordScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  String oldPassword;
  String newPassword;
  String confirmPassword;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return
      ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
          key: _scaffoldKey,
        appBar:
        AppBar(
          backgroundColor: kMainColor,
          title: Container(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.h),
              child: Text(
                getTranslated(context, 'change_password'),
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
        body:
        Form(
          key: _globalKey,
          child: Container(
            margin: EdgeInsets.all(10.h),
            child:
            ListView(
              children: [
                PasswordTextField(hint:getTranslated(context, 'old_password'),onClick: (value){
                  oldPassword = value;

                },
                ),
                SizedBox(height: 10.h,),
                PasswordTextField(hint:getTranslated(context, 'new_password'),onClick: (value){
                  newPassword = value;

                },
                ),
                SizedBox(height: 10.h,),
                PasswordTextField(hint:getTranslated(context, 'confirm_password'),onClick: (value){
                  confirmPassword = value;

                },
                ),
                SizedBox(height: 10.h,),
                Center(child: confirmButton(getTranslated(context, 'change_password'),context))
              ],
            ),
          ),
        ),
    ),
      );
  }
  TextButton confirmButton(String text,BuildContext context){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFF000000),
      minimumSize: Size(120.w, 50.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: Color(0xFFFFC300),
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {
      if(_globalKey.currentState.validate()) {
        _globalKey.currentState.save();
        if (confirmPassword == newPassword) {
          validate();

        }else{
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(getTranslated(context, 'password_not_equal'))));
        }
      }

      },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
    );
  }
  void validate() async{
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeIsLoading(true);
    PetMartService petMartService = PetMartService();
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    String loginData = _preferences.getString(kUserModel);
    Map map;

    final body = json.decode(loginData);
    LoginModel   loginModel = LoginModel.fromJson(body);
     map = {
      'id': loginModel.data.customerId,
      'password': oldPassword,
      'new_password': newPassword,
      'language': languageCode};
     ChangePasswordModel changePasswordModel = await petMartService.changePassword(map);

    modelHud.changeIsLoading(false);
     String status = changePasswordModel.status;
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text(changePasswordModel.message)));
     if(status == 'success'){
       SharedPref sharedPref = SharedPref();
       await sharedPref.saveString("password", newPassword);
       Navigator.pop(context);
     }
  }

}
