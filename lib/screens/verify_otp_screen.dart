import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/verify_otp_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/login_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyOtpScreen extends StatefulWidget {
  static String id = 'VerifyOtpScreen';
   String mobile="";
   String otp ="";
   String userId ="";

  VerifyOtpScreen({Key key,@required this.mobile,@required this.otp,@required this.userId}): super(key: key);

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  String otpEntered = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>  errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }
  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
      child: Scaffold(
        key: _scaffoldKey,
        appBar:  AppBar(
          backgroundColor: kMainColor,
          title: Container(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.h),
              child: Text(
                'Verify Otp',
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
        body:
        Form(
          key: formKey,
          child:
          Padding(
              padding:  EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 30),
              child:
              Column(
                children: [
                  PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '*',

                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      otpEntered = v;
                     if(v == 6){
                       sendotp(context);
                     }
                    },
                    pinTheme: PinTheme(

                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor:
                      hasError ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF),
                    ),
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Color(0xFFFFFFFF),
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      print("Completed");
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  SizedBox(height: 20.h,),
                  Center(child: confirmButton('Sumbit',context)),
                  SizedBox(height: 10.h,),
                  GestureDetector(
                    onTap: (){
                      reSendotp(context);
                    },
                    child: Center(child:      Text(
                      'Resend OTP',
                      style: TextStyle(
                          color: Color(0xFF0000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.normal
                      ),
                    )),
                  ),
                ],
              )),
        ),

      ),
    );
  }
  TextButton confirmButton(String text,BuildContext context){
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
      if(formKey.currentState.validate()) {
        formKey.currentState.save();
        sendotp(context);


      }else{
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text("Please Enter Otp ")));
      }

        // validate(context);
      },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
    );
  }

  void sendotp(BuildContext context) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeIsLoading(true);
    Map map = {
      'user_id': widget.userId,
      'otp': widget.otp,
      'mobile': widget.mobile,
      'language': languageCode
    };
    PetMartService petMartService = PetMartService();
    VerifyOtpModel verifyOtpModel = await petMartService.verifyOtp(map);
    String mStatus = verifyOtpModel.status;
    if (mStatus.trim() == 'success') {
      modelHud.changeIsLoading(false);
      Navigator.of(context).pushReplacementNamed(LoginScreen.id);
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(verifyOtpModel.message)));
    }else{
      modelHud.changeIsLoading(false);
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(verifyOtpModel.message)));
    }

  }
  void reSendotp(BuildContext context) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeIsLoading(true);

    String url = 'http://api.smart2group.net/api/send.aspx?username=petmart&password=jvZ8sbsubBAA3w&language=1&sender=Pet%20Mart&mobile=+965${widget.mobile}&message=${widget.otp} is your verification code for petmart App ';


    PetMartService petMartService = PetMartService();
    String resp  = await petMartService.resendOtp(url);
    print(resp);
    modelHud.changeIsLoading(false);

    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Otp Send SuccessFully')));
  }
}
