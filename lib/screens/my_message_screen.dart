import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/my_message_model.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'message_screen.dart';
class MyMessagesScreen extends StatefulWidget {
  const MyMessagesScreen({Key key}) : super(key: key);

  @override
  _MyMessagesScreenState createState() => _MyMessagesScreenState();
}

class _MyMessagesScreenState extends State<MyMessagesScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  LoginModel   loginModel;
  MyMessageModel messageModel;
  Future<MyMessageModel> getMessages()async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    String loginData = _preferences.getString(kUserModel);
    final body = json.decode(loginData);
       loginModel = LoginModel.fromJson(body);
    PetMartService petMartService = PetMartService();

    Map map ;
    map ={"user_id":loginModel.data.customerId,
    "language":languageCode};
    MyMessageModel messageModel =await petMartService.myMessages(map);
    return messageModel;
  }
  String status = "";
  String messaage = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessages().then((value) {
      setState(() {
        status = value.status;
        messaage = value.message;

        messageModel = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();

      },
      child: Scaffold(
        appBar:  AppBar(
          backgroundColor: kMainColor,
          title: Container(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.h),
              child: Text(
                getTranslated(context, 'messages'),
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
child: status == ""?
Container(
  child: CircularProgressIndicator(


  ),
  alignment: AlignmentDirectional.center,
):status == "fail"?
Container(
  child: Text(messaage,
  style: TextStyle(
        color: Colors.black,
      fontSize: screenUtil.setSp(18),
      fontWeight: FontWeight.w600
  ),),
  alignment: AlignmentDirectional.center,
)
      :
      Container(
  margin: EdgeInsets.all(10.h),
  child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,


        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),


        itemBuilder:(context,index){
          return
            Container(
            height: 100.h,
            width: screenUtil.screenWidth,
            child:

            InkWell(
              onTap: (){
                Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                  return new MessageScreen(contactName:messageModel.data[index].senderName,
                    contactImage:messageModel.data[index].senderImage ,
                    contactId:messageModel.data[index].receiverId,
                    postId: messageModel.data[index].postId,
                    userId: loginModel.data.customerId);
                }));

              },
              child: Row(
                children: [
                  Expanded(child:
                  CachedNetworkImage(
                    width: 90.w,
                    height: 90.h,
                    imageUrl:'${messageModel.data[index].senderImage}',
                    imageBuilder: (context, imageProvider) =>
                        Container(
                            width: 90.w,
                            height: 90.h,

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              image: DecorationImage(
                                  fit: BoxFit.fill,

                                  image: imageProvider),
                            )
                        ),
                    placeholder: (context, url) =>
                        Center(
                          child: SizedBox(
                              height: 30.h,
                              width: 30.h,
                              child: new CircularProgressIndicator()),
                        ),


                    errorWidget: (context, url, error) =>  Container(
                        width: 50.w,
                        height: 50.h,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          image: DecorationImage(
                              image: AssetImage('assets/images/icon.png')),
                        )
                    ),

                  ),
                    flex: 1,),
                  SizedBox(width: 6.h,),
                  Expanded(flex:3,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        messageModel.data[index].senderName,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: screenUtil.setSp(16),
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        messageModel.data[index].message,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: screenUtil.setSp(14),
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ],
                  ) ),
                  Expanded(flex:1,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        messageModel.data[index].dayAgo,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: screenUtil.setSp(14),
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      Container(
                        width: 30.w,
                        height: 30.h,
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kMainColor,


                        ),
                        child:
                        Text('${messageModel.data[index].messageCount} ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: screenUtil.setSp(14),
                                fontWeight: FontWeight.normal
                            )
                        ),
                      )
                    ],
                  ) )
                ],
              ),
            ),
          );
        }, separatorBuilder: (context,index){
      return Container(height: 1.h,
      color: Color(0xFF000000),);}, itemCount: messageModel.data.length),
),
        ),
      ),
    );
  }
}
