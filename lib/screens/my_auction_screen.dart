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
class MyAuctionScreen extends StatefulWidget {
  static String id = 'MyAuctionScreen';
  @override
  _MyAuctionScreenState createState() => _MyAuctionScreenState();
}

class _MyAuctionScreenState extends State<MyAuctionScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  List<TypeModel> typesList = List();
  double itemWidth;
  double itemHeight;
  int selectedIndex =0;
  String mLanguage ="";
  String userId = "";
  Model.MyAuctionsModel myAuctionsModel;
  Future<Map> map() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    String loginData = _preferences.getString(kUserModel);
    final body = json.decode(loginData);
    LoginModel   loginModel = LoginModel.fromJson(body);
    Map map ;
    map = {"language":languageCode,
      "userId":loginModel.data.customerId};
    return map;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typesList.add(TypeModel(typeNameAr: 'الكل',typeNameEn: 'All',key: 'all',selected: true));
    typesList.add(TypeModel(typeNameAr: 'مستمر',typeNameEn: 'Running',key: 'running',selected: false));
    typesList.add(TypeModel(typeNameAr: 'القادمة',typeNameEn: 'Upcoming',key: 'upcoming',selected: false));
    typesList.add(TypeModel(typeNameAr: 'اكتمال',typeNameEn: 'Complete',key: 'complete',selected: false));
map().then((value) {
  userId = value["userId"];
  mLanguage = value['language'];
}).whenComplete(() {
  myAuctions('all').then((value) {
    setState(() {
      myAuctionsModel = value;
    });
  });
});
  }
  Future<Model.MyAuctionsModel> myAuctions(String type) async{
    Map map;
    map = {
      "id":userId,
      "language":mLanguage,
      "auction_type":type};





    PetMartService petMartService = PetMartService();
    Model.MyAuctionsModel auctionModel = await petMartService.myAuctions(map);
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
              'My Auction',
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
child: mLanguage == ""?
Container(
  child: CircularProgressIndicator(


  ),
  alignment: AlignmentDirectional.center,
):
    ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,



      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [

        SizedBox(height: 5.h,width: width,
        ),
        Container(
          height: 35.h,
          child: ListView.separated(

              scrollDirection: Axis.horizontal,

              itemBuilder: (context,index){
                return
                  GestureDetector(
                    onTap: (){
                      bool selectedIndex = typesList[index].selected;
                      print('selectedIndex ${selectedIndex}');

                      if(!selectedIndex){
                        for(int i =0;i<typesList.length;i++){
                          if(i == index){
                            typesList[i].selected= true;
                          }else{
                            typesList[i].selected= false;
                          }

                        }

                        myAuctionsModel = null;
                        setState(() {

                        });
                        postList(typesList[index].key);


                      }

                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: selectRow(typesList[index],context,index,mLanguage)),
                  );
              }
              ,
              separatorBuilder: (context,index) {
                return Container(height: 10.h,
                  color: Color(0xFFFFFFFF),);
              }
              ,itemCount: typesList.length),
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
            child:
            myAuctionsModel== null?
            Container(
              child: CircularProgressIndicator(


              ),
              alignment: AlignmentDirectional.center,
            ):GridView.builder(scrollDirection: Axis.vertical,


              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                  childAspectRatio:itemWidth/itemHeight),
              itemCount: myAuctionsModel.data.auctionData.length,

              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                      return new MyAuctionDetails(id:myAuctionsModel.data.auctionData[index].auctionId);
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
                          child: buildItem(myAuctionsModel.data.auctionData[index],context))),
                );
              },
            ),
        )
      ],
    )
      ),
    );
  }
  Container selectRow(TypeModel category,BuildContext context,int selectedIndex,String mLangauage){

    return
      Container(
        child:
        typesList[selectedIndex].selected?
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0.h),
              color: kMainColor
          ),
          child: Text(mLangauage =="en"?category.typeNameEn:
          category.typeNameAr,
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
            mLangauage =="en"?category.typeNameEn:
            category.typeNameAr,
            style: TextStyle(
                color: Color(0xCC000000),
                fontSize: screenUtil.setSp(14),
                fontWeight: FontWeight.w500

            ),
          ),
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
                Positioned.directional(
                  textDirection:  Directionality.of(context),
                  bottom: 2.h,
                  start: 4.w,
                  child:
                  Countdown(
                    seconds: getRemainingTime(data.endDate),
                    build: (BuildContext context, double time) => Container(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(

                          'Remaining  ${formatDuration(time.toInt())} ',
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
                )
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
  int  getRemainingTime(String date ){
    var now = new DateTime.now();
    print(now);
    DateTime tempDate = new DateFormat("dd-MM-yyyy hh:mm:ss").parse(date);
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

}
