import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pet_mart/model/my_auctions_model.dart' as Model;
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/auction_model.dart' as AuctionModel;
import 'package:pet_mart/model/check_credit_model.dart';
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
  List<Category> categories = List();
  List<bool> selectedList = List();
  Model.MyAuctionsModel myAuctionModel = null;
  HomeModel homeModel;
  AuctionModel.AuctionModel auctionModel;
  double itemWidth;
  double itemHeight;
  Future<AuctionModel.AuctionModel> auction(String catId) async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String loginData = _preferences.getString(kUserModel);
    Map map ;

    if(loginData == null){
      map = {"category_id":catId,
        "id":"",
        "language":languageCode};
    }else{
      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      map = {"category_id":catId,
        "id":loginModel.data.customerId,
        "language":languageCode};

    }




    PetMartService petMartService = PetMartService();
    AuctionModel.AuctionModel auctionModel = await petMartService.auction(map);
    return auctionModel;
  }
  String loginData = null;
  String userId="";
  Future<void> getList(String catId) async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String loginData = _preferences.getString(kUserModel);
    Map map ;
    print('loginData ${loginData}');

    if(loginData == null){
      userId = "";
      map = {"category_id":catId,
        "id":"",
        "language":languageCode};
    }else{

      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      userId = loginModel.data.customerId;
      print('userId --> ${userId}');
      map = {"category_id":catId,
        "id":loginModel.data.customerId,
        "language":languageCode};
    }




    PetMartService petMartService = PetMartService();
    auctionModel = await petMartService.auction(map);
    setState(() {

    });

  }
  Future<HomeModel> getHomeModel() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String homeString = sharedPreferences.getString("home");
print('homeString --> ${homeString}');

    HomeModel  homeModel ;


    final body = json.decode(homeString);
    homeModel = HomeModel.fromJson(body);
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String loginData = _preferences.getString(kUserModel);
    Map map ;
    print('loginData ${loginData}');

    if(loginData != null) {
      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      Map myAuctionMap;
      userId = loginModel.data.customerId;
      myAuctionMap = {
        "id": loginModel.data.customerId,
        "language": languageCode,
        "auction_type": "all"};


      PetMartService petMartService = PetMartService();
      myAuctionModel = await petMartService.myAuctions(myAuctionMap);
      print('myAuctionModel --> ${myAuctionModel}');
    }



    return homeModel;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomeModel().then((value){
homeModel = value;


        List<Images> images = null;
        String categoryId = "";
        Category category = Category(categoryId:categoryId,categoryName:"All",images: images);
        categories.add(category);
        selectedList.add(true);

        for(int i =0;i<homeModel.data.category.length;i++){
          categories.add(homeModel.data.category[i]);
          selectedList.add(false);
          print("CatId-->${homeModel.data.category[i].categoryId}");
        }


    }).whenComplete(() {
      auction("").then((value){
        setState(() {
          auctionModel = value;
        });

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    itemWidth = width / 2;
    itemHeight = 230.h;

    return Scaffold(
      body: Container(

        child: homeModel == null?
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

              padding: EdgeInsets.all(10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: userId == ""?0.0:1.0,
                      child: Container(


                        child: Text(getTranslated(context, 'my_auction')
                          ,style: TextStyle(color: Color(0xFF000000),fontSize: screenUtil.setSp(16),
                              fontWeight: FontWeight.bold),),
                      ),
                    ),
                    previewButton(getTranslated(context, 'create_auction'), context),

                  ],
                )),
            SizedBox(height: 1,width: width,
            child: Container(
              color: Color(0xFF0000000),
            ),),
            Container(
              child:userId== "" || myAuctionModel == null?
                Container()
          :Column(
                children: [
                  SizedBox(height: 10.w,),
                  Container(
                    child:
                    Container(
                      height: 200.h,
                      width: width,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                          itemBuilder:(context,index){
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                              return new MyAuctionDetails(id:myAuctionModel.data.auctionData[index].auctionId,postName:myAuctionModel.data.auctionData[index].auctionName ,);
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
                                child: buildMyAuctionItem(myAuctionModel.data.auctionData[index],context)),
                          ),
                        );
                      } , separatorBuilder: (context,index){
                        return Container(width: 10.w,);
                      }, itemCount: myAuctionModel.data.auctionData.length),
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
            Container(
              margin: EdgeInsets.all(10.h),
              height: 35.h,
              child: ListView.separated(

                  scrollDirection: Axis.horizontal,

                  itemBuilder: (context,index){
                    return
                      GestureDetector(
                        onTap: (){
                          bool selectedIndex = selectedList[index];
                          if(!selectedIndex){
                            auctionModel = null;
                            for(int i =0;i<selectedList.length;i++){
                              if(i == index){
                                selectedList[i]= true;
                              }else{
                                selectedList[i]= false;
                              }
                            }

                            setState(() {

                            });
                            getList(categories[index].categoryId);

                          }

                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: selectRow(categories[index],context,index)),
                      );
                  }
                  ,
                  separatorBuilder: (context,index) {
                    return Container(height: 10.h,
                      color: Color(0xFFFFFFFF),);
                  }
                  ,itemCount: categories.length),

            ),
            SizedBox(height: 5.h,width: width,
            ),
            Container(
              child:
              auctionModel== null?
              Container(
                child: CircularProgressIndicator(


                ),
                alignment: AlignmentDirectional.center,
              ):
              auctionModel.data.isEmpty?

              Container(
                child: Text(
                  auctionModel.message,
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
                itemCount: auctionModel.data.length,

                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                        return new AuctionDetailsScreen(mAuctionModel:auctionModel.data[index]);
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
                            child: buildItem(auctionModel.data[index],context))),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
  Container selectRow(Category category,BuildContext context,int selectedIndex){

    return
      Container(
        child:
        selectedList[selectedIndex]?
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0.h),
              color: kMainColor
          ),
          child: Text(
            category.categoryName,
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
            category.categoryName,
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
  Widget buildItem(AuctionModel.Data data, BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: itemWidth,
                  imageUrl:data.gallery.isEmpty?"":data.gallery[0].image,
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
                    data.name,
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
  Widget buildMyAuctionItem(Model.AuctionData data, BuildContext context) {
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
                  imageUrl:data.gallery.isEmpty?"":data.gallery[0].image,
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
                    Image.asset('assets/images/placeholder_image_count.png',height: 20.h,
                    width: 20.w,fit: BoxFit.fill,),
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
                )),
                Expanded(
                  flex: 1,
                  child: Countdown(
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
  Future<CheckCreditModel> checkCreditModel() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String loginData = sharedPreferences.getString(kUserModel);

    final body = json.decode(loginData);
    LoginModel   loginModel = LoginModel.fromJson(body);


    Map map ;


    map = {"user_id":loginModel.data.customerId};





    PetMartService petMartService = PetMartService();
    CheckCreditModel creditModel = await petMartService.checkCredit(map);
    return creditModel;
  }
  createAuction(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool(kIsLogin)??false;
    if(isLoggedIn){
      final modelHud = Provider.of<ModelHud>(context,listen: false);
      modelHud.changeIsLoading(true);
      checkCreditModel().then((value){
        modelHud.changeIsLoading(false);
        int credit = int.parse(value.data.credit);
        print('credit --->${credit}');

        if(credit>0){
          Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
            return new CreateAuctionScreen();
          }));
        }else{
          ShowAlertDialog(context, value.message);
        }
      });
      print("true");

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


