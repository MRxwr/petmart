import 'dart:convert';
import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pet_mart/model/MyNewAuctionModel.dart';
import 'package:pet_mart/model/NewAcutionListModel.dart' as NewAcutionListModel;

import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';


import 'package:pet_mart/model/home_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/auction_details_screen.dart';
import 'package:pet_mart/screens/my_auction_details.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../model/auction_type.dart';
import 'create_auction_screen.dart';
import 'credit_screen.dart';
import 'login_screen.dart';
class AuctionScreen extends StatefulWidget {
  static String id = 'AuctionScreen';
  @override
  _AuctionScreenState createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  List<Categories> categories = [];
  List<bool> selectedList =[];


  HomeModel homeModel;

  double itemWidth;
  double itemHeight;
  String languageCode;
  // Future<AuctionModel.AuctionModel> auction(String catId) async{
  //
  //   SharedPreferences _preferences = await SharedPreferences.getInstance();
  //    languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
  //
  //   String loginData = _preferences.getString(kUserModel);
  //   Map map ;
  //
  //   if(loginData == null){
  //     map = {"category_id":catId,
  //       "id":"",
  //       "language":languageCode};
  //   }else{
  //     final body = json.decode(loginData);
  //     LoginModel   loginModel = LoginModel.fromJson(body);
  //     map = {"category_id":catId,
  //       "id":loginModel.data.id,
  //       "language":languageCode};
  //
  //   }
  //
  //
  //
  //
  //   PetMartService petMartService = PetMartService();
  //   AuctionModel.AuctionModel auctionModel = await petMartService.auction(map);
  //   return auctionModel;
  // }
  String loginData = "";
  String userId="";
  // Future<void> getList(String catId) async{
  //
  //   SharedPreferences _preferences = await SharedPreferences.getInstance();
  //   String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
  //
  //   String loginData = _preferences.getString(kUserModel);
  //   Map map ;
  //   print('loginData ${loginData}');
  //
  //   if(loginData == null){
  //     userId = "";
  //     map = {"category_id":catId,
  //       "id":"",
  //       "language":languageCode};
  //   }else{
  //
  //     final body = json.decode(loginData);
  //     LoginModel   loginModel = LoginModel.fromJson(body);
  //     userId = loginModel.data.id;
  //     print('userId --> ${userId}');
  //     map = {"category_id":catId,
  //       "id":loginModel.data.id,
  //       "language":languageCode};
  //   }
  //
  //
  //
  //
  //   PetMartService petMartService = PetMartService();
  //   auctionModel = await petMartService.auction(map);
  //   setState(() {
  //
  //   });
  //
  // }

MyNewAuctionModel myNewAuctionModel;
  NewAcutionListModel. NewAcutionListModel mNewAuctionListModel;
  String myAuctionErrorString="";
  String AuctionErrorString ="";

  Future<void> auctions() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
     languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

     loginData = _preferences.getString(kUserModel)??null;
     if(loginData != null){
       final body = json.decode(loginData);
       LoginModel   loginModel = LoginModel.fromJson(body);
       userId = loginModel.data.id;
       PetMartService petMartService = PetMartService();
       Map<String, dynamic>   response  = await petMartService.myNewAuctions(userId);
       bool isOk  = response['ok'];
       if(isOk){
         myAuctionErrorString = "";
         myNewAuctionModel = MyNewAuctionModel.fromJson(response);
         myAuctionList = myNewAuctionModel.data.live;
         if(myAuctionList == null){
           myAuctionList = [];
         }
       }else{
         myAuctionErrorString = response['data']['msg'];
       }


     }
    PetMartService petMartService = PetMartService();
    Map<String, dynamic>   responseList  = await petMartService.NewAuctionList();
    bool isNewOk = responseList['ok'];
    if(isNewOk){
      mNewAuctionListModel = NewAcutionListModel.NewAcutionListModel.fromJson(responseList);

      AuctionErrorString = "";
    }else{
      AuctionErrorString = responseList['data']['msg'];
    }



  }

//   Future<HomeModel> getHomeModel() async{
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String homeString = sharedPreferences.getString("home");
// print('homeString --> ${homeString}');
//
//     HomeModel  homeModel ;
//
//
//     final body = json.decode(homeString);
//     homeModel = HomeModel.fromJson(body);
//     SharedPreferences _preferences = await SharedPreferences.getInstance();
//     String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
//
//     String loginData = _preferences.getString(kUserModel);
//     Map map ;
//     print('loginData ${loginData}');
//
//     if(loginData != null) {
//       final body = json.decode(loginData);
//       LoginModel   loginModel = LoginModel.fromJson(body);
//       Map myAuctionMap;
//       userId = loginModel.data.id;
//       myAuctionMap = {
//         "id": loginModel.data.id,
//         "language": languageCode,
//         "auction_type": "all"};
//
//
//       PetMartService petMartService = PetMartService();
//       myAuctionModel = await petMartService.myAuctions(myAuctionMap);
//       print('myAuctionModel --> ${myAuctionModel}');
//     }
//
//
//
//     return homeModel;
//   }
  List<Live> myAuctionList =[];
  List<AuctionType> auctionTypeList =[];
  int position=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuctionType  liveType = AuctionType("مباشر", "live", true);
    AuctionType  doneType = AuctionType("انتهي", "Done", false);
    AuctionType  cancleType = AuctionType("ملغي", "Cancel", false);
    auctionTypeList.add(liveType);
    auctionTypeList.add(doneType);
    auctionTypeList.add(cancleType);
    auctions().then((value)  {
    setState(() {

    });
    });
//     getHomeModel().then((value){
// homeModel = value;
//
//
//         // List<Images> images = null;
//         String categoryId = "";
//         Categories category = Categories(id:categoryId,arTitle:getTranslated(context, 'all'),enTitle:getTranslated(context, 'all'),logo: "");
//         categories.add(category);
//         selectedList.add(true);
//
//         for(int i =0;i<homeModel.data.categories.length;i++){
//           categories.add(homeModel.data.categories[i]);
//           selectedList.add(false);
//           print("CatId-->${homeModel.data.categories[i].id}");
//         }
//
//
//     }).whenComplete(() {
//       auction("").then((value){
//         setState(() {
//           auctionModel = value;
//         });
//
//       });
//     });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    itemWidth = width / 2;
    itemHeight = 230.h;

    return Scaffold(
      body: Container(

        child: loginData == ""?
        Container(
          child: CircularProgressIndicator(


          ),
          alignment: AlignmentDirectional.center,
        ):
        ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,



          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [

            Container(
              child: userId == ""?
              Container():Container(

                padding:
                EdgeInsets.all(10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(


                        child: Text(getTranslated(context, 'my_auction')
                          ,style: TextStyle(color: Color(0xFF000000),fontSize: screenUtil.setSp(16),
                              fontWeight: FontWeight.bold),),
                      ),
                      previewButton(getTranslated(context, 'create_auction'), context),

                    ],
                  )),
            ),
            Container(
              child:userId == ""?
              Container():SizedBox(height: 1,width: width,
              child: Container(
                color: Color(0xFF0000000),
              ),),
            ),
            Container(
              child:userId== ""?
                Container()
          :Container(
            child:myAuctionErrorString != ""?
            Container(
              child: Text(
                myAuctionErrorString,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: screenUtil.setSp(16),
                    fontWeight: FontWeight.w600
                ),
              ),
              alignment: AlignmentDirectional.center,
            ):
            Column(
                  children: [
                    SizedBox(height: 10.w,),
                    Container(
                      margin: EdgeInsets.all(10.h),
                      height: 35.h,
                      child: ListView.separated(

                          scrollDirection: Axis.horizontal,

                          itemBuilder: (context,index){
                            return
                              GestureDetector(
                                onTap: (){
                                  bool selectedIndex = auctionTypeList[index].isSelected;
                                  if(!selectedIndex){

                                    for(int i =0;i<auctionTypeList.length;i++){
                                      if(i == index){
                                        auctionTypeList[i].isSelected= true;
                                      }else{
                                        auctionTypeList[i].isSelected= false;
                                      }
                                    }



                                    myAuctionList =[];
                                    if(index==0){
                                      myAuctionList = myNewAuctionModel.data.live;

                                    }else if(index == 1){
                                      myAuctionList = myNewAuctionModel.data.done;
                                    }else if(index == 2){
                                      myAuctionList = myNewAuctionModel.data.cancel;
                                    }
                                    if(myAuctionList == null){
                                      myAuctionList = [];
                                    }
                                    position = index;
                                    setState(() {

                                    });


                                  }

                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    child: selectRow(auctionTypeList[index],context,index)),
                              );
                          }
                          ,
                          separatorBuilder: (context,index) {
                            return Container(height: 10.h,
                              color: Color(0xFFFFFFFF),);
                          }
                          ,itemCount: auctionTypeList.length),

                    ),
                    Container(
                      child:myAuctionList.isEmpty?
                          Container(
                            height: 200.h,
                            width: width,
                            alignment: AlignmentDirectional.center,
                            child: Text(
                            "No Auction Available",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: screenUtil.setSp(16),
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          ):
                      Container(
                        height: 200.h,
                        width: width,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                            itemBuilder:(context,index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                                return new MyAuctionDetails(id:myAuctionList[index].id,postName:languageCode == "en"?myAuctionList[index].enTitle:myAuctionList[index].enTitle);
                              }));
                            },
                            child: Container(
                              margin: EdgeInsets.all(6.w),
                              child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  elevation: 1.w,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0.h),
                                  ),
                                  color: Color(0xFFFFFFFF),
                                  child: buildMyAuctionItem(myAuctionList[index],context)),
                            ),
                          );
                        } , separatorBuilder: (context,index){
                          return Container(width: 10.w,);
                        }, itemCount: myAuctionList.length),
                      ),
                    ),
                    SizedBox(height: 10.w,),
                    SizedBox(height: 1,width: width,
                      child: Container(
                        color: Color(0xFF0000000),
                      ),),
                  ],
                ),
          ),
            ),
            Container(
              alignment: AlignmentDirectional.centerStart,
              padding: EdgeInsets.all(10.h),
              child: Text(getTranslated(context, 'run_auction')
              ,style: TextStyle(color: Color(0xFF000000),fontSize: screenUtil.setSp(16),
                fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 1,width: width,
              child: Container(
                color: Color(0xFF0000000),
              ),),

            SizedBox(height: 5.h,width: width,
            ),
            Container(
              child:

              AuctionErrorString != ""?

              Container(
                child: Text(
                  AuctionErrorString,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: screenUtil.setSp(16),
                      fontWeight: FontWeight.w600
                  ),
                ),
                alignment: AlignmentDirectional.center,
              )
                  :

              GridView.builder(scrollDirection: Axis.vertical,


                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio:itemWidth/itemHeight),
                itemCount: mNewAuctionListModel.data.length,

                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                        return new AuctionDetailsScreen(mAuctionModel:mNewAuctionListModel.data[index]);
                      }));
                    },
                    child: Container(
                        margin: EdgeInsets.all(6.w),


                        child:
                        Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 1.w,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0.h),
                            ),
                            color: Color(0xFFFFFFFF),
                            child: buildItem(mNewAuctionListModel.data[index],context))),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
  Container selectRow(AuctionType category,BuildContext context,int selectedIndex){

    return
      Container(
        child:
        category.isSelected?
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0.h),
              color: kMainColor
          ),
          child: Text(
            languageCode == "en"?
            category.nameEn:category.nameAr,
            style: TextStyle(
                color: Color(0xCC000000),
                fontSize: screenUtil.setSp(14),
                fontWeight: FontWeight.w500

            ),
          ),
        ) :
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0.h),
              color: Color(0xFFFFFFFF),
              border: Border.all(
                  color: Color(0xCC000000),
                  width: 1.0.w
              )
          ),
          child: Text(
            languageCode == "en"?
            category.nameEn:category.nameAr,
            style: TextStyle(
                color: Color(0xCC000000),
                fontSize: screenUtil.setSp(14),
                fontWeight: FontWeight.w500

            ),
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

         createAuction(context);

      },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
    );
  }
  Widget buildItem(NewAcutionListModel.Data data, BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: itemWidth,
                  imageUrl:KImageUrl+data.image,
                  imageBuilder: (context, imageProvider) => Stack(
                    children: [
                      ClipRRect(

                        child: Container(
                            width: itemWidth,

                            decoration: BoxDecoration(

                              shape: BoxShape.rectangle,

                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: imageProvider),
                            )
                        ),
                      ),
                    ],
                  ),
                  placeholder: (context, url) =>
                      Center(
                        child: SizedBox(
                            height: 50.h,
                            width: 50.h,
                            child: new CircularProgressIndicator()),
                      ),


                  errorWidget: (context, url, error) => ClipRRect(
                      child: Image.asset('assets/images/placeholder_error.png',  color: Color(0x80757575).withOpacity(0.5),
                        colorBlendMode: BlendMode.difference,)),

                ),
                // Positioned.directional(
                //   textDirection:  Directionality.of(context),
                //   bottom: 2.h,
                //   start: 4.w,
                //   child:
                //
                // )
              ],
            ),
          ),
          Expanded(flex:1,child: Container(
            child: Column(
              children: [
                Expanded(flex:1,child:
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    languageCode == "en"?
                    data.enTitle:data.arTitle,
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                        fontSize: screenUtil.setSp(12)
                    ),

                  ),
                )),
                Expanded(flex:1,child:
                Row(
                  children: [
                    Image.asset('assets/images/placeholder_image_count.png'),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        data.images.toString(),
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.normal,
                            fontSize: screenUtil.setSp(14)
                        ),

                      ),
                    ),
                  ],
                )),
                Expanded(child: Container(
                  margin: EdgeInsetsDirectional.only(start: 4.w),
                  child:    Countdown(
                    seconds: getRemainingTime(data.endDate),
                    build: (BuildContext context, double time) => Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(

                          time.toInt()<=0 ? getTranslated(context, 'complete_string') :'${getTranslated(context, 'remainning')}  ${formatDuration(time.toInt())} ',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: screenUtil.setSp(12),
                            fontWeight: FontWeight.bold,

                          )
                      ),
                    ),
                    interval: Duration(seconds: 1),
                    onFinished: () {
                      print('Timer is done!');
                    },
                  ),
                ))
              ],
            ),
          ))

        ],
      ),
    );

  }
  Widget buildMyAuctionItem(Live data, BuildContext context) {
    String timer ="";
    return Container(
      width: 150.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: itemWidth,
                  imageUrl:KImageUrl+data.image,
                  imageBuilder: (context, imageProvider) => Stack(
                    children: [
                      ClipRRect(

                        child: Container(
                            width: itemWidth,

                            decoration: BoxDecoration(

                              shape: BoxShape.rectangle,

                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: imageProvider),
                            )
                        ),
                      ),
                    ],
                  ),
                  placeholder: (context, url) =>
                      Center(
                        child: SizedBox(
                            height: 50.h,
                            width: 50.h,
                            child: new CircularProgressIndicator()),
                      ),


                  errorWidget: (context, url, error) => ClipRRect(
                      child: Image.asset('assets/images/placeholder_error.png',  color: Color(0x80757575).withOpacity(0.5),
                        colorBlendMode: BlendMode.difference,fit: BoxFit.fill,)),

                ),
                // Positioned.directional(
                //   textDirection:  Directionality.of(context),
                //   bottom: 2.h,
                //   start: 4.w,
                //   child:
                //
                // )
              ],
            ),
          ),
          Expanded(flex:3,child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex:1,child:
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    languageCode == "en"?data.enTitle:
                    data.arTitle,
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                        fontSize: screenUtil.setSp(12)
                    ),

                  ),
                )),
                Expanded(flex:1,child:
                Row(
                  children: [
                    Image.asset('assets/images/placeholder_image_count.png',height: 20.h,
                    width: 20.w,fit: BoxFit.fill,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        data.images.toString(),
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.normal,
                            fontSize: screenUtil.setSp(14)
                        ),

                      ),
                    ),
                  ],
                )),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: position == 1?
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsetsDirectional.only(start: 4.w),
                      child: Text(


                        "Done",
                          style: TextStyle(

                            color: Color(0xFF000000),
                            fontSize: screenUtil.setSp(12),
                            fontWeight: FontWeight.bold,

                          )
                      ),
                    ):
                    position == 2? Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsetsDirectional.only(start: 4.w),
                      child: Text(


                          "Stopped",
                          style: TextStyle(

                            color: Color(0xFF000000),
                            fontSize: screenUtil.setSp(12),
                            fontWeight: FontWeight.bold,

                          )
                      ),
                    ):

                    Countdown(
                      seconds: getRemainingTime(data.endDate),
                      build: (BuildContext context, double time) => Container(
                        alignment: AlignmentDirectional.centerStart,
                        margin: EdgeInsetsDirectional.only(start: 4.w),
                        child: Text(


                            time.toInt()<=0 ? getTranslated(context, 'complete_string') :'${getTranslated(context, 'remainning')}  ${formatDuration(time.toInt())} ',
                            style: TextStyle(

                              color: Color(0xFF000000),
                              fontSize: screenUtil.setSp(12),
                              fontWeight: FontWeight.bold,

                            )
                        ),
                      ),
                      interval: Duration(seconds: 1),
                      onFinished: () {
                        print('Timer is done!');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ))

        ],
      ),
    );

  }
  int  getRemainingTime(String date ){
    var now = new DateTime.now();
    print(now);
    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
    Duration difference = tempDate.difference(now);
    return difference.inSeconds;
  }
  String formatDuration(int d) {
    var seconds = d;
    final days = seconds~/Duration.secondsPerDay;
    seconds -= days*Duration.secondsPerDay;
    final hours = seconds~/Duration.secondsPerHour;
    seconds -= hours*Duration.secondsPerHour;
    final minutes = seconds~/Duration.secondsPerMinute;
    seconds -= minutes*Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0){
      tokens.add('${hours}h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m');
    }
    tokens.add('${seconds}s');

    return tokens.join(':');
  }
  // Future<CheckCreditModel> checkCreditModel() async{
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String loginData = sharedPreferences.getString(kUserModel);
  //
  //   final body = json.decode(loginData);
  //   LoginModel   loginModel = LoginModel.fromJson(body);
  //
  //
  //   Map map ;
  //
  //
  //   map = {"user_id":loginModel.data.id};
  //
  //
  //
  //
  //
  //   PetMartService petMartService = PetMartService();
  //   CheckCreditModel creditModel = await petMartService.checkCredit(map);
  //   return creditModel;
  // }
  createAuction(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool(kIsLogin)??false;
    if(isLoggedIn){
      // final modelHud = Provider.of<ModelHud>(context,listen: false);
      // modelHud.changeIsLoading(true);
      // checkCreditModel().then((value){
      //   modelHud.changeIsLoading(false);
      //   int credit = int.parse(value.data.credit);
      //   print('credit --->${credit}');
      //
      //   if(credit>0){
      //
      //   }else{
      //     ShowAlertDialog(context, value.message);
      //   }
      // });
      // print("true");
      Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
        return new CreateAuctionScreen();
      }));

    }else{
      ShowAlerLogintDialog(context,getTranslated(context, 'not_login'));
    }

  }
  Future<void> ShowAlertDialog(BuildContext context ,String title) async{
    var alert;
    var alertStyle = AlertStyle(

      animationType: AnimationType.fromBottom,
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
    alert =   Alert(
      context: context,
      style: alertStyle,

      title: title,


      buttons: [

        DialogButton(
          child: Text(
            getTranslated(context, 'ok'),
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();
            Navigator.of(context,rootNavigator: true).pushReplacement(new MaterialPageRoute(builder: (BuildContext context){
              return new CreditScreen();
            }));
            // Navigator.pushReplacementNamed(context,LoginScreen.id);

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        ),
        DialogButton(
          child: Text(
            getTranslated(context, 'no'),
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
  Future<void> ShowAlerLogintDialog(BuildContext context ,String title) async{
    var alert;
    var alertStyle = AlertStyle(

      animationType: AnimationType.fromBottom,
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
    alert =   Alert(
      context: context,
      style: alertStyle,

      title: title,


      buttons: [

        DialogButton(
          child: Text(
            getTranslated(context, 'ok'),
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();
            Navigator.of(context,rootNavigator: true).pushReplacement(new MaterialPageRoute(builder: (BuildContext context){
              return new LoginScreen();
            }));
            // Navigator.pushReplacementNamed(context,LoginScreen.id);

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        ),
        DialogButton(
          child: Text(
            getTranslated(context, 'no'),
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


