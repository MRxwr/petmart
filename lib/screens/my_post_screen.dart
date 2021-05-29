import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/post_model.dart' as Model;
import 'package:pet_mart/model/type_model.dart';
import 'package:pet_mart/screens/post_details_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
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
  Model.PostModel postModel;

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
        setState(() {
          postModel = value;
        });

      });
    });


  }
  Future<Map> map() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    String loginData = _preferences.getString(kUserModel);
    final body = json.decode(loginData);
    LoginModel   loginModel = LoginModel.fromJson(body);
    Map map ;
    map = {"language":languageCode,
    "userId":loginModel.data.customerId};
    return map;
  }
  Future<Model.PostModel> posts(String type) async{
    Map map;
    map = {
      "user_id":userId,
      "language":mLanguage,
    "post_type":type};





    PetMartService petMartService = PetMartService();
    Model.PostModel postModel = await petMartService.myPosts(map);
    return postModel;
  }
  Future<void> postList(String type) async{
    Map map;
    map = {
      "user_id":userId,
      "language":mLanguage,
      "post_type":type};





    PetMartService petMartService = PetMartService();
   postModel = await petMartService.myPosts(map);
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
              'My Post',
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

                            postModel = null;
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
              child:postModel == null?
              Container(
                child: CircularProgressIndicator(


                ),
                alignment: AlignmentDirectional.center,
              ):
              GridView.builder(scrollDirection: Axis.vertical,


                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio:itemWidth/itemHeight),
                itemCount: postModel.data.length,

                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                        return new PostDetailsScreen(postId:postModel.data[index].postId);
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
                            child: buildItem(postModel.data[index],context))),
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
  Widget buildItem(Model.Data data, BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: itemWidth,
                  imageUrl:data.postImage,
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
                    data.postDate,
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
                    data.postName,
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                        fontSize: screenUtil.setSp(14)
                    ),

                  ),
                )),
                Expanded(flex:1,child:
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/placeholder_image_count.png'),
                  Container(
                    padding: EdgeInsetsDirectional.only( start: 2.w),
                    child:
                    Container(


                      child: Text(

                        data.imageCount.toString(),

                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.normal,
                            fontSize: screenUtil.setSp(14)
                        ),

                      ),
                    ),
                  ),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            padding: EdgeInsetsDirectional.only( start: 2.w),
                            child:
                            Container(


                              child: Text(

                                data.postType.toString(),

                                style: TextStyle(
                                    color: kMainColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: screenUtil.setSp(14)
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
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
