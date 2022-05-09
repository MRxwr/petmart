import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/MyPostsModel.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/post_model.dart' as Model;
import 'package:pet_mart/model/type_model.dart';
import 'package:pet_mart/screens/post_details_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyPostScreen extends StatefulWidget {
  static String id = 'MyPostScreen';
  @override
  _MyPostScreenState createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  List<TypeModel> typesList = List();
  double itemWidth;
  double itemHeight;
  int selectedIndex =0;
  String mLanguage ="";
  String userId = "";
  MyPostsModel postModel;
  List<Sale> products =null;
  bool isOk ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typesList.add(TypeModel(typeNameAr: 'الكل',typeNameEn: 'All',key: 'all',selected: true));
    typesList.add(TypeModel(typeNameAr: 'تبني',typeNameEn: 'Adaption',key: 'adoption',selected: false));
    typesList.add(TypeModel(typeNameAr: 'مفقود',typeNameEn: 'Lost',key: 'lost-animal',selected: false));
    typesList.add(TypeModel(typeNameAr: 'للبيع',typeNameEn: 'OnSale',key: 'sell',selected: false));
    map().then((value) {
      userId = value["userId"];
      mLanguage = value['language'];
    }).whenComplete(() {
      posts("all").then((value) {

          isOk  = value['ok'];
        products = [];
        if(isOk){
         postModel = MyPostsModel.fromJson(value);

          products..addAll(postModel.data.items.lost);
          products..addAll(postModel.data.items.adoption);
          products..addAll(postModel.data.items.sale);
        }

        // for(int i =0;i< postModel.data.items.lost.length;i++){
        //   products.add(postModel.data.items.lost[i]);
        //
        // }
        // for(int i =0;i< postModel.data.items.adoption.length;i++){
        //   products.add(postModel.data.items.adoption[i]);
        //
        // }
        // for(int i =0;i< postModel.data.items.sale.length;i++){
        //   products.add(postModel.data.items.sale[i]);
        //
        // }
        setState(() {

        });

      });
    });


  }
  String languageCode;
  Future<Map> map() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
     languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    String loginData = _preferences.getString(kUserModel);
    final body = json.decode(loginData);
    LoginModel   loginModel = LoginModel.fromJson(body);
    Map map ;
    map = {"language":languageCode,
    "userId":loginModel.data.id};
    return map;
  }
  Future<Map<String, dynamic>> posts(String type) async{
    Map map;
    map = {
      "user_id":userId,
      "language":mLanguage,
    "post_type":type};





    PetMartService petMartService = PetMartService();
    Map<String, dynamic>   response  = await petMartService.myPosts(userId);
    return response;
  }
  Future<void> postList(String type) async{
    products = [];
    if(isOk) {
      if (type == "all") {
        products = [];
        // for(int i =0;i< postModel.data.items.lost.length;i++){
        //   products.add(postModel.data.items.lost[i]);
        //
        // }
        // for(int i =0;i< postModel.data.items.adoption.length;i++){
        //   products.add(postModel.data.items.adoption[i]);
        //
        // }
        // for(int i =0;i< postModel.data.items.sale.length;i++){
        //   products.add(postModel.data.items.sale[i]);
        //
        // }
        products..addAll(postModel.data.items.lost);
        products..addAll(postModel.data.items.adoption);
        products..addAll(postModel.data.items.sale);
      } else if (type == "adoption") {
        products = [];
        products..addAll(postModel.data.items.adoption);
      } else if (type == "lost-animal") {
        products = [];
        products..addAll(postModel.data.items.lost);
        // for (int i = 0; i < postModel.data.items.lost.length; i++) {
        //   products.add(postModel.data.items.lost[i]);
        // }
      } else if (type == "sell") {
        products = [];
        products..addAll(postModel.data.items.sale);
        // for(int i =0;i< postModel.data.items.sale.length;i++){
        //   products.add(postModel.data.items.sale[i]);
        //
        // }
      }
    }
   setState(() {

   });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    itemWidth = width / 2;
    itemHeight = 240.h;
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: kMainColor,
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
              getTranslated(context, 'my_post'),
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
        child:
        mLanguage == ""?
        Container(
          child: CircularProgressIndicator(


          ),
          alignment: AlignmentDirectional.center,
        ):ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,



          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: 5.h,width: width,
            ),
            Container(
              height: 35.h,
              child: ListView.separated(

                  scrollDirection: Axis.horizontal,

                  itemBuilder: (context,index){
                    return
                      GestureDetector(
                        onTap: (){
                          bool selectedIndex = typesList[index].selected;
                          print('selectedIndex ${selectedIndex}');

                          if(!selectedIndex){
                            for(int i =0;i<typesList.length;i++){
                              if(i == index){
                                typesList[i].selected= true;
                              }else{
                                typesList[i].selected= false;
                              }

                            }


                            setState(() {

                            });
                          postList(typesList[index].key);


                          }

                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: selectRow(typesList[index],context,index,mLanguage)),
                      );
                  }
                  ,
                  separatorBuilder: (context,index) {
                    return Container(height: 10.h,
                      color: Color(0xFFFFFFFF),);
                  }
                  ,itemCount: typesList.length),
            ),
            SizedBox(height: 5.h,width: width,
            ),
            SizedBox(height: 1.h,width:width ,
              child: Container(
                color: Color(0x66000000),
              ),),
            SizedBox(height: 5.h,width: width,
            ),
            Container(
              child:products == null?
              Container(
                child: CircularProgressIndicator(


                ),
                alignment: AlignmentDirectional.center,
              ):
              products.isEmpty?

              Container(
                child: Text(
                  getTranslated(context, 'no_product_available'),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: screenUtil.setSp(16),
                      fontWeight: FontWeight.w600
                  ),
                ),
                alignment: AlignmentDirectional.center,
              )
                  :
              GridView.builder(scrollDirection: Axis.vertical,


                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio:itemWidth/itemHeight),
                itemCount: products.length,

                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                        return new PostDetailsScreen(postId:products[index].id,postName:languageCode =="en"? products[index].enTitle:products[index].arTitle ,);
                      }));
                    },
                    child: Container(
                        margin: EdgeInsets.all(6.w),

                        child:
                        Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 1.w,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0.h),
                            ),
                            color: Color(0xFFFFFFFF),
                            child: buildItem(products[index],context))),
                  );
                },
              ),
            ),
          ],
        ),

      ),
    );
  }
  Container selectRow(TypeModel category,BuildContext context,int selectedIndex,String mLangauage){

    return
      Container(
        child:
        typesList[selectedIndex].selected?
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0.h),
              color: kMainColor
          ),
          child: Text(mLangauage =="en"?category.typeNameEn:
            category.typeNameAr,
            style: TextStyle(
                color: Color(0xCC000000),
                fontSize: screenUtil.setSp(14),
                fontWeight: FontWeight.w500

            ),
          ),
        ) :
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0.h),
              color: Color(0xFFFFFFFF),
              border: Border.all(
                  color: Color(0xCC000000),
                  width: 1.0.w
              )
          ),
          child: Text(
            mLangauage =="en"?category.typeNameEn:
            category.typeNameAr,
            style: TextStyle(
                color: Color(0xCC000000),
                fontSize: screenUtil.setSp(14),
                fontWeight: FontWeight.w500

            ),
          ),
        ),
      );
  }
  Widget buildItem(Sale data, BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: itemWidth,
                  imageUrl:kImagePath+data.image,
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
                      child: Image.asset('assets/images/placeholder_error.png',  color: Color(0x80757575).withOpacity(0.6),
                        colorBlendMode: BlendMode.difference,)),

                ),
                Positioned.directional(
                  textDirection:  Directionality.of(context),
                  bottom: 2.h,
                  start: 10.w,
                  child: Text(
                    data.date.split(" ")[0],
                    style: TextStyle(
                        color: Color(0xFF000000)

                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(flex:1,child: Container(
            child: Column(
              children: [
                Expanded(flex:1,child:
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),

                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    languageCode =="en"? data.enTitle:data.arTitle,
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                        fontSize: screenUtil.setSp(14)
                    ),

                  ),
                )),

              ],
            ),
          ))

        ],
      ),
    );

  }
}
