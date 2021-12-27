

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/init_model.dart';
import 'package:pet_mart/utilities/call_services.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/utilities/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUsScreen extends StatefulWidget {
  static String id = 'ContactUsScreen';
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  String _platformVersion = 'Unknown';
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();

  Future<InitModel> init() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String initData = sharedPreferences.getString("initModel");
    print('initData --> ${initData}');
    final initBody = json.decode(initData);
    InitModel initModel = InitModel.fromJson(initBody);
    return initModel;
  }
  InitModel initModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init().then((value) {
      setState(() {
        initModel = value;
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
     return Scaffold(
       backgroundColor: Color(0xFFFFFFFF),

      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
              getTranslated(context, 'contact_us'),
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
       body: initModel == null?
       Container(
         child: CircularProgressIndicator(


         ),
         alignment: AlignmentDirectional.center,
       ):
       Container(
         child: Column(
           children: [
             Expanded(
                 flex:1,
                 child:Container(
                   child: Center(
                     child: Container(
                         height: 150.h,
                         width: 150.h,
                         child: Image.asset('assets/images/img_language_logo.png')),
                   ),
                 ) ),
             Expanded(
               flex: 1,
               child: Container(
                 child: Column(
                   children: [
                     Padding(
                       padding:  EdgeInsets.all(2.0.h),
                       child: Text(getTranslated(context, 'support'),
                       style: TextStyle(
                         color: Color(0xFF000000),
                         fontSize: screenUtil.setSp(18),
                         fontWeight: FontWeight.bold
                       ),),
                     ),
                     GestureDetector(
                       onTap: (){
                         _service.sendEmail(initModel.data.email);
                       },
                       child: Padding(
                         padding:  EdgeInsets.all(2.0.h),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(getTranslated(context, 'email'),
                               style: TextStyle(
                                   color: Color(0xFF000000),
                                   fontSize: screenUtil.setSp(18),
                                   fontWeight: FontWeight.bold
                               ),),
                             SizedBox(width: 4.w),
                             Text(initModel.data.email,
                               style: TextStyle(
                                   color: Color(0xFF000000),
                                   fontSize: screenUtil.setSp(18),
                                   fontWeight: FontWeight.normal
                               ),),
                           ],
                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         _service.call(initModel.data.mobile);


                       },
                       child: Padding(
                         padding:  EdgeInsets.all(2.0.h),
                         child:
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(getTranslated(context, 'call'),
                               style: TextStyle(
                                   color: Color(0xFF000000),
                                   fontSize: screenUtil.setSp(18),
                                   fontWeight: FontWeight.bold
                               ),),
                             SizedBox(width: 4.w),
                             Text(initModel.data.mobile,
                               style: TextStyle(
                                   color: Color(0xFF000000),
                                   fontSize: screenUtil.setSp(18),
                                   fontWeight: FontWeight.normal
                               ),),
                           ],
                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                         _openUrl(url(initModel.data.mobile, ""));

                       },
                       child: Padding(
                         padding:  EdgeInsets.all(2.0.h),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(getTranslated(context,'whatsapp'),
                               style: TextStyle(
                                   color: Color(0xFF000000),
                                   fontSize: screenUtil.setSp(18),
                                   fontWeight: FontWeight.bold
                               ),),
                             SizedBox(width: 4.w),
                             Text(initModel.data.mobile,
                               style: TextStyle(
                                   color: Color(0xFF000000),
                                   fontSize: screenUtil.setSp(18),
                                   fontWeight: FontWeight.normal
                               ),),
                           ],
                         ),
                       ),
                     ),

                   ],
                 ),

               ),
             )
           ],
         ),
       ),
    );
  }
  Future<void> _launched;


  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  String url(String phone,String message) {
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$phone/?text=+${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=+$phone=${Uri.parse(message)}"; // new line
    }
  }
  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
