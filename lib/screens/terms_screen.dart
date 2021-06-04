import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/cms_model.dart';
import 'package:pet_mart/utilities/constants.dart';
class TermsScreen extends StatefulWidget {
  static String id = 'TermsScreen';
  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  CmsModel cmsModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    privacyPolicy().then((value){
      setState(() {
        cmsModel = value;
      });
    });
  }
  Future<CmsModel> privacyPolicy() async{
    PetMartService petMartService = PetMartService();
    CmsModel  cmsModel = await petMartService.cms('terms-and-condition');
    return cmsModel;

  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil screenUtil = ScreenUtil();
    return Scaffold(

      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
              getTranslated(context, 'terms_conditions'),
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
      body:
      Container(
          color: Color(0xFFFFFFFF),
          child: cmsModel != null?
          SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20.w),
                child: HtmlWidget(


                  cmsModel.data.pageContent,
                  textStyle: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w500,
                      fontSize: screenUtil.setSp(
                          12)

                  ),
                )


            ),
          ):
          Container(
            child: CircularProgressIndicator(),
            alignment: FractionalOffset.center,
          )

      ),
    );
  }
}
