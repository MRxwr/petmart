import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/credit_model.dart';
import 'package:pet_mart/model/package_model.dart' as Model;
import 'package:pet_mart/screens/payment_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CreditScreen extends StatefulWidget {

  CreditScreen({Key key}) : super(key: key);

  @override
  _CreditScreenState createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  String mLanguage ="";
  Future<Model.PackageModel> package() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
mLanguage = languageCode;

    Map map ;


    map = {"language":languageCode};




    PetMartService petMartService = PetMartService();
    Model.PackageModel packageModel = await petMartService.package();
    return packageModel;
  }
  ScreenUtil screenUtil = ScreenUtil();
  Model.PackageModel packageModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    package().then((value) {
      setState(() {
        packageModel = value;
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
              getTranslated(context, 'package'),
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
      body: packageModel == null ? Container(
        child: CircularProgressIndicator(


        ),
        alignment: AlignmentDirectional.center,
      )
      :Container(
        margin: EdgeInsets.all(10.w),
        child: ListView.separated(
            scrollDirection: Axis.vertical,


            shrinkWrap: true,


            itemBuilder: (context,index){
              return Container(
                height: 120.h,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.h,
                        color: kMainColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.h)),

                  ),
                child: Column(
                  children: [
                    Expanded(flex: 2,
                        child:Row(
                          children: [
                            Expanded(flex:1,child:Container(
                              child: CachedNetworkImage(
                                width: 50.w,
                                height: 50.h,
                                imageUrl: KImageUrl+packageModel.data.package[index].image,
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
                            ), Expanded(flex:2,child:Container(
                              child: Text(mLanguage == "en"?packageModel.data.package[index].enDetails:packageModel.data.package[index].arDetails,
                              style: TextStyle(
                                color: Color(0xAAAAAAAA),
                                fontSize: screenUtil.setSp(10),
                                fontWeight: FontWeight.normal
                              ),),
                            )
                            )
                          ],
                        )),
                    Expanded(flex:1,child: Container(
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(mLanguage == "en"?packageModel.data.package[index].enTitle:packageModel.data.package[index].arTitle,
                                style: TextStyle(
                                    color: kMainColor,
                                    fontSize: screenUtil.setSp(10),
                                    fontWeight: FontWeight.bold
                                ),),
                              Text(packageModel.data.package[index].points,
                                style: TextStyle(
                                    color: kMainColor,
                                    fontSize: screenUtil.setSp(10),
                                    fontWeight: FontWeight.normal
                                ),),
                            ],
                          ),
                          Column(
                            children: [
                              Text('${getTranslated(context, 'valid_for')} ${packageModel.data.package[index].validity}',
                                style: TextStyle(
                                    color: kMainColor,
                                    fontSize: screenUtil.setSp(10),
                                    fontWeight: FontWeight.normal
                                ),),
                              Text(packageModel.data.package[index].price,
                                style: TextStyle(
                                    color: kMainColor,
                                    fontSize: screenUtil.setSp(10),
                                    fontWeight: FontWeight.bold
                                ),),
                            ],
                          ),
                          confirmButton(getTranslated(context, 'buy'),context,index)
                        ],
                      )
                    ))
                  ],
                ),

              );
            }, separatorBuilder: (context,index){
    return Container(height: 10.h,
    color: Color(0xFFFFFFFF),);}
    , itemCount:packageModel.data.package.length),
      ),
    );
  }
  TextButton confirmButton(String text,BuildContext context,int index){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFF000000),
      minimumSize: Size(60.w, 20.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: Color(0xFFFFC300),
    );

    return TextButton(
      style: flatButtonStyle,
      // onPressed: () {
      //   Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
      //     return new PaymentScreen(packageModel: packageModel.data.package[index]);
      //
      //   }));
      //
      // },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(10),
          fontWeight: FontWeight.bold
      ),),
    );
  }
}
