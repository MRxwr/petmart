import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/hospital_details_model.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HospitalDetailsScreen extends StatefulWidget {
  String id;
  String name;
  HospitalDetailsScreen({Key key,@required this.id,@required this.name}): super(key: key);

  @override
  _HospitalDetailsScreenState createState() => _HospitalDetailsScreenState();
}

class _HospitalDetailsScreenState extends State<HospitalDetailsScreen> {
String mLanguage;
HospitalDetailsModel hospitalDetailsModel;
  ScreenUtil screenUtil = ScreenUtil();
  Future<HospitalDetailsModel> getHospitals()async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    PetMartService petMartService = PetMartService();
    HospitalDetailsModel hospitalModel =await petMartService.hospitalDetails(widget.id);
    return hospitalModel;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHospitals().then((value) {
      setState(() {
        hospitalDetailsModel = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
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

        ],

      ),
      body: Container(
        child: hospitalDetailsModel == null?
        Container(
          child: CircularProgressIndicator(


          ),
          alignment: AlignmentDirectional.center,
        ):
        Container(
          margin: EdgeInsets.all(10.w),
          child: ListView(
            children: [
              Container(
                width: screenUtil.screenWidth,
                height: 150.h,
                child: CachedNetworkImage(
                  width: screenUtil.screenWidth,
                  height: 150.h,

                  fit: BoxFit.fill,
                  imageUrl:'http://petmart.createkwservers.com/media/images/hospital/${hospitalDetailsModel.data.logoImage}',
                  imageBuilder: (context, imageProvider) => Container(
                      width: screenUtil.screenWidth,


                      decoration: BoxDecoration(


                        image: DecorationImage(


                            fit: BoxFit.fill,
                            image: imageProvider),
                      )
                  ),
                  placeholder: (context, url) =>
                      Column(
                        children: [
                          Expanded(
                            flex: 9,
                            child: Container(
                              height: 150.h,
                              width: screenUtil.screenWidth,


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
                      height: 150.h,
                      width: screenUtil.screenWidth,
                      alignment: FractionalOffset.center,
                      child: Icon(Icons.image_not_supported)),

                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  children: [
                    Image(
                      image: new AssetImage("assets/images/pawprint.png"),
                      width: 30.w,
                      height: 30.h,
                      color: Color(0xFF51a2c0),
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                    ),
                    SizedBox(width: 5.w,),
                    Text(
                      widget.name,
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(18),
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    callButton('CALL NOW ',context),
                    details('DETAILS ',context),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(mLanguage=="en"?hospitalDetailsModel.data.detailsEnglish:
                  hospitalDetailsModel.data.detailsArabic,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: screenUtil.setSp(18),
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),
              SizedBox(height: 1.h,
                width: screenUtil.screenWidth,
                child: Container(
                  color: Color(0x88AAAAAA),
                ),),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image(
                          image: new AssetImage("assets/images/share.png"),
                          width: 30.w,
                          height: 30.h,
                          color: Color(0xFF000000),
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        ),
                        Text(
                          hospitalDetailsModel.data.shared,
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: screenUtil.setSp(18),
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          image: new AssetImage("assets/images/view_btn.png"),
                          width: 30.w,
                          height: 30.h,
                          color: Color(0xFF000000),
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        ),
                        Text(
                          hospitalDetailsModel.data.mostView,
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: screenUtil.setSp(18),
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h,
                width: screenUtil.screenWidth,
                child: Container(
                  color: Color(0x88AAAAAA),
                ),),
            ],
          ),
        )
      ),
    );
  }
TextButton callButton(String text,BuildContext context){
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Color(0xFFFFC300),
    minimumSize: Size(50.w, 35.h),
    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
    shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
    ),
    backgroundColor: Color(0xFFFFC300),
  );

  return TextButton(
    style: flatButtonStyle,
    onPressed: () {


    },
    child: Text(text,style: TextStyle(
        color: Color(0xFF000000),
        fontSize: screenUtil.setSp(14),
        fontWeight: FontWeight.w500
    ),),
  );
}
TextButton details(String text,BuildContext context){
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: kMainColor,
    minimumSize: Size(65.w, 35.h),
    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
    shape:  RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
    ),
    backgroundColor: kMainColor,
  );

  return TextButton(
    style: flatButtonStyle,
    onPressed: () {



    },
    child: Text(text,style: TextStyle(
        color: Color(0xFF000000),
        fontSize: screenUtil.setSp(14),
        fontWeight: FontWeight.w500
    ),),
  );
}

}
