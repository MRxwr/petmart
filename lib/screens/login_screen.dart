import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/forget_password_screen.dart';
import 'package:pet_mart/screens/register_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/utilities/shared_prefs.dart';
import 'package:pet_mart/widgets/name_textfield.dart';
import 'package:pet_mart/widgets/password_dialog_textfield.dart';
import 'package:pet_mart/widgets/password_textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';

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
  String token ="soksokfojrr3wow";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
      child: Scaffold(
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
                    child: Center(
                      child: Container(
                        alignment: AlignmentDirectional.topEnd,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, MainScreen.id);
                          },
                          child: Text('Skip',
                          style: TextStyle(
                            color:Color(0xFF000000),
                            fontSize: screenUtil.setSp(16)
                          ),),
                        ),
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
                      NameTextField(hint:"Email Address",onClick: (value){
                        _fullName= value;

                      },
                      ),
                    )),
                Expanded(flex: 2,
                    child:  Container(
                      alignment: AlignmentDirectional.center,
                      child:
                      PasswordTextField(hint:"Password",onClick: (value){
                        _password= value;

                      },
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
                          'Forget Password?',
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
                      LoginButton('Login',context)
                    )
                ),
                Expanded(flex: 4,
                    child:  Container(
                      alignment: AlignmentDirectional.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have account?',
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
                              'Register Now',
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
      Map map = {
        'email':_fullName,
        'password':_password,
        'device_token':token,
        'imei_number': uniqueId,
        'device_type': deviceType,
        'language':languageCode


      };
      LoginModel loginModel = await petMartService.loginModel(map);
      String mStatus = loginModel.status;
      if(mStatus.trim() == 'success'){
        SharedPref sharedPref = SharedPref();
        await sharedPref.save(kUserModel, loginModel);
        await sharedPref.saveBool(kIsLogin, true);
        modelHud.changeIsLoading(false);
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(loginModel.message)));
        Navigator.pushReplacementNamed(context,MainScreen.id);


      }else{
        modelHud.changeIsLoading(false);
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(loginModel.message)));
      }
    }

  }


}

