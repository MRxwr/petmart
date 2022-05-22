import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/auction_details_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/rating_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/AuctionBidModel.dart';
import '../model/RatingAuctionModel.dart';
class NotificationDetailsScreen extends StatefulWidget {
  String id;
  String name;
   NotificationDetailsScreen({Key key,@required this.id,@required this.name}) : super(key: key);

  @override
  _NotificationDetailsScreenState createState() => _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  double _ratingOwner=0.0;
  double _ratingBidder=0.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AuctionBidModel mAuctionDetailsModel;
  String userId ;
  String AuctionAwnerId ;
  String highestBidderId;

  String mLanguage ="";

  Future<AuctionBidModel> auction() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    String loginData = _preferences.getString(kUserModel);
    Map<String,String> map = Map() ;

    if(loginData != null){

      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      userId = loginModel.data.id;
      map['auctionId'] = widget.id;
      map['userId'] = userId;


    }




    PetMartService petMartService = PetMartService();
    AuctionBidModel auctionDetailsModel = await petMartService.auctionBidDetails(map);
    return auctionDetailsModel;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auction().then((value){
      setState(() {
        mAuctionDetailsModel = value;
        AuctionAwnerId = mAuctionDetailsModel.data.owner.id;
        highestBidderId = mAuctionDetailsModel.data.winner.id;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: kMainColor,
          title: Container(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.h),
              child: Text(
                widget.name,
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
          child: mAuctionDetailsModel == null?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          ):
              Container(
                margin: EdgeInsets.all(20.w),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getTranslated(context, 'auction_owner'),
                            style: TextStyle(
                              color: kMainColor,
                              fontSize: screenUtil.setSp(16),
                              fontWeight: FontWeight.w600
                            ),),
                            Text(mAuctionDetailsModel.data.owner.name,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: screenUtil.setSp(16),
                                  fontWeight: FontWeight.w600
                              ),),
                            // Text(getTranslated(context, 'category'),
                            //   style: TextStyle(
                            //       color: kMainColor,
                            //       fontSize: screenUtil.setSp(16),
                            //       fontWeight: FontWeight.w600
                            //   ),),
                            // Text(mAuctionDetailsModel.data.category,
                            //   style: TextStyle(
                            //       color: Color(0xFF000000),
                            //       fontSize: screenUtil.setSp(16),
                            //       fontWeight: FontWeight.w600
                            //   ),)

                          ],
                        ),
                        CachedNetworkImage(
                          width: 100.w,
                          height: 100.w,

                          fit: BoxFit.fill,
                          imageUrl:KImageUrl+mAuctionDetailsModel.data.image.toString(),
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


                          errorWidget: (context, url, error) => ClipRRect(
                              child: Image.asset('assets/images/placeholder_error.png',  color: Color(0x80757575).withOpacity(0.5),fit: BoxFit.fill,
                                colorBlendMode: BlendMode.difference,)),

                        ),

                      ],
                    ),
                    // Text(getTranslated(context, 'sub_category'),
                    //   style: TextStyle(
                    //       color: kMainColor,
                    //       fontSize: screenUtil.setSp(16),
                    //       fontWeight: FontWeight.w600
                    //   ),),
                    // Text(mAuctionDetailsModel.data.subCategory,
                    //   style: TextStyle(
                    //       color: Color(0xFF000000),
                    //       fontSize: screenUtil.setSp(16),
                    //       fontWeight: FontWeight.w600
                    //   ),),
                    Text(getTranslated(context, 'auction_description'),
                      style: TextStyle(
                          color: kMainColor,
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.w600
                      ),),
                    Text(mLanguage == "en"?mAuctionDetailsModel.data.enDetails:mAuctionDetailsModel.data.arDetails,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.w600
                      ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(getTranslated(context, 'start_date_string'),
                              style: TextStyle(
                                  color: kMainColor,
                                  fontSize: screenUtil.setSp(16),
                                  fontWeight: FontWeight.w600
                              ),),
                            Text(getFormattedDate(mAuctionDetailsModel.data.startDate),
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: screenUtil.setSp(16),
                                  fontWeight: FontWeight.w600
                              ),),
                          ],
                        ),
                        Column(
                          children: [
                            Text(getTranslated(context, 'end_date_string'),
                              style: TextStyle(
                                  color: kMainColor,
                                  fontSize: screenUtil.setSp(16),
                                  fontWeight: FontWeight.w600
                              ),),
                            Text(getFormattedDate(mAuctionDetailsModel.data.endDate),
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: screenUtil.setSp(16),
                                  fontWeight: FontWeight.w600
                              ),),
                          ],
                        )
                      ],
                    ),SizedBox(height: 10.w,),
                    Container(width: width,
                    height: 1,
                    color: Color(0x44000000),),
                    SizedBox(height: 10.w,),
                    Text(getTranslated(context, 'highest_bidder'),
                      style: TextStyle(
                          color: kMainColor,
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.w600
                      ),),
                    Text(mAuctionDetailsModel.data.winner.name,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.w600
                      ),),
                    Text(getTranslated(context, 'highest_price'),
                      style: TextStyle(
                          color: kMainColor,
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.w600
                      ),),
                    Text("${mAuctionDetailsModel.data.reach}${getTranslated(context, 'kwd')}",
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.w600
                      ),),
                    SizedBox(height: 10.w,),
                    Container(width: width,
                      height: 1,
                      color: Color(0x44000000),),
                    SizedBox(height: 10.w,),
                    Container(
                      child: userId == AuctionAwnerId ?
                          Container()
                      :Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(getTranslated(context, 'rate_auction_awner'),
                            style: TextStyle(
                                color: kMainColor,
                                fontSize: screenUtil.setSp(16),
                                fontWeight: FontWeight.w600
                            ),),
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: mAuctionDetailsModel.data.ownerRated == "1"?
                            RatingBar.readOnly(
                              initialRating:
                              double.parse(mAuctionDetailsModel.data.owner.oRate)
                         ,
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              halfFilledIcon: Icons.star_half,
                              isHalfAllowed: true,

                              filledColor: kMainColor,
                              emptyColor: kMainColor,
                              halfFilledColor: kMainColor,
                              size: 48,
                            ):

                            RatingBar(
                              onRatingChanged: (rating) => setState(() => _ratingOwner = rating),
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              halfFilledIcon: Icons.star_half,
                              isHalfAllowed: true,

                              filledColor: kMainColor,
                              emptyColor: kMainColor,
                              halfFilledColor: kMainColor,
                              size: 48,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(

                      child: userId == highestBidderId ?
                        Container():
                      Column(
                        children: [
                          Text(getTranslated(context, 'rate_highest_bidder'),
                            style: TextStyle(
                                color: kMainColor,
                                fontSize: screenUtil.setSp(16),
                                fontWeight: FontWeight.w600
                            ),),
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            child:mAuctionDetailsModel.data.winnerRated == "1"?
                            RatingBar.readOnly(
                              initialRating:
                              double.parse(mAuctionDetailsModel.data.winner.oRate)
                              ,
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              halfFilledIcon: Icons.star_half,
                              isHalfAllowed: true,

                              filledColor: kMainColor,
                              emptyColor: kMainColor,
                              halfFilledColor: kMainColor,
                              size: 48,
                            )
                            :RatingBar(
                              onRatingChanged: (rating) => setState(() => _ratingBidder = rating),
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              halfFilledIcon: Icons.star_half,
                              isHalfAllowed: true,

                              filledColor: kMainColor,
                              emptyColor: kMainColor,
                              halfFilledColor: kMainColor,
                              size: 48,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.w,),
                    Container(width: width,
                      height: 1,
                      color: Color(0x44000000),),
                    SizedBox(height: 10.w,),
                    Container(
                      child: userId == AuctionAwnerId ?
                          Container():
                      GestureDetector(
                        onTap: (){
                          call(mAuctionDetailsModel.data.owner.mobile);
                        },
                        child: Container(
                          width: width,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.w)),
                            color: kMainColor

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(getTranslated(context, 'auction_owner'),
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: screenUtil.setSp(16),
                                    fontWeight: FontWeight.w600
                                ),),
                              Icon(Icons.call,
                              color: Color(0xFFFFFFFF),
                              size: 25.w,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 14.w,),
                    Container(
                      child:   userId == highestBidderId ?
                          Container():

                      GestureDetector(
                        onTap: (){
                          call(mAuctionDetailsModel.data.winner.mobile);
                        },
                        child: Container(
                          width: width,
                          height: 40.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.w)),
                              color: kMainColor

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(getTranslated(context, 'highest_bidder'),
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: screenUtil.setSp(16),
                                    fontWeight: FontWeight.w600
                                ),),
                              Icon(Icons.call,
                                color: Color(0xFFFFFFFF),
                                size: 25.w,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 14.w,),
                    Container(
                      child: getUserType()?
                          Container():

                      Container(
                        width: width,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.w)),
                            color: Color(0xFFFFC300)

                        ),
                        child: GestureDetector(
                          onTap: (){
                            rating(context);

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(getTranslated(context, 'sumbit_rating'),
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: screenUtil.setSp(16),
                                    fontWeight: FontWeight.w600
                                ),),
                              Icon(Icons.star,
                                color: Color(0xFFFFFFFF),
                                size: 25.w,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
        ),
      ),
    );
  }
  String getFormattedDate(String date) {
    /// Convert into local date format.
    var localDate = DateTime.parse(date);

    /// inputFormat - format getting from api or other func.
    /// e.g If 2021-05-27 9:34:12.781341 then format must be yyyy-MM-dd HH:mm
    /// If 27/05/2021 9:34:12.781341 then format must be dd/MM/yyyy HH:mm
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var inputDate = inputFormat.parse(localDate.toString());

    /// outputFormat - convert into format you want to show.
    var outputFormat = DateFormat('dd MMM yyyy');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  void call(String mobile) async{
    if (await canLaunch('tel://${mobile}')) {
      await launch('tel://${mobile}');
    } else {
      print(' could not launch ');
    }

  }

  void rating(BuildContext context)async {
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.changeIsLoading(true);
    String id;
    double rating = 0.0;
    if(AuctionAwnerId != userId){
      id = AuctionAwnerId;
      rating = _ratingOwner;
    }
    if(highestBidderId != userId){
      id = highestBidderId;
      rating = _ratingBidder;
    }
    print(rating);
    Map<String,String> map = Map();
    map['userId'] = userId;

    map['rate'] = rating.toString();
    map['auctionId'] = widget.id;
    PetMartService petMartService = PetMartService();
    RatingAuctionModel auctionDetailsModel = await petMartService.ratingAuction(map);
    modelHud.changeIsLoading(false);
    bool status = auctionDetailsModel.ok;
    if(status){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'rated_successfuly'))));
Navigator.pop(context,"true");
    }


  }
  bool  getUserType(){
    if(userId == AuctionAwnerId){
      if(mAuctionDetailsModel.data.winnerRated == "1"){
        return true;
      }else{
        return false;
      }


    }else if(userId == highestBidderId){
      if(mAuctionDetailsModel.data.ownerRated == "1"){
        return true;
      }else{
        return false;
      }
    }
  }
}
