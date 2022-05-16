import 'dart:convert';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/MyNewAuctionDetailsModel.dart';
import 'package:pet_mart/model/auction_details_model.dart';
import 'package:pet_mart/model/delete_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/my_auction_details_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/photo-screen.dart';
import 'package:pet_mart/screens/vedio_screen.dart';
import 'package:pet_mart/screens/youtube_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/StopAuctionModel.dart';
import 'main_sceen.dart';
class MyAuctionDetails extends StatefulWidget {
  String id;
  String postName;
  MyAuctionDetails({Key key,@required this.id,@required this.postName}): super(key: key);

  @override
  _MyAuctionDetailsState createState() => _MyAuctionDetailsState();
}

class _MyAuctionDetailsState extends State<MyAuctionDetails> {
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
  LoginModel   loginModel;
  Future<MyNewAuctionDetailsModel> auction() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
     languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String loginData = _preferences.getString(kUserModel);
    Map<String,String> map  = Map();



      final body = json.decode(loginData);
         loginModel = LoginModel.fromJson(body);
    map['auctionId']= widget.id;
    map['customerId']= loginModel.data.id;
      print(map);





    PetMartService petMartService = PetMartService();
    MyNewAuctionDetailsModel auctionDetailsModel = await petMartService.myNewAuctionDetails(map);
    return auctionDetailsModel;
  }
  // Future<void> auctionLoad() async{
  //   mAuctionDetailsModel = null;
  //   setState(() {
  //
  //   });
  //   SharedPreferences _preferences = await SharedPreferences.getInstance();
  //   String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
  //
  //   String loginData = _preferences.getString(kUserModel);
  //   Map map ;
  //
  //
  //     final body = json.decode(loginData);
  //     LoginModel   loginModel = LoginModel.fromJson(body);
  //     map = {"auction_id":widget.id,
  //       "user_id":loginModel.data.id,
  //       "language":languageCode};
  //
  //
  //
  //
  //
  //   PetMartService petMartService = PetMartService();
  //   mAuctionDetailsModel = await petMartService.myAuctionDetails(map);
  //   _rating = double.parse(mAuctionDetailsModel.data.rating.toDouble());
  //   setState(() {
  //
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auction().then((value){
      setState(() {
        mAuctionDetailsModel = value;
        print("mAuctionDetailsModel.data[0].status ---> ${mAuctionDetailsModel.data[0].status}");
        // _rating = double.parse(mAuctionDetailsModel.data.rating.toString());

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ModalProgressHUD(inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kMainColor,
            title: Container(
              alignment: AlignmentDirectional.center,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.h),
                child: Text(
                  widget.postName,
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
              Stack(
                children: [
                  Container(
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
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
                                    autoPlay: false,
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
                                            String url =KImageUrl+ item;


                                              if (url.isNotEmpty) {
                                                Navigator.of(context, rootNavigator: true)
                                                    .push(new MaterialPageRoute(
                                                    builder: (BuildContext context) {
                                                      return new PhotoScreen(
                                                        imageProvider: NetworkImage(
                                                           url
                                                        ),);
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


                                                  errorWidget: (context, url, error) => ClipRRect(
                                                      child: Image.asset('assets/images/placeholder_error.png',  color: Color(0x80757575).withOpacity(0.5),fit: BoxFit.fill,
                                                        colorBlendMode: BlendMode.difference,)),

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
                        SizedBox(height: 20.h,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
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
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(languageCode == "en"?mAuctionDetailsModel.data[0].enTitle:mAuctionDetailsModel.data[0].arTitle,
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
                                child: Text(getTranslated(context, 'start_date'),
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
                                child: Text('${mAuctionDetailsModel.data[0].endDate}',
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
                                child: Text(getTranslated(context, 'end_date'),
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
                                child: Text(getFormattedDate(mAuctionDetailsModel.data[0].endDate),
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
                                child: Text(getTranslated(context, 'bid_value'),
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
                                child: Text('${mAuctionDetailsModel.data[0].price}',
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
                                child: Text(getTranslated(context, 'current_value'),
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
                                child: Text('${mAuctionDetailsModel.data[0].reach} ${getTranslated(context, 'kwd')}',
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
                                child: Text(getTranslated(context,'participate'),
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
                                child: Text('${mAuctionDetailsModel.data[0].bidders.length} ${getTranslated(context,'person')}',
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
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,





                            itemBuilder: (context,index){
                              return Container(
                                height: 120.h,

                                child: Row(
                                  children: [
                                    Expanded(flex:1,child:Container(
                                      child: CachedNetworkImage(
                                        width: 120.w,
                                        height: 120.h,
                                        imageUrl: KImageUrl+mAuctionDetailsModel.data[0].bidders[index].logo,
                                        imageBuilder: (context, imageProvider) =>
                                            Container(


                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,

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


                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,

                                              image: DecorationImage(
                                                  image: AssetImage('assets/images/icon.png')),
                                            )
                                        ),

                                      ),
                                    )
                                    ), Expanded(flex:2,child:Column(
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: Container(
                                            child: Text(mAuctionDetailsModel.data[0].bidders[index].name,
                                              style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontSize: screenUtil.setSp(16),
                                                  fontWeight: FontWeight.normal
                                              ),),
                                          ),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: Container(
                                            child: Text(mAuctionDetailsModel.data[0].bidders[index].date,
                                              style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontSize: screenUtil.setSp(16),
                                                  fontWeight: FontWeight.normal
                                              ),),
                                          ),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: Container(
                                            child: Text(mAuctionDetailsModel.data[0].bidders[index].bid+" " +getTranslated(context, "kwd"),
                                              style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontSize: screenUtil.setSp(16),
                                                  fontWeight: FontWeight.normal
                                              ),),
                                          ),
                                        ),
                                      ],
                                    )
                                    )
                                  ],
                                ),

                              );
                            }, separatorBuilder: (context,index){
                          return Container(height: 1.h,
                            color: Color(0xFF000000),);}
                            , itemCount:mAuctionDetailsModel.data[0].bidders.length),
                      ],
                    ),
                  ),
                  Positioned.directional( textDirection:  Directionality.of(context),
                      bottom: 0,
                      start: 0,
                      end: 0,
                      child: Container(

                          child:mAuctionDetailsModel.data[0].status== "0"? deleteButton(getTranslated(context, 'stop_auction'),context):Container()))
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

      title: getTranslated(context, 'stop_auction_message'),


      buttons: [
        DialogButton(
          child: Text(
           getTranslated(context, 'ok'),
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
            getTranslated(context, 'no'),
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
    Map<String,String> map = new Map();
    map['customerId'] = loginModel.data.id;
    map['auctionId'] = widget.id;

    PetMartService petMartService = PetMartService();
    StopAuctionModel deleteModel = await petMartService.stopAuction(map);
    bool status = deleteModel.ok;
    modelHud.changeIsLoading(false);
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(deleteModel.data.msg)));

    if(status ){
      Navigator.pushReplacementNamed(context,MainScreen.id);
    }
  }
  String getFormattedDate(String date) {
    /// Convert into local date format.
    var localDate = DateTime.parse(date);

    /// inputFormat - format getting from api or other func.
    /// e.g If 2021-05-27 9:34:12.781341 then format must be yyyy-MM-dd HH:mm
    /// If 27/05/2021 9:34:12.781341 then format must be dd/MM/yyyy HH:mm
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    /// outputFormat - convert into format you want to show.
    var outputFormat = DateFormat('dd MMM AT hh:mm a');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }
  bool compareDate(String date){
    var now = new DateTime.now();
    var localDate = DateTime.parse(date);
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());
    int month = inputDate.month;
    print('month --> ${month}');
    var berlinWallFellDate = new DateTime.utc(inputDate.year, inputDate.month, inputDate.day,inputDate.hour,inputDate.second);
// 0 denotes being equal positive value greater and negative value being less
    if(berlinWallFellDate.compareTo(now)>0)
    {
      return true;
      //peform logic here.....
    }else{
      return false;
    }

  }
}
