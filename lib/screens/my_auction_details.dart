import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/auction_details_model.dart';
import 'package:pet_mart/model/delete_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/my_auction_details_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/photo-screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_sceen.dart';
class MyAuctionDetails extends StatefulWidget {
  String id;
  MyAuctionDetails({Key key,@required this.id}): super(key: key);

  @override
  _MyAuctionDetailsState createState() => _MyAuctionDetailsState();
}

class _MyAuctionDetailsState extends State<MyAuctionDetails> {
  MyAuctionDetailsModel mAuctionDetailsModel = null;
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
  Future<MyAuctionDetailsModel> auction() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String loginData = _preferences.getString(kUserModel);
    Map map ;


      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      map = {"auction_id":widget.id,
        "user_id":loginModel.data.customerId,
        "language":languageCode};





    PetMartService petMartService = PetMartService();
    MyAuctionDetailsModel auctionDetailsModel = await petMartService.myAuctionDetails(map);
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


      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      map = {"auction_id":widget.id,
        "user_id":loginModel.data.customerId,
        "language":languageCode};





    PetMartService petMartService = PetMartService();
    mAuctionDetailsModel = await petMartService.myAuctionDetails(map);
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
    return ModalProgressHUD(inAsyncCall: Provider.of<ModelHud>(context).isLoading,
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
              Stack(
                children: [
                  Container(
                    child: ListView(
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
                                            CachedNetworkImage(
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


                                              errorWidget: (context, url, error) => ClipRRect(
                                                  child: Image.asset('assets/images/placeholder_error.png',  color: Color(0x80757575).withOpacity(0.5),
                                                    colorBlendMode: BlendMode.difference,fit: BoxFit.fill,)),

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
                        SizedBox(height: 20.h,),
            Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(mAuctionDetailsModel.data.auctionName,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: screenUtil.setSp(16),
                            fontWeight: FontWeight.bold
                        )
                    ),
            ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(mAuctionDetailsModel.data.auctionDescription,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: screenUtil.setSp(16),
                                  fontWeight: FontWeight.normal
                              )
                          ),
                        ),

                        Row(

                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('Start Date : ',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(16),
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child:
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('${mAuctionDetailsModel.data.auctionDate}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(16),
                                        fontWeight: FontWeight.normal
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(

                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('End Date : ',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(16),
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child:
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('${mAuctionDetailsModel.data.endDate}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(16),
                                        fontWeight: FontWeight.normal
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(

                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('Bid Value : ',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(16),
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child:
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('${mAuctionDetailsModel.data.bidValue}',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(16),
                                        fontWeight: FontWeight.normal
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(

                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('Current Value : ',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(16),
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child:
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('${mAuctionDetailsModel.data.currentBidValue} KWD',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(16),
                                        fontWeight: FontWeight.normal
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(

                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('Participate : ',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(16),
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child:
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text('${mAuctionDetailsModel.data.totalParticipate} Person',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: screenUtil.setSp(16),
                                        fontWeight: FontWeight.normal
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned.directional( textDirection:  Directionality.of(context),
                      bottom: 0,
                      start: 0,
                      end: 0,
                      child: deleteButton('Stop Auction',context))
                ],
              ),
          ),
        ));
  }
  TextButton deleteButton(String text,BuildContext context){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFFFF0000),
      minimumSize: Size(65.w, 50.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),

      backgroundColor: Color(0xFFFF0000),
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {
        ShowLanguageDialog(context);


      },
      child: Text(text,style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: screenUtil.setSp(18),
          fontWeight: FontWeight.bold
      ),),
    );
  }
  Future<void> ShowLanguageDialog(BuildContext context) async{
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

      title: "Are you sure want to stop this auction?",


      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async{
            await alert.dismiss();
            deleteAuction();
            // _changeLanguage('en').then((value) {
            //   Navigator.of(context).pushReplacementNamed( MainScreen.id);
            // });


          },
          color: Color(0xFFFF0000),
          radius: BorderRadius.circular(6.w),
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Color(0xFF000000), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        )
      ],
    );
    alert.show();

  }
  void deleteAuction()async{
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.changeIsLoading(true);
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    Map map;
    map = {
      'auction_id': widget.id,


      'language': languageCode
    };
    PetMartService petMartService = PetMartService();
    DeleteModel deleteModel = await petMartService.deleteAuction(map);
    String status = deleteModel.status;
    modelHud.changeIsLoading(false);
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(deleteModel.message)));

    if(status == 'success'){
      Navigator.pushReplacementNamed(context,MainScreen.id);
    }
  }
}
