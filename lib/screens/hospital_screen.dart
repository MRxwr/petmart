import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/hospital_model.dart';
import 'package:pet_mart/screens/shop_details_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HospitalScreen extends StatefulWidget {
  const HospitalScreen({Key key}) : super(key: key);

  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  HospitalModel hospitalModel;
  double itemWidth;
  double itemHeight;
  ScreenUtil screenUtil = ScreenUtil();
  String mLanguage ="";

  Future<HospitalModel> getHospitals()async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    PetMartService petMartService = PetMartService();
    HospitalModel hospitalModel =await petMartService.hospitals();
    return hospitalModel;
  }
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
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    itemWidth = width / 2;
    itemHeight = 200.h;
    return Scaffold(

      appBar:
      AppBar(
        backgroundColor: kMainColor,
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
              getTranslated(context, 'shop'),
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
  child: GridView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: const AlwaysScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
        childAspectRatio:itemWidth/itemHeight),
    itemCount: hospitalModel.data.length,
    itemBuilder: (context,index){
      return GestureDetector(child: buildItem(hospitalModel.data[index],context)
        ,onTap: (){
          String mHospitalName = hospitalModel.data[index].shopName;
          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
            return new ShopDetailsScreen(id:hospitalModel.data[index].shopId,name: mHospitalName);
          }));

        },);
    },
  )
),
      ),
    );
  }
  Container buildItem(Data hospitalModel, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.h),
      child: Column(
        children: [
          Expanded(child:
          CachedNetworkImage(
            width: 150.w,
            height: 150.h,
            imageUrl:'${hospitalModel.shopImage}',
            imageBuilder: (context, imageProvider) =>
                Container(
                    width: 150.w,
                    height: 150.h,

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
                width: 140.w,
                height: 140.h,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 1.h, style: BorderStyle.solid),
                   image: DecorationImage(
                     fit: BoxFit.fill,


                      image: AssetImage('assets/images/icon.png')),
                )
            ),

          ),
            flex: 4,),
          Expanded(child: Container(
            alignment: AlignmentDirectional.center,
            child: Text(
              hospitalModel.shopName,
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: screenUtil.setSp(12),
                  fontWeight: FontWeight.normal
              ),
            ),
          ),
            flex: 1,)
        ],
      ),
    );

  }
}
