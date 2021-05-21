import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/auction_details_model.dart';
import 'package:pet_mart/model/auction_model.dart' as AuctionModel;
import 'package:pet_mart/model/bid_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/post_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/login_screen.dart';
import 'package:pet_mart/screens/photo-screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_count_down.dart';
class AuctionDetailsScreen extends StatefulWidget {
  static String id = 'AuctionDetailsScreen';
  AuctionModel.Data mAuctionModel;
  AuctionDetailsScreen({Key key,@required this.mAuctionModel}): super(key: key);


  @override
  _AuctionDetailsScreenState createState() => _AuctionDetailsScreenState();
}

class _AuctionDetailsScreenState extends State<AuctionDetailsScreen> {
  AuctionDetailsModel mAuctionDetailsModel = null;
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
  Future<AuctionDetailsModel> auction() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String loginData = _preferences.getString(kUserModel);
    Map map ;

    if(loginData == null){
      map = {"auction_id":widget.mAuctionModel.auctionId,
        "user_id":"",
        "language":languageCode};
    }else{
      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      map = {"auction_id":widget.mAuctionModel.auctionId,
        "user_id":loginModel.data.customerId,
        "language":languageCode};
    }




    PetMartService petMartService = PetMartService();
    AuctionDetailsModel auctionDetailsModel = await petMartService.auctionDetails(map);
    return auctionDetailsModel;
  }
  Future<void> auctionLoad() async{
    mAuctionDetailsModel = null;
    setState(() {

    });
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String loginData = _preferences.getString(kUserModel);
    Map map ;

    if(loginData == null){
      map = {"auction_id":widget.mAuctionModel.auctionId,
        "user_id":"",
        "language":languageCode};
    }else{
      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      map = {"auction_id":widget.mAuctionModel.auctionId,
        "user_id":loginModel.data.customerId,
        "language":languageCode};
    }




    PetMartService petMartService = PetMartService();
    mAuctionDetailsModel = await petMartService.auctionDetails(map);
    _rating = mAuctionDetailsModel.data.rating.toDouble();
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
        _rating = mAuctionDetailsModel.data.rating.toDouble();

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
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton:  FloatingActionButton(
            onPressed: () {
              print("true");
             Navigator.pop(context);
            },
            tooltip: 'Increment',
            child:Container(
              alignment: AlignmentDirectional.center,
                width: 60.w, height: 60.w, child: Center(child: Icon(Icons.arrow_back_ios,color: Color(0xFFFFFFFF),))),
            elevation: 2.0,
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
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 10),

                          scrollPhysics:   const NeverScrollableScrollPhysics(),

                          height: double.infinity,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          disableCenter: true,
                          pauseAutoPlayOnTouch: true
                          ,




                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }
                      ),
                      items: mAuctionDetailsModel.data.gallery.map((item) =>
                          Stack(

                            children: [
                              GestureDetector(
                                onTap: (){
                                  String url = item.image.trim();
                                  if(url.isNotEmpty) {
                                    Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                                      return new PhotoScreen(imageProvider: NetworkImage(
                                       url
                                      ),);
                                    }));
                                  }

                                },


                                child:
                                Container(
                                  width: width,

                                  child:
                                  Hero(
                                    tag: 'imageHero',
                                    child: CachedNetworkImage(
                                      width: width,

                                      fit: BoxFit.fill,
                                      imageUrl:'${item.image}',
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
                                          height: height,
                                          width: width,
                                          alignment: FractionalOffset.center,
                                          child: Icon(Icons.image_not_supported)),

                                    ),
                                  ),
                                  // Image.network(
                                  //
                                  //
                                  // '${kBaseUrl}${mAdsPhoto}${item.photo}'  , fit: BoxFit.fitWidth,
                                  //   height: 600.h,),
                                ),
                              ),

                            ] ,
                          )).toList(),

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
                padding: EdgeInsets.all(6.h),
                child: Text(
                  mAuctionDetailsModel.data.auctionName,
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: screenUtil.setSp(13),
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(6.h),
                child: Text(
                  mAuctionDetailsModel.data.auctionDescription,
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
                          imageUrl: mAuctionDetailsModel.data.ownerData.profileImage,
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
                              '${mAuctionDetailsModel.data.ownerData.firstname} ${mAuctionDetailsModel.data.ownerData.lastname}' ,
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
                              itemPadding: EdgeInsets.symmetric(horizontal: 2.0.w),
                              itemBuilder: (context, _) => Icon(
                                 Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  _rating = rating;
                                });
                              },
                              updateOnDrag: true,
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
                child: Text('Auction Remaining Time',style: TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontSize: screenUtil.setSp(13)
                ),),
              ),
              Countdown(
                seconds: getRemainingTime(mAuctionDetailsModel.data.endDate),
                build: (BuildContext context, double time) => Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(

                      '${formatDuration(time.toInt())} Remaining ',
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
                child: Text('Current Auction Bid : ${mAuctionDetailsModel.data.currentBidValue} KWD',style: TextStyle(
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
          currentBid = int.parse(mAuctionDetailsModel.data.bidRange[0]);
        });
    },
    child: Container(
        child: currentBid == int.parse(mAuctionDetailsModel.data.bidRange[0])?
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0.h),
            color:kMainColor,

          ),
          child: Text(
            '${int.parse(mAuctionDetailsModel.data.bidRange[0])} KWD',
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
            '${int.parse(mAuctionDetailsModel.data.bidRange[0])} KWD',
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
            currentBid = int.parse(mAuctionDetailsModel.data.bidRange[1]);
          });
        },
    child: Container(
        child: currentBid == int.parse(mAuctionDetailsModel.data.bidRange[1])?
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0.h),
            color:kMainColor,

          ),
          child: Text(
            '${int.parse(mAuctionDetailsModel.data.bidRange[1])} KWD',
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
            '${int.parse(mAuctionDetailsModel.data.bidRange[1])} KWD',
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
            currentBid = int.parse(mAuctionDetailsModel.data.bidRange[2]);
          });
        },
    child: Container(
        child:currentBid == int.parse(mAuctionDetailsModel.data.bidRange[2])?
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0.h),
            color:kMainColor,

          ),
          child: Text(
            '${int.parse(mAuctionDetailsModel.data.bidRange[2])} KWD',
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
            '${int.parse(mAuctionDetailsModel.data.bidRange[2])} KWD',
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
                  'Updated Bid Value',
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
                  '${int.parse(mAuctionDetailsModel.data.currentBidValue)+currentBid} KWD',
                  style: TextStyle(
                      color: kMainColor,
                      fontSize: screenUtil.setSp(20),
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(alignment: AlignmentDirectional.center,
                  child: previewButton('Submit Bid', context))

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

       sumbitAuction(context);

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
        Map map = {
          'auction_id': mAuctionDetailsModel.data.auctionId,
          'user_id': loginModel.data.customerId,
          'bid_value': currentBid.toString(),
          'rating': _rating.toString(),

          'language': languageCode
        };
        PetMartService petMartService = PetMartService();
        BidModel bidModel = await petMartService.postAuctionModel(map);
        String success = bidModel.status;
        if (success == 'success') {
          modelHud.changeIsLoading(false);
          auctionLoad();
        }
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(bidModel.message)));
      }else{
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Please choose Pid ")));
      }

    }

  }
}
