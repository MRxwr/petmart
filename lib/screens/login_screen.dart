import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/register_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/forget_password_screen.dart';
import 'package:pet_mart/screens/register_screen.dart';
import 'package:pet_mart/screens/verify_otp_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/utilities/shared_prefs.dart';
import 'package:pet_mart/widgets/name_textfield.dart';
import 'package:pet_mart/widgets/password_dialog_textfield.dart';
import 'package:pet_mart/widgets/password_textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../model/error_model.dart';
import 'main_sceen.dart';
class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  String _fullName ="";
  String _password="";
  String token ="";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";
  Future<String> getToken() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String mToken =_preferences.getString("token")??"";
    return mToken;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken().then((value) {
      setState(() {
        token = value;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();

      },
      child: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
            resizeToAvoidBottomInset: false,

          key: _scaffoldKey,
          backgroundColor: Color(0xFFFFFFFF),
          body: Form(
            key: widget._globalKey,
            child: Container(
              margin: EdgeInsets.all(10.h),
              child: Column(
                children: [
                  SizedBox(height: 10.h,),


                  Expanded(flex: 2,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, MainScreen.id);

                        },
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          alignment: AlignmentDirectional.topEnd,
                          child: Text(getTranslated(context, 'skip'),
                          style: TextStyle(
                            color:Color(0xFF000000),
                            fontSize: screenUtil.setSp(16)
                          ),),
                        ),
                      )),
                  Expanded(flex:4,child: Container(
                    child: Center(
                      child:Image.asset('assets/images/img_language_logo.png',height: 150.h,width: 150.w) ,
                    ),

                  )),
                  Expanded(flex: 2,
                      child:  Center(
                        child:
                        NameTextField(hint:getTranslated(context, 'email_address'),onClick: (value){
                          print(value);
                          _fullName= value;
                          setState(() {

                          });
                        },

                        ),
                      )),
                  Expanded(flex: 2,
                      child:  Container(
                        alignment: AlignmentDirectional.center,
                        child:
                        PasswordTextField(hint:getTranslated(context, 'password'),onClick: (value){
                          print(value);
                          setState(() {

                          });
                          _password= value;

                        },
                          mText: _password,
                        ),
                      )),
                  Expanded(flex: 1,
                      child:  GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, ForgetPasswordScreen.id);
                        },
                        child: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text(
                            getTranslated(context, 'forget_password_string'),
                            style: TextStyle(
                              color: Color(0xFF0000000),
                              fontSize: screenUtil.setSp(16),
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                  ),
                  Expanded(flex: 1,
                      child:  Container(
                        alignment: AlignmentDirectional.center,
                        child:
                        LoginButton(getTranslated(context, 'login'),context)
                      )
                  ),
                  Expanded(flex: 4,
                      child:  Container(
                        alignment: AlignmentDirectional.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                           getTranslated(context, 'dont_have_account'),
                              style: TextStyle(
                                  color: Color(0xFF0000000),
                                  fontSize: screenUtil.setSp(16),
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                            SizedBox(width: 4.w,),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed(RegisterScreen.id);
                              },
                              child:
                              Text(
                                getTranslated(context, 'register_now'),
                                style: TextStyle(
                                    color: Color(0xFF0000000),
                                    fontSize: screenUtil.setSp(16),
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Expanded(
                    flex: 2,
                      child: Container())


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  TextButton LoginButton(String text,BuildContext context){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFF000000),
      minimumSize: Size(100.w, 35.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: Color(0xFFFFC300),
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {
validate(context);
      },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
    );
  }
  void validate(BuildContext context) async {

    if(widget._globalKey.currentState.validate()) {
      widget._globalKey.currentState.save();
      final modelHud = Provider.of<ModelHud>(context,listen: false);
      modelHud.changeIsLoading(true);

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

      Map<String, String> map = Map();

      map['email']= _fullName;
      map['password']= _password;

      map['firebase']= token;

      print(map);

      Map<String, dynamic>   response = await petMartService.loginModel(map);
      modelHud.changeIsLoading(false);
      bool  isOk  = response['ok'];
      if (isOk) {
        RegisterModel registerModel = RegisterModel.fromJson(response);

        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerifyOtpScreen(mobile: registerModel.data.mobile,otp: registerModel.data.otp.toString(),userId: registerModel.data.customerId,)));

        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text("success")));
        SharedPref sharedPref = SharedPref();
        await sharedPref.save(kUserModel, registerModel);
        await sharedPref.saveBool(kIsLogin, true);
        await sharedPref.saveString("email", _fullName);
        await sharedPref.saveString("password", _password);
        Navigator.pushReplacementNamed(context,MainScreen.id);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(response);
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text(errorModel.data.msg)));
      }

    }

  }


}


