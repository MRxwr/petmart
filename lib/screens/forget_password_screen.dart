import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/model/reset_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/login_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/widgets/name_textfield.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String id = 'ForgetPasswordScreen';
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _email ="";
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xFFFFFFFF),
        appBar:
        AppBar(
          backgroundColor: kMainColor,
          title: Container(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.h),
              child: Text(
                'Forget Password',
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
        body: Form(
          key: widget._globalKey,
          child: Container(
            margin: EdgeInsets.all(10.h),
            color: Color(0xFFFFFFFF),
            child: Column(
              children: [
                Center(child: Image.asset('assets/images/img_language_logo.png',height:200.h ,width: 200.w,)),
                 SizedBox(height: 10.h,),
                NameTextField(hint:"Email Address",onClick: (value){
                  _email = value;

                },
                ),
                SizedBox(height: 14.h,),

                Center(
                  child: Text('Enter your email address & we\'ll send you An email message contain new password rest link.',
                    textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.normal,
                    fontSize: screenUtil.setSp(12)
                  ),),
                ),
                SizedBox(height: 25.h,),
                confirmButton('Confirm',context)

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
  void validate(BuildContext context) async{
    if(widget._globalKey.currentState.validate()) {
      widget._globalKey.currentState.save();
      final modelHud = Provider.of<ModelHud>(context,listen: false);
      modelHud.changeIsLoading(true);
      PetMartService petMartService = PetMartService();
      ResetModel resetModel = await petMartService.resetPassword(_email);
      String mStatus = resetModel.status;
      if(mStatus.trim() == 'success'){
        modelHud.changeIsLoading(false);
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(resetModel.message)));
        Navigator.pushReplacementNamed(context,LoginScreen.id);
      }else{
        modelHud.changeIsLoading(false);
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(resetModel.message)));
      }

    }
  }
}


