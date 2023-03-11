import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/notification_model.dart';
import 'package:pet_mart/model/notify_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/providers/notification_count.dart';
import 'package:pet_mart/screens/notification_details_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_auction_details.dart';
class PushNotificationScreen extends StatefulWidget {
  static String id = 'PushNotificationScreen';
  @override
  _PushNotificationScreenState createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  bool status = false;
  String language = "";
  Future<Map<String, dynamic>> getNotificationList()async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    language = languageCode;
    status = _preferences.getBool("enable")??true;
    String? loginData = _preferences.getString(kUserModel);
    final body = json.decode(loginData!);
    LoginModel   loginModel = LoginModel.fromJson(body);
    PetMartService petMartService = PetMartService();
    Map map = {
      "id":loginModel.data!.id,
      "language":languageCode
    };
    Map<String, dynamic> response =await petMartService.notification(loginModel.data!.id!);
    bool  isOk  = response['ok'];
    if (isOk) {
      NotificationModel notificationModel = NotificationModel.fromJson(response);

      Provider.of<NotificationNotifier>(context,listen: false).addCount(int.parse(notificationModel.data!.total!));
    }

    // try {
    //   bool res = await FlutterAppBadger.isAppBadgeSupported();
    //   if (res) {
    //     FlutterAppBadger.updateBadgeCount(0);
    //     FlutterAppBadger.removeBadge();
    //     appBadgeSupported = 'Supported';
    //   } else {
    //     appBadgeSupported = 'Not supported';
    //   }
    // } on PlatformException {
    //   appBadgeSupported = 'Failed to get badge support.';
    // }
    return response;
  }
  String isOkey="";
  NotificationModel? notificationModel;
  Map<String, dynamic> ?  response;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationList().then((value){

      setState(() {
        response = value;
        bool  isOk  = response!['ok'];
        if (isOk) {
          isOkey = "1";
           notificationModel = NotificationModel.fromJson(response!);
        }else{
          isOkey = "0";
        }
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
                getTranslated(context, 'push_notification')!,
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
                 getTranslated(context, 'turn_off_push')!,
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
                      onToggle: (val)  async{
                        // notify(val);

                        SharedPreferences _preferences = await SharedPreferences.getInstance();
                        _preferences.setBool("enable", true);
                        status = val;
                        setState(() {

                        });

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
                child:  isOkey == ""?
                Container(
                  child: CircularProgressIndicator(


                  ),
                  alignment: AlignmentDirectional.center,
                ):
                Container(
                  child: isOkey == "0"?
                  Container(
                    child: Text(
                      getTranslated(context, 'no_notification_available')!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    alignment: AlignmentDirectional.center,
                  )
                      :
                  ListView.separated(
                      scrollDirection: Axis.vertical,


                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return
                          GestureDetector(
                            onTap: () async{
                            String auctionId = notificationModel!.data!.notification![index].auctionId.toString();
                            if(auctionId.trim() !="0") {
                              String auctionType = notificationModel!.data!
                                  .notification![index].auctionType!;
                              if (auctionType == "1") {
                                String results = await Navigator.of(
                                    context, rootNavigator: true).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return new MyAuctionDetails(
                                              id: auctionId,
                                              postName: getTranslated(
                                                  context, 'auction_details')!);
                                        }));
                                if (results == "true") {
                                  isOkey = "";
                                  setState(() {

                                  });
                                  getNotificationList().then((value) {
                                    setState(() {
                                      response = value;
                                      bool isOk = response!['ok'];
                                      if (isOk) {
                                        isOkey = "1";
                                        notificationModel =
                                            NotificationModel.fromJson(
                                                response!);
                                      } else {
                                        isOkey = "0";
                                      }
                                    });
                                  });
                                }
                              }
                              else if (auctionType == "2") {
                                String results = await Navigator.of(
                                    context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return new NotificationDetailsScreen(
                                            id: auctionId,
                                            name: getTranslated(
                                                context, 'auction_details')!,);
                                        }));
                                if (results == "true") {
                                  isOkey = "";
                                  setState(() {

                                  });
                                  getNotificationList().then((value) {
                                    setState(() {
                                      response = value;
                                      bool isOk = response!['ok'];
                                      if (isOk) {
                                        isOkey = "1";
                                        notificationModel =
                                            NotificationModel.fromJson(
                                                response!);
                                      } else {
                                        isOkey = "0";
                                      }
                                    });
                                  });
                                }
                              } else if (auctionType == "0") {
                                print(auctionType);
                              }
                            }
                            },

                            child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 6.h),
                            height: 100.h,
                            width: screenUtil.screenWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    notificationModel!.data!.notification![index].date!.split(" ")[0],
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(14),
                                        fontWeight: FontWeight.bold

                                    )),
                                Text(
                                    notificationModel!.data!.notification![index].notification!,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(12),
                                        fontWeight: FontWeight.normal

                                    ))
                              ],
                            ),
                        ),
                          );
                      }, separatorBuilder:  (context,index){
                    return Container(height: 1.h,
                      color: Colors.grey[400],);
                  }, itemCount: notificationModel!.data!.notification!.length),
                ),
              )

            ],
          ),

        ),
    ),
      );
  }

}
