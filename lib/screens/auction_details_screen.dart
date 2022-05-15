import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/BidNewModel.dart';
import 'package:pet_mart/model/auction_details_model.dart';
import 'package:pet_mart/model/NewAcutionListModel.dart' as AuctionModel;
import 'package:pet_mart/model/bid_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/post_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/adaption_photo_screen.dart';
import 'package:pet_mart/screens/login_screen.dart';
import 'package:pet_mart/screens/photo-screen.dart';
import 'package:pet_mart/screens/vedio_screen.dart';
import 'package:pet_mart/screens/youtube_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/MyNewAuctionDetailsModel.dart';
class AuctionDetailsScreen extends StatefulWidget {
  static String id = 'AuctionDetailsScreen';
  AuctionModel.Data mAuctionModel;
  AuctionDetailsScreen({Key key,@required this.mAuctionModel}): super(key: key);


  @override
  _AuctionDetailsScreenState createState() => _AuctionDetailsScreenState();
}

class _AuctionDetailsScreenState extends State<AuctionDetailsScreen> {
  MyNewAuctionDetailsModel mAuctionDetailsModel = null;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final CarouselController _controller = CarouselController();
  ScreenUtil screenUtil = ScreenUtil();
  int _current =0;
  int currentBid  =0;

   double _rating;

  double _userRating = 3.0;
  int _ratingBarMode = 1;
  double _initialRating ;
  bool _isRTLMode = false;
  bool _isVertical = false;
  String languageCode;
  String userId;
  Future<MyNewAuctionDetailsModel> auction() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
     languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String loginData = _preferences.getString(kUserModel);
    Map<String,String> map = Map() ;

    if(loginData == null){
      map['auctionId']= widget.mAuctionModel.id;
      map['customerId']= "";
    }else{
      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      userId = loginModel.data.id;
      map['auctionId']= widget.mAuctionModel.id;
      map['customerId']= loginModel.data.id;


      print(map);
    }




    PetMartService petMartService = PetMartService();
    MyNewAuctionDetailsModel auctionDetailsModel = await petMartService.myNewAuctionDetails(map);
    return auctionDetailsModel;
  }
  Future<void> auctionLoad() async{
    mAuctionDetailsModel = null;
     _current =0;
     currentBid  =0;

    setState(() {

    });
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String loginData = _preferences.getString(kUserModel);

    Map<String,String> map = Map() ;

    if(loginData == null){
      map['auctionId']= widget.mAuctionModel.id;
      map['customerId']= "";
    }else{
      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      map['auctionId']= widget.mAuctionModel.id;
      map['customerId']= loginModel.data.id;

      print(map);
    }



    PetMartService petMartService = PetMartService();
    mAuctionDetailsModel = await petMartService.myNewAuctionDetails(map);
    _rating =double.parse(mAuctionDetailsModel.data[0].customer.rating);
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auction().then((value){
      setState(() {
        mAuctionDetailsModel = value;
        _rating = double.parse(mAuctionDetailsModel.data[0].customer.rating);

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
      ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kMainColor,
            title: Container(
              alignment: AlignmentDirectional.center,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.h),
                child: Text(
                  languageCode == "en"?widget.mAuctionModel.enTitle:widget.mAuctionModel.arTitle,
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
          key: _scaffoldKey,

        backgroundColor: Color(0xFFFFFFFF),
        body: Container(
          child: mAuctionDetailsModel == null?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          )
              :


          ListView(
            padding: EdgeInsets.zero,

            children: [
              Container(
                height: 200.h,
                width: width,
                child:
                Stack(
                  children: [

                    CarouselSlider(

                      carouselController: _controller,
                      options: CarouselOptions(

                          enableInfiniteScroll: false,

                          height: double.infinity,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          disableCenter: true,






                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }
                      ),
                      items: mAuctionDetailsModel.data[0].image.map((item) =>
                          Stack(


                            children: [

                              GestureDetector(
                                onTap: (){
                                  String url = KImageUrl+item.trim();


                                    if (url.isNotEmpty) {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(new MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return new ZoomClass(
                                              url: url,);
                                          }));
                                    }

                                },


                                child:
                                Stack(
                                  children: [
                                    Container(
                                      width: width,

                                      child:
                                      CachedNetworkImage(
                                        width: width,

                                        fit: BoxFit.fill,
                                        imageUrl:'${KImageUrl+item}',
                                        imageBuilder: (context, imageProvider) => Card(
                                          elevation: 1.h,
                                          child: Container(
                                              width: width,


                                              decoration: BoxDecoration(


                                                image: DecorationImage(


                                                    fit: BoxFit.fill,
                                                    image: imageProvider),
                                              )
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Column(
                                              children: [
                                                Expanded(
                                                  flex: 9,
                                                  child: Container(
                                                    height: height,
                                                    width: width,


                                                    alignment: FractionalOffset.center,
                                                    child: SizedBox(
                                                        height: 50.h,
                                                        width: 50.h,
                                                        child: new CircularProgressIndicator()),
                                                  ),
                                                ),
                                              ],
                                            ),


                                        errorWidget: (context, url, error) => Container(

                                          child:

                                          ClipRRect(
                                              child: Image.asset('assets/images/placeholder_error.png',  color: Color(0x80757575).withOpacity(0.5),fit: BoxFit.fill,
                                                colorBlendMode: BlendMode.difference,)),
                                        ),

                                      ),
                                      // Image.network(
                                      //
                                      //
                                      // '${kBaseUrl}${mAdsPhoto}${item.photo}'  , fit: BoxFit.fitWidth,
                                      //   height: 600.h,),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned.directional(textDirection:  Directionality.of(context),
                                  start: 0,
                                  end: 0,
                                  top: 0,
                                  bottom: 0,
                                   child:
                              Container())

                            ] ,
                          )).toList(),

                    ),
                    Positioned.directional(
                      textDirection: Directionality.of(context),
                      bottom: 10.w,
                      start: 0,
                      end:0,
                      child: Opacity(
                        opacity: mAuctionDetailsModel.data[0].image.length>1?1.0:0.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: mAuctionDetailsModel.data[0].image.map((item) {
                            int index =mAuctionDetailsModel.data[0].image.indexOf(item);
                            return Container(
                              width: 8.0.w,
                              height: 8.0.h,
                              margin: EdgeInsets.symmetric(vertical: 10.0.w, horizontal: 2.0.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? kMainColor
                                    : Color(0xFF707070),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),



                  ],
                ),
              ),
              SizedBox(height: 1.h,
              width: width,
              child: Container(
                color: Color(0x88000000),
              ),),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 6.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageCode =="en"?
                      mAuctionDetailsModel.data[0].enTitle:mAuctionDetailsModel.data[0].enTitle,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(14),
                          fontWeight: FontWeight.normal

                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        String vedioUrl= mAuctionDetailsModel.data[0].video;
                        String title = "";
                        if(languageCode == "en"){
                          title = mAuctionDetailsModel.data[0].enTitle;
                        }else{
                          title = mAuctionDetailsModel.data[0].arTitle;
                        }
                        if(vedioUrl.trim()!=""){
                          if(vedioUrl.contains("youtu")){
                            Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                              return new YouTubeScreen(youtubeId:vedioUrl,auctionName: title);
                            }));
                          }else{
                            Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                              return new VideoScreen(vedioUrl:vedioUrl,auctionName: title,);
                            }));
                          }

                        }

                      },
                      child: Image.asset('assets/images/play-button.png',
                        height: 30.w,width: 30.w,fit: BoxFit.fill,
                        color:mAuctionDetailsModel.data[0].video== ""?Color(0xFFAAAAAA):kMainColor ,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(6.h),
                child: Text(
                  languageCode == "en"?mAuctionDetailsModel.data[0].enTitle:mAuctionDetailsModel.data[0].arTitle,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: screenUtil.setSp(12),
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),
              SizedBox(height: 1.h,
                width: width,
                child: Container(
                  color: Color(0x88000000),
                ),),
              Padding(
                padding:  EdgeInsets.all(4.0.w),
                child: Container(
                  height: 60.h,
                  width: width,
                  child: Row(

                    children: [
                      Expanded(
                        flex: 1,
                        child:

                        CachedNetworkImage(
                          width: 50.w,
                          height: 50.h,
                          imageUrl: KImageUrl+mAuctionDetailsModel.data[0].customer.logo,
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                  width: 50.w,
                                  height: 50.h,

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
                      ),

                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${mAuctionDetailsModel.data[0].customer.name}' ,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: screenUtil.setSp(13),
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            RatingBar.builder(
                              initialRating: _rating,
                              minRating: 0,
                              direction: _isVertical ? Axis.vertical : Axis.horizontal,
                              allowHalfRating: true,
                              unratedColor: Colors.amber.withAlpha(50),
                              itemCount: 5,
                              itemSize: 20.0.h,
                              tapOnlyMode: true,
                              itemPadding: EdgeInsets.symmetric(horizontal: 2.0.w),
                              itemBuilder: (context, _) => Icon(
                                 Icons.star,
                                color: Colors.amber,
                              ),

                              // onRatingUpdate: (rating) {
                              //   setState(() {
                              //     _rating = rating;
                              //   });
                              // },
                              updateOnDrag: false,
                            ),
                          ],
                        ),
                      ),

                    ],

                  ),
                ),
              ),
              SizedBox(height: 1.h,
                width: width,
                child: Container(
                  color: Color(0x88000000),
                ),),

              Container(
                padding: EdgeInsets.all(10.h),
                alignment: AlignmentDirectional.center,
                child: Text(getTranslated(context, 'auction_remaining_time'),style: TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontSize: screenUtil.setSp(13)
                ),),
              ),
              Countdown(
                seconds: getRemainingTime(mAuctionDetailsModel.data[0].endDate),
                build: (BuildContext context, double time) => Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(

                      '${formatDuration(time.toInt())} ${getTranslated(context, 'remaining')} ',
                      style: TextStyle(
                        color: kMainColor,
                        fontSize: screenUtil.setSp(16),
                        fontWeight: FontWeight.bold,

                      )
                  ),
                ),
                interval: Duration(seconds: 1),
                onFinished: () {
                  print('Timer is done!');
                },
              ),
              Container(
                padding: EdgeInsets.all(10.h),
                alignment: AlignmentDirectional.centerStart,
                child: Text('${getTranslated(context,'current_auction_bid')} ${mAuctionDetailsModel.data[0].reach} ${getTranslated(context, 'kwd')}',style: TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                    fontSize: screenUtil.setSp(13)
                ),),
              ),
              Container(
                margin: EdgeInsets.all(6.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
  GestureDetector(
    onTap: (){
        setState(() {
          currentBid = int.parse(mAuctionDetailsModel.data[0].bids[0]);
        });
    },
    child: Container(
        child: currentBid == int.parse(mAuctionDetailsModel.data[0].bids[0])?
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0.h),
            color:kMainColor,

          ),
          child: Text(
            '${int.parse(mAuctionDetailsModel.data[0].bids[0])} ${getTranslated(context, 'kwd')}',
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: screenUtil.setSp(14),
                fontWeight: FontWeight.w500

            ),
          ),
        ):
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0.h),
              color: Color(0xFFFFFFFF),
              border: Border.all(
                  color: Color(0xFFFFC300),
                  width: 1.0.w
              )
          ),
          child: Text(
            '${int.parse(mAuctionDetailsModel.data[0].bids[0])} ${getTranslated(context, 'kwd')}',
            style: TextStyle(
                color: kMainColor,
                fontSize: screenUtil.setSp(14),
                fontWeight: FontWeight.w500

            ),
          ),
        )

    ),
  )
,
  GestureDetector(
        onTap: (){
          setState(() {
            currentBid = int.parse(mAuctionDetailsModel.data[0].bids[1]);
          });
        },
    child: Container(
        child: currentBid == int.parse(mAuctionDetailsModel.data[0].bids[1])?
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0.h),
            color:kMainColor,

          ),
          child: Text(
            '${int.parse(mAuctionDetailsModel.data[0].bids[1])} ${getTranslated(context, 'kwd')}',
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: screenUtil.setSp(14),
                fontWeight: FontWeight.w500

            ),
          ),
        ):
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0.h),
              color: Color(0xFFFFFFFF),
              border: Border.all(
                  color: Color(0xFFFFC300),
                  width: 1.0.w
              )
          ),
          child: Text(
            '${int.parse(mAuctionDetailsModel.data[0].bids[1])} ${getTranslated(context, 'kwd')}',
            style: TextStyle(
                color: kMainColor,
                fontSize: screenUtil.setSp(14),
                fontWeight: FontWeight.w500

            ),
          ),
        )
    ),
  )
  ,
  GestureDetector(
        onTap: (){
          setState(() {
            currentBid = int.parse(mAuctionDetailsModel.data[0].bids[2]);
          });
        },
    child: Container(
        child:currentBid == int.parse(mAuctionDetailsModel.data[0].bids[2])?
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0.h),
            color:kMainColor,

          ),
          child: Text(
            '${int.parse(mAuctionDetailsModel.data[0].bids[2])} ${getTranslated(context, 'kwd')}',
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: screenUtil.setSp(14),
                fontWeight: FontWeight.w500

            ),
          ),
        ):
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0.h),
              color: Color(0xFFFFFFFF),
              border: Border.all(
                  color: Color(0xFFFFC300),
                  width: 1.0.w
              )
          ),
          child: Text(
            '${int.parse(mAuctionDetailsModel.data[0].bids[2])} ${getTranslated(context, 'kwd')}',
            style: TextStyle(
                color: kMainColor,
                fontSize: screenUtil.setSp(14),
                fontWeight: FontWeight.w500

            ),
          ),
        ) ,
    ),
  )

],
                ),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                padding: EdgeInsets.symmetric(horizontal:10.h),
                child: Text(
                 getTranslated(context, 'update_bid_value'),
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: screenUtil.setSp(14),
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                padding: EdgeInsets.symmetric(horizontal:4.h),
                child: Text(
                  '${double.parse(mAuctionDetailsModel.data[0].reach)+currentBid} ${getTranslated(context, 'kwd')}',
                  style: TextStyle(
                      color: kMainColor,
                      fontSize: screenUtil.setSp(20),
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(alignment: AlignmentDirectional.center,
                  child: previewButton(getTranslated(context, 'sumbit_bid'), context))

            ],
          ),
        ),
    ),
      );
  }
  int  getRemainingTime(String date ){
    print('endDate ${date}');
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
  TextButton previewButton(String text,BuildContext context){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFF000000),
      minimumSize: Size(100.w, 40.h),
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

  void sumbitAuction(BuildContext context)  async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String loginData = _preferences.getString(kUserModel);
    if(loginData == null){
      Navigator.pushReplacementNamed(context, LoginScreen.id);

    }else{
      if(currentBid !=0) {
        final body = json.decode(loginData);
        LoginModel loginModel = LoginModel.fromJson(body);
        final modelHud = Provider.of<ModelHud>(context, listen: false);
        modelHud.changeIsLoading(true);
        Map<String,String> map  =  Map();
        map['customerId']=loginModel.data.id;
        map['bidderId']=loginModel.data.id;
        map['auctionId']=mAuctionDetailsModel.data[0].id;
        map['bid']='${double.parse(mAuctionDetailsModel.data[0].reach)+currentBid}';

        PetMartService petMartService = PetMartService();
        BidNewModel bidModel = await petMartService.bid(map);
        bool success = bidModel.ok;
        if (success) {
          modelHud.changeIsLoading(false);
          auctionLoad();
        }
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(bidModel.data.msg)));
      }else{
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'bid_error'))));
      }

    }

  }
  createAuction(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool(kIsLogin)??false;
    if(isLoggedIn){
      sumbitAuction(context);

    }else{
      ShowAlertDialog(context,getTranslated(context, 'not_login'));
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

  String url(String phone,String message) {
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$phone/?text=+965${Uri.parse(message)}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=+965$phone=${Uri.parse(message)}"; // new line
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
