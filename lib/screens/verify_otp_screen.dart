import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/otp_model.dart';
import 'package:pet_mart/model/verify_otp_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/login_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart' as Alert;
import 'package:shared_preferences/shared_preferences.dart';

import 'favorite_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  static String id = 'VerifyOtpScreen';
   String mobile="";
   String otp ="";
   String userId ="";

  VerifyOtpScreen({Key? key,required this.mobile,required this.otp,required this.userId}): super(key: key);

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
  StreamController<ErrorAnimationType>?  errorController;

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
    errorController!.close();

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
                getTranslated(context, 'verify_otp')!,
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
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(

                      appContext: context,
                      pastedTextStyle: TextStyle(
                        locale: Locale("en"),
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '*',

                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        otpEntered = v!;
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
                        currentText = v;
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
                  ),
                  SizedBox(height: 20.h,),
                  Center(child: confirmButton(getTranslated(context, 'submit')!,context)),
                  SizedBox(height: 10.h,),
                  GestureDetector(
                    onTap: (){
                      reSendotp(context);
                    },
                    child: Center(child:      Text(
                      getTranslated(context, 'resend_otp')!,
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
      if(formKey.currentState!.validate()) {
        formKey.currentState!.save();
        sendotp(context);


      }else{
        Fluttertoast.showToast(
            msg: getTranslated(context, 'enter_otp')!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: screenUtil.setSp(16)
        );

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

    if (currentText == widget.otp) {
      modelHud.changeIsLoading(false);
      successAlertDialog(context,getTranslated(context, 'success')!);

    }else{
      modelHud.changeIsLoading(false);
      failAlertDialog(context, 'fail');

    }

  }
  void reSendotp(BuildContext context) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeIsLoading(true);


   Map map = Map();
   map['user_id'] =widget.userId;
    map['mobile'] =widget.mobile;

    PetMartService petMartService = PetMartService();
    OtpModel? resp  = await petMartService.verifyOtp(widget.mobile);
    widget.otp = resp!.data!.code.toString();
    print('widget.otp ---> ${widget.otp}');
    print(resp);
    modelHud.changeIsLoading(false);
    Fluttertoast.showToast(
        msg: resp!.data!.response!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: screenUtil.setSp(16)
    );

  }

  Future<void> successAlertDialog(BuildContext context ,String title) async{
    var alert;
    var alertStyle = Alert.AlertStyle(

      animationType: Alert.AnimationType.fromBottom,
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
    alert =  Alert.Alert(
      context: context,
      style: alertStyle,

      title: title,


      buttons: [

        Alert.DialogButton(
          child: Text(
            getTranslated(context, 'ok')!,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();
            SharedPreferences _preferences = await SharedPreferences.getInstance();
            _preferences.setBool('verify', true);
            Navigator.of(context,rootNavigator: true).pushReplacement(new MaterialPageRoute(builder: (BuildContext context){
              return new FavoriteScreen();
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
  Future<void> failAlertDialog(BuildContext context ,String title) async{
    var alert;
    var alertStyle = Alert.AlertStyle(

      animationType: Alert.AnimationType.fromBottom,
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
    alert =   Alert.Alert(
      context: context,
      style: alertStyle,

      title: title,


      buttons: [

        Alert.DialogButton(
          child: Text(
            getTranslated(context, 'ok')!,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        ),

      ],
    );
    alert.show();

  }

}
