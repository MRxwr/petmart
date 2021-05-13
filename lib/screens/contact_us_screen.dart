

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/utilities/call_services.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/utilities/service_locator.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUsScreen extends StatefulWidget {
  static String id = 'ContactUsScreen';
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  String _platformVersion = 'Unknown';
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterOpenWhatsapp.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
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
              'Contact Us',
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
       body: Container(
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
                       child: Text('For support please contact :',
                       style: TextStyle(
                         color: Color(0xFF000000),
                         fontSize: screenUtil.setSp(18),
                         fontWeight: FontWeight.bold
                       ),),
                     ),
                     GestureDetector(
                       onTap: (){
                         _service.sendEmail('info@petmart.com');
                       },
                       child: Padding(
                         padding:  EdgeInsets.all(2.0.h),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text('Email :',
                               style: TextStyle(
                                   color: Color(0xFF000000),
                                   fontSize: screenUtil.setSp(18),
                                   fontWeight: FontWeight.bold
                               ),),
                             SizedBox(width: 4.w),
                             Text('info@petmart.com',
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
                         _service.call('+9656124578');


                       },
                       child: Padding(
                         padding:  EdgeInsets.all(2.0.h),
                         child:
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text('Call :',
                               style: TextStyle(
                                   color: Color(0xFF000000),
                                   fontSize: screenUtil.setSp(18),
                                   fontWeight: FontWeight.bold
                               ),),
                             SizedBox(width: 4.w),
                             Text('+9656124578',
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
                         _openUrl(url("9656124578", ""));

                       },
                       child: Padding(
                         padding:  EdgeInsets.all(2.0.h),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text('WhatsApp :',
                               style: TextStyle(
                                   color: Color(0xFF000000),
                                   fontSize: screenUtil.setSp(18),
                                   fontWeight: FontWeight.bold
                               ),),
                             SizedBox(width: 4.w),
                             Text('+9656124578',
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

  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
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
      return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
    }
  }
}
