import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pet_mart/api/pet_mart_service.dart';

import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/my_auctions_model.dart' as Model;
import 'package:pet_mart/model/type_model.dart';
import 'package:pet_mart/screens/my_auction_details.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../model/MyNewAuctionModel.dart';
import '../model/auction_type.dart';
class MyAuctionScreen extends StatefulWidget {
  static String id = 'MyAuctionScreen';
  @override
  _MyAuctionScreenState createState() => _MyAuctionScreenState();
}

class _MyAuctionScreenState extends State<MyAuctionScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  List<TypeModel> typesList = [];
  double? itemWidth;
  double? itemHeight;
  int selectedIndex =0;
  String mLanguage ="";
  String userId = "";
  Model.MyAuctionsModel? myAuctionsModel;
  Future<Map> map() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    String? loginData = _preferences.getString(kUserModel);
    final body = json.decode(loginData!);
    LoginModel   loginModel = LoginModel.fromJson(body);
    Map map ;
    map = {"language":languageCode,
      "userId":loginModel.data!.id};
    return map;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getMyActions().then((value) {
     setState(() {
       loginData = value;

     });

   });
  }
  List<Live> myAuctionList =[];
  String languageCode="";
  int position=0;

  String ?loginData ;
  List<AuctionType> auctionTypeList =[];
  MyNewAuctionModel? myNewAuctionModel ;
  String myAuctionErrorString ="";
  Map<String, dynamic>? response;
  Future<String> getMyActions() async{
    AuctionType  liveType = AuctionType("مباشر", "live", true);
    AuctionType  doneType = AuctionType("انتهي", "Done", false);
    AuctionType  cancleType = AuctionType("ملغي", "Cancel", false);
    auctionTypeList.add(liveType);
    auctionTypeList.add(doneType);
    auctionTypeList.add(cancleType);
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    loginData = _preferences.getString(kUserModel)??null;

      final body = json.decode(loginData!);
      LoginModel   loginModel = LoginModel.fromJson(body);
      userId = loginModel.data!.id!;
      PetMartService petMartService = PetMartService();
       response  = await petMartService.myNewAuctions(userId);
      bool isOk  = response!['ok'];
      if(isOk){
        myAuctionErrorString = "";
        myNewAuctionModel = MyNewAuctionModel.fromJson(response);
        if(response!['data'].containsKey('live')){
          myAuctionList = myNewAuctionModel!.data.live;
        }else{
          myAuctionList = [];
        }


      }else{
        myAuctionErrorString = response!['data']['msg'];
      }

      return loginData!;


  }
  Future<Model.MyAuctionsModel?> myAuctions(String type) async{
    Map map;
    map = {
      "id":userId,
      "language":mLanguage,
      "auction_type":type};





    PetMartService petMartService = PetMartService();
    Model.MyAuctionsModel? auctionModel = await petMartService.myAuctions(map);
    return auctionModel;
  }
  Future<void> postList(String type) async{
    Map map;
    map = {
      "id":userId,
      "language":mLanguage,
      "auction_type":type};





    PetMartService petMartService = PetMartService();
    myAuctionsModel = await petMartService.myAuctions(map);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    itemWidth = width / 2;
    itemHeight = 240.h;
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: kMainColor,
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
              getTranslated(context, 'my_auction')!,
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
 child: loginData == null?
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

        SizedBox(height: 5.h,width: width,
        ),
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
                          if(response!['data']!.containsKey('live')){
                            print(response!['live']);
                            myAuctionList = myNewAuctionModel!.data.live;
                          }else{
                            myAuctionList = [];
                          }




                        }else if(index == 1){
                          if(response!['data'].containsKey('done')){
                            print(response!['done']);
                            myAuctionList = myNewAuctionModel!.data.done;
                          }else{
                            myAuctionList = [];
                          }


                        }else if(index == 2){
                          if(response!['data']!.containsKey('cancel')){
                            print(response!['cancel']);
                            myAuctionList = myNewAuctionModel!.data.done;
                          }else{
                            myAuctionList = [];
                          }

                        }
                        // if(myAuctionList == null){
                        //   myAuctionList = [];
                        // }
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
        SizedBox(height: 5.h,width: width,
        ),
        SizedBox(height: 1.h,width:width ,
          child: Container(
            color: Color(0x66000000),
          ),),
        SizedBox(height: 5.h,width: width,
        ),
        Container(
          child:myAuctionList.isEmpty?
          Container(
            height: 200.h,
            width: width,
            alignment: AlignmentDirectional.center,
            child: Text(
              getTranslated(context, "no_available_auctions")!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: screenUtil.setSp(16),
                  fontWeight: FontWeight.w600
              ),
            ),
          ):
          Container(

            width: width,
            child:
            GridView.builder(scrollDirection: Axis.vertical,


              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                  childAspectRatio:itemWidth!/itemHeight!),
              itemCount: myAuctionList.length,

              itemBuilder: (context,index){
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
                        child: buildMyAuctionItem(myAuctionList[index],context,position)),
                  ),
                );
              },
            )


          ),
        ),

      ],
    )
      ),
    );
  }
  Widget buildMyAuctionItem(Live data, BuildContext context,int position) {
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



                          getTranslated(context, 'Done')!,
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


                          getTranslated(context, 'cancel')!,
                          style: TextStyle(

                            color: Color(0xFF000000),
                            fontSize: screenUtil.setSp(12),
                            fontWeight: FontWeight.bold,

                          )
                      ),
                    ):

                    Countdown(
                      seconds: getRemainingTime(data.endDate,data.date),
                      build: (BuildContext context, double time) => Container(
                        alignment: AlignmentDirectional.centerStart,
                        margin: EdgeInsetsDirectional.only(start: 4.w),
                        child: Text(


                            time.toInt()<=0 ? getTranslated(context, 'complete_string')! :'${getTranslated(context, 'remainning')}  ${formatDuration(time.toInt())} ',
                            style: TextStyle(

                              color: Color(0xFF000000),
                              fontSize: screenUtil.setSp(12),
                              fontWeight: FontWeight.bold,

                            )
                        ),
                      ),
                      interval: Duration(seconds: 1),
                      onFinished: () {
                        myAuctionList.removeAt(position);
                        setState(() {

                        });
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
  Widget buildItem(Model.AuctionData data, BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: itemWidth,
                  imageUrl:data.acutionImage,
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
                //   Countdown(
                //     seconds: getRemainingTime(data.endDate),
                //     build: (BuildContext context, double time) => Container(
                //       alignment: AlignmentDirectional.centerEnd,
                //       child: Text(
                //
                //           'Remaining  ${formatDuration(time.toInt())} ',
                //           style: TextStyle(
                //             color: Color(0xFF000000),
                //             fontSize: screenUtil.setSp(12),
                //             fontWeight: FontWeight.bold,
                //
                //           )
                //       ),
                //     ),
                //     interval: Duration(seconds: 1),
                //     onFinished: () {
                //       print('Timer is done!');
                //     },
                //   ),
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
                    data.auctionName,
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
                        data.imageCount.toString(),
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.normal,
                            fontSize: screenUtil.setSp(14)
                        ),

                      ),
                    ),
                  ],
                ))
              ],
            ),
          ))

        ],
      ),
    );

  }
  int  getRemainingTime(String date,String startDate ){
    print("EndDate ---> ${date}");
    var now =  DateTime.parse(startDate);

    print("Now ${now}");
    DateTime tempDate =  DateTime.parse(date);
    Duration difference = tempDate.difference(now);
    print("diff in hours -->${difference.inHours}");
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
    }else{
      tokens.add('00');
    }
    if (tokens.isNotEmpty || hours != 0){
      tokens.add('${hours}h');
    }else{
      tokens.add('00');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m');
    }else{
      tokens.add('00');
    }
    if (tokens.isNotEmpty || seconds != 0){
      tokens.add('${seconds}s');
    }else{
      tokens.add('00');
    }

    return tokens.join(':');
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

}
