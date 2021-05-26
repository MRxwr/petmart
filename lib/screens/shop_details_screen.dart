import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/shopdetails_model.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ShopDetailsScreen extends StatefulWidget {
  String id;
  String name;
  ShopDetailsScreen({Key key,@required this.id,@required this.name}): super(key: key);

  @override
  _ShopDetailsScreenState createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  String mLanguage="";
  ScreenUtil screenUtil = ScreenUtil();
  ShopdetailsModel shopdetailsModel;
  Future<ShopdetailsModel> getShopDetails()async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    PetMartService petMartService = PetMartService();
    Map map = {
      "shop_id":widget.id
    };
    ShopdetailsModel shopdetailsModel =await petMartService.shopDetails(map);
    return shopdetailsModel;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShopDetails().then((value) {
      setState(() {
        shopdetailsModel = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar:     AppBar(
  backgroundColor: kMainColor,
  title: Container(
    alignment: AlignmentDirectional.center,
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.h),
      child: Text(
        '${widget.name}',
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
        margin: EdgeInsets.all(10.h),

      ),
    );
  }
}
