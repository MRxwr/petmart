import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/screens/main_sceen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
class LanguageScreen extends StatefulWidget {
  static String id = 'LanguageScreen';

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  ScreenUtil screenUtil = ScreenUtil();

@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFFFFFF),
        child: Column(
          children: [
            Expanded(flex: 6,
            child:
            Center(child: Image.asset('assets/images/img_language_logo.png',height:200.h ,width: 200.w,)),),
            Expanded(flex:4,child: 
            Container(
              color: Color(0xFFFFFFFF),
              child:
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.h),
                    alignment: AlignmentDirectional.topStart,
                    child: Text(getTranslated(context, 'select_language')!
                      ,
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: screenUtil.setSp(18),
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex:1,
                                child: previewButton(getTranslated(context, 'english')!,context)),
                    SizedBox(width: 20.w,),
                    Expanded(flex: 1,
                        child: previewButton(getTranslated(context, 'arabic')!,context))
                      ]
                        )

                      ],
                    ),
                  )
                ],
              ),
              
            )
            
            )
          ],
        ),
      ),
    );
  }
  TextButton previewButton(String text,BuildContext context){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFF000000),
      minimumSize: Size(88.w, 35.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: Color(0xFFFFC300),
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {
       if(text == 'English'){
         _changeLanguage('en').then((value) {
           Navigator.of(context).pushReplacementNamed( MainScreen.id);
         });
       }else {
         _changeLanguage('ar').then((value) {
           Navigator.of(context).pushReplacementNamed( MainScreen.id);

         });
       }
      },
      child: Text(text,style: TextStyle(
        color: Color(0xFF000000),
        fontSize: screenUtil.setSp(14),
        fontWeight: FontWeight.w500
      ),),
    );
  }
  Future<void> _changeLanguage(String language) async {
    Locale _temp = await setLocale( language);
    MyApp.setLocale(context, _temp);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("selectLanguage", true);




  }
}
