import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/register_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/login_screen.dart';
import 'package:pet_mart/screens/terms_screen.dart';
import 'package:pet_mart/screens/verify_otp_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/widgets/name_textfield.dart';
import 'package:pet_mart/widgets/password_textfield.dart';
import 'package:pet_mart/widgets/phone_textfield.dart';
import 'package:pet_mart/widgets/user_name_textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';
class RegisterScreen extends StatefulWidget {
  static String id = 'RegisterScreen';
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  String firstName ='';
  String lastName ='';
  String email ='';
  String password ='';
  String confirmPassword ='';
  String mobileNumber ='';
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                'Register',
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
        body: Form(
          key: widget._globalKey,
          child: Container(
            margin: EdgeInsets.all(10.h),
            child: ListView(
              children: [
                UserNameTextField(hint:"First Name",onClick: (value){
                  firstName = value;

                },
                ),
                SizedBox(height: 10.h,),
                UserNameTextField(hint:"Last Name",onClick: (value){
                  lastName = value;

                },
                ),
                SizedBox(height: 10.h,),
                NameTextField(hint:"Email Address",onClick: (value){
                  email = value;

                },
                ),
                SizedBox(height: 10.h,),
                PasswordTextField(hint:"Password",onClick: (value){
                  password= value;

                },
                ),
                SizedBox(height: 10.h,),
                PasswordTextField(hint:"Confirm Password",onClick: (value){
                  confirmPassword = value;

                },
                ),
                SizedBox(height: 10.h,),
                PhoneTextField(hint:"Mobile Number",onClick: (value){
                  mobileNumber = value;

                },
                ),
                SizedBox(height: 10.h,),
                Center(child: confirmButton('Create Account',context)),
                SizedBox(height: 10.h,),

                Center(
                  child:
                  Text('On click of create Account by default you',
                    textAlign: TextAlign.center,
                    maxLines: 1,

                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                        fontSize: screenUtil.setSp(12)
                    ),),
                ),
                Center(
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('are agreed with  ',
                        textAlign: TextAlign.center,
                        maxLines: 1,

                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.normal,
                            fontSize: screenUtil.setSp(12)
                        ),),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(TermsScreen.id);
                        },
                        child: Text('Terms and Conditions',
                          textAlign: TextAlign.center,
                          maxLines: 1,

                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                              fontSize: screenUtil.setSp(12)
                          ),),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                Center(
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already Registered ? ',
                        textAlign: TextAlign.center,
                        maxLines: 1,

                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.normal,
                            fontSize: screenUtil.setSp(16)
                        ),),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushReplacementNamed(LoginScreen.id);
                        },
                        child: Text('Login Now',
                          textAlign: TextAlign.center,
                          maxLines: 1,

                          style: TextStyle(

                              color: Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                              fontSize: screenUtil.setSp(16)
                          ),),
                      ),
                    ],
                  ),
                ),
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
      minimumSize: Size(120.w, 35.h),
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
  void validate(BuildContext context)  async{
    print('confirmPassword  ${confirmPassword}');
    print('Password  ${password}');
    if(widget._globalKey.currentState.validate()) {
      widget._globalKey.currentState.save();
      if (confirmPassword == password) {
        final modelHud = Provider.of<ModelHud>(context, listen: false);
        modelHud.changeIsLoading(true);
        String deviceToken = "testtest";

        SharedPreferences _preferences = await SharedPreferences.getInstance();
        String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
        String deviceType = "";

        if(Platform.isAndroid){
          deviceType = "a";
          uniqueId = await UniqueIdentifier.serial;
        }else{
          deviceType = "i";
          final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
          var data = await deviceInfoPlugin.iosInfo;
          uniqueId = data.identifierForVendor;
        }
        PetMartService petMartService = PetMartService();
        Map map = {
          'firstname': firstName,
          'lastname': lastName,
          'email': email,
          'password': password,
          're_type_password': confirmPassword,
          'mobile': mobileNumber,
          "date_of_birth": "17-12-1990",
          "country": "Kuwait",
          "device_token": deviceToken,
          "imei_number": uniqueId,
          "device_type": deviceType,
          "language": languageCode
        };
        print(map);

        RegisterModel registerModel = await petMartService.register(map);
        String mStatus = registerModel.status;
        if (mStatus.trim() == 'success') {
          modelHud.changeIsLoading(false);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerifyOtpScreen(mobile: registerModel.data.mobile,otp: registerModel.data.otp.toString(),userId: registerModel.data.customerId,)));

          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(registerModel.message)));
        } else {
          modelHud.changeIsLoading(false);
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(registerModel.message)));
        }
      }
    }else{
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Password Not equal")));
    }
  }

}
