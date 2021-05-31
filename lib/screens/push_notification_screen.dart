import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/notification_model.dart';
import 'package:pet_mart/model/notify_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PushNotificationScreen extends StatefulWidget {
  static String id = 'PushNotificationScreen';
  @override
  _PushNotificationScreenState createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  bool status = false;
  Future<NotificationModel> getNotificationList()async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    status = _preferences.getBool("enable")??false;
    String loginData = _preferences.getString(kUserModel);
    final body = json.decode(loginData);
    LoginModel   loginModel = LoginModel.fromJson(body);
    PetMartService petMartService = PetMartService();
    Map map = {
      "id":loginModel.data.customerId,
      "language":languageCode
    };
    NotificationModel notificationModel =await petMartService.notification(map);
    return notificationModel;
  }
  NotificationModel notificationModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationList().then((value){
      setState(() {
        notificationModel = value;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return 
      ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
        appBar:
        AppBar(
          backgroundColor: kMainColor,
          title: Container(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.h),
              child: Text(
                'Push Notification',
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
        body: Container(
          child: ListView(
            children: [
              Container(
                height: 50.h,
                width: screenUtil.screenWidth,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Text(
                  'TURN OFF PUSH NOTIFICATION',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: screenUtil.setSp(16),
                      fontWeight: FontWeight.normal

                  )),
                    FlutterSwitch(
                      activeColor: kMainColor,
                      inactiveColor: Colors.grey,
                      width: 90.0.w,
                      height: 35.0.h,
                      valueFontSize: 25.0,
                      toggleSize: 45.0,
                      value: status,
                      borderRadius: 30.0,
                      padding: 8.0,
                      showOnOff: false,
                      onToggle: (val)  {
                        notify(val);

                      },
                    ),

                  ],
                ),
              ),
              Container(
                width: screenUtil.screenWidth,
                height: 1.h,
                color: Colors.grey[400],
              ),
              Container(
                child:  notificationModel == null?
                Container(
                  child: CircularProgressIndicator(


                  ),
                  alignment: AlignmentDirectional.center,
                ): ListView.separated(
                    scrollDirection: Axis.vertical,


                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 6.h),
                        height: 100.h,
                        width: screenUtil.screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                notificationModel.data[index].date,
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: screenUtil.setSp(14),
                                    fontWeight: FontWeight.bold

                                )),
                            Text(
                                notificationModel.data[index].message,
                                style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: screenUtil.setSp(12),
                                    fontWeight: FontWeight.normal

                                ))
                          ],
                        ),
                      );
                    }, separatorBuilder:  (context,index){
                  return Container(height: 1.h,
                    color: Colors.grey[400],);
                }, itemCount: notificationModel.data.length),
              )

            ],
          ),

        ),
    ),
      );
  }
  Future<void> notify(bool isNotify)async{
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.changeIsLoading(true);
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    status = _preferences.getBool("enable")??false;
    String loginData = _preferences.getString(kUserModel);
    final body = json.decode(loginData);
    LoginModel   loginModel = LoginModel.fromJson(body);
    PetMartService petMartService = PetMartService();
    String state = "";
    if(isNotify){
      state = "1";
    }else{
      state = "0";
    }
    Map map = {
      "user_id":loginModel.data.customerId,
      "is_notify":state,
      "language":languageCode
    };

    NotifyModel notifyModel =await petMartService.notify(map);
    String  success = notifyModel.status;
    modelHud.changeIsLoading(false);
    if(success == 'success'){
      SharedPreferences prefs =  await SharedPreferences.getInstance();
      prefs.setBool("enable", isNotify);
      setState(() {
        status = isNotify;
      });

    }

  }
}
