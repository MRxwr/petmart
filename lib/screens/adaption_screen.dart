import 'dart:convert';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/home_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/post_model.dart' as PostModel;
import 'package:pet_mart/screens/adaption_details_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AdaptionScreen extends StatefulWidget {
  static String id = 'AdaptionScreen';
  @override
  _AdaptionScreenState createState() => _AdaptionScreenState();
}

class _AdaptionScreenState extends State<AdaptionScreen> {
  HomeModel homeModel;
  List<bool> selectedList = List();
  PostModel.PostModel postModel;
  List<Categories> categories = List();
  ScreenUtil screenUtil = ScreenUtil();
  double itemWidth;
  String languageCode;
  double itemHeight;
  int selectedIndex =0;

  Future<HomeModel> getHomeModel() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String homeString = sharedPreferences.getString("home");

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;


      final body = json.decode(homeString);
    homeModel = HomeModel.fromJson(body);


    String categoryId = "0";
    Categories category = Categories(id:categoryId,enTitle:getTranslated(context, 'all'),arTitle:getTranslated(context, 'all'),logo: "");
    categories.add(category);
    selectedList.add(true);

    for(int i =0;i<homeModel.data.categories.length;i++){
      categories.add(homeModel.data.categories[i]);
      selectedList.add(false);
    }


    return homeModel;
  }
  Future<PostModel.PostModel> post(String catId) async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;


    PetMartService petMartService = PetMartService();
   PostModel.PostModel postModel = await petMartService.post("adoption",catId);
    return postModel;
  }
  void getList(String catId) async{
postModel = null;
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    Map map ;
    map = {"id":catId,
      "type":"adoption",
      "language":languageCode};
    print(' PostModel --> ${map}');
    PetMartService petMartService = PetMartService();
     postModel = await petMartService.post("adoption",catId);
     setState(() {

     });

  }
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getHomeModel().whenComplete(() {
      post(categories[0].id).then((value) {
        postModel = value;
        setState(() {

        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
      itemWidth = width / 2;
      itemHeight = 200.h;
    return Scaffold(
      body: Container(
          margin: EdgeInsets.all(10.w),
          child:
              ListView(


                children: [
                  Container(
                    height: 35.h,
                    child: ListView.separated(

                        scrollDirection: Axis.horizontal,

                        itemBuilder: (context,index){
                          return
                            GestureDetector(
                              onTap: (){
                                bool selectedIndex = selectedList[index];
                                if(!selectedIndex){
                                  for(int i =0;i<selectedList.length;i++){
                                    if(i == index){
                                      selectedList[i]= true;
                                    }else{
                                      selectedList[i]= false;
                                    }
                                  }
                                  print(selectedList);
                                  postModel = null;
                                  setState(() {

                                  });
                                   getList(categories[index].id);


                                }

                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: selectRow(categories[index],context,index)),
                            );
    }
   ,
                        separatorBuilder: (context,index) {
                          return Container(height: 10.h,
                            color: Color(0xFFFFFFFF),);
                        }
    ,itemCount: categories.length),
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
                    alignment: AlignmentDirectional.center,
                    child:
                    postModel== null?
                    Container(
                      child: CircularProgressIndicator(


                      ),
                      alignment: AlignmentDirectional.center,
                    ):
                        postModel.data.items.isEmpty?

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
                      itemCount: postModel.data.items.length,

                      itemBuilder: (context,index){
                        return
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                                return new AdaptionDetailsScreen(postId:postModel.data.items[index].id,postName:languageCode =="en"? postModel.data.items[index].enTitle:postModel.data.items[index].arTitle);
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
                                  child: buildItem(postModel.data.items[index],context))),
                          );
                      },
                    ),
                  ),


                ],
              )
      ),

    );
  }
  TextButton previewButton(Categories category,BuildContext context){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFFFFFFFF),
      minimumSize: Size(50.w, 35.h),

      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: kMainColor,
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {

      },
      child: Text(languageCode == "en"?category.enTitle:category.arTitle,style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
    );
  }
  Container selectRow(Categories category,BuildContext context,int selectedIndex){

    return
      Container(
        child:
        selectedList[selectedIndex]?
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0.h),
              color: kMainColor
          ),
          child: Text(
            languageCode == "en"?category.enTitle:category.arTitle,
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
          languageCode == "en"?category.enTitle:category.arTitle,
          style: TextStyle(
            color: Color(0xCC000000),
              fontSize: screenUtil.setSp(14),
              fontWeight: FontWeight.w500

          ),
        ),
    ),
      );
  }

  Widget buildItem(PostModel.Items data, BuildContext context) {
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
              child: Image.asset('assets/images/placeholder_error.png',  color: Color(0x80757575).withOpacity(0.5),
                colorBlendMode: BlendMode.difference,)),

        ),
    Positioned.directional(
      textDirection:  Directionality.of(context),
      bottom: 2.h,
      start: 10.w,
      child: Text(
        "17-12-2022",
        style: TextStyle(
          color: Color(0xFFFFFFFF)

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
          alignment: AlignmentDirectional.centerStart,
          child: Text(
           languageCode =="en"? data.enTitle:data.arTitle,
            style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.normal,
              fontSize: screenUtil.setSp(12)
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
