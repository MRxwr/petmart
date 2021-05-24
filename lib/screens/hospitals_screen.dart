import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/hospitals_model.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hospital_details_screen.dart';
class HospitalsScreen extends StatefulWidget {
  const HospitalsScreen({Key key}) : super(key: key);

  @override
  _HospitalsScreenState createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  HospitalsModel hospitalModel;
  double itemWidth;
  double itemHeight;
  ScreenUtil screenUtil = ScreenUtil();
  String mLanguage ="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHospitals().then((value) {
      setState(() {
        hospitalModel = value;
      });
    });
  }
  Future<HospitalsModel> getHospitals()async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    PetMartService petMartService = PetMartService();
    HospitalsModel hospitalModel =await petMartService.hospital();
    return hospitalModel;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    itemWidth = width / 2;
    itemHeight = 220.h;
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: kMainColor,
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
              'Hospital',
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
        child: hospitalModel == null?
        Container(
          child: CircularProgressIndicator(


          ),
          alignment: AlignmentDirectional.center,
        ):Container(
    margin: EdgeInsets.all(10.w),
         child:
         GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio:itemWidth/itemHeight),
          itemCount: hospitalModel.data.length,
          itemBuilder: (context,index){
            return GestureDetector(child:
            Card(child: buildItem(hospitalModel.data[index],context),
              margin: EdgeInsets.all(4.h),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 1.w,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0.h),
              ),
              color: Color(0xFFFFFFFF),)
              ,onTap: (){
              String mHospitalName = mLanguage=="ar"?hospitalModel.data[index].nameArabic:hospitalModel.data[index].nameEnglish;
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                  return new HospitalDetailsScreen(id:hospitalModel.data[index].id,name: mHospitalName);
                }));
              },);
          },
        ),
        )
        ,
      ),
    );
  }
  Widget buildItem(Data data, BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: itemWidth,
                  imageUrl:data.logoImage,
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

              ],
            ),
          ),
          Expanded(flex:2,child: Container(
            child: Column(
              children: [
                Expanded(flex:1,child:
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.h),
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    mLanguage== "en"?data.nameEnglish:data.nameArabic,
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                        fontSize: screenUtil.setSp(12)
                    ),

                  ),
                )),
                Expanded(flex:1,
                    child:
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              image: new AssetImage("assets/images/share.png"),
                              width: 15.w,
                              height: 15.h,
                              color: Color(0xFFB7B7B7),
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                            ),
                            Text(
                              data.shared,
                              style: TextStyle(
                                  color: Color(0xFFB7B7B7),
                                  fontSize: screenUtil.setSp(18),
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image(
                              image: new AssetImage("assets/images/view_btn.png"),
                              width: 15.w,
                              height: 15.h,
                              color: Color(0xFFB7B7B7),
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                            ),
                            Text(
                              data.mostView,
                              style: TextStyle(
                                  color: Color(0xFFB7B7B7),
                                  fontSize: screenUtil.setSp(18),
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))

              ],
            ),
          ))

        ],
      ),
    );

  }
}