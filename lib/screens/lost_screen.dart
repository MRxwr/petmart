import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/home_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/post_model.dart' as PostModel;
import 'package:pet_mart/screens/lost_details_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class LostScreen extends StatefulWidget {
  static String id = 'LostScreen';
  @override
  _LostScreenState createState() => _LostScreenState();
}

class _LostScreenState extends State<LostScreen> {
  HomeModel? homeModel;
  List<bool> selectedList = [];
  PostModel.PostModel? postModel;
  List<PostModel.Categories> categories = [];
  ScreenUtil screenUtil = ScreenUtil();
  double? itemWidth;
  double? itemHeight;
  int selectedIndex =0;
  String  languageCode ="";
  Future<HomeModel?> getHomeModel() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? homeString = sharedPreferences.getString("home");
    languageCode = sharedPreferences.getString(LANG_CODE) ?? ENGLISH;
    HomeModel  homeModel ;


    final body = json.decode(homeString!);
    homeModel = HomeModel.fromJson(body);




    return homeModel;
  }
  Future<PostModel.PostModel?> post(String catId) async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    Map map ;
    map = {"id":catId,
      "type":"lost-animal",
      "language":languageCode};
    print(' PostModel --> ${map}');
    PetMartService petMartService = PetMartService();
    PostModel.PostModel? postModel = await petMartService.post("lost",catId);
    String categoryId = "0";
    PostModel.Categories category =PostModel. Categories(id:categoryId,arTitle:getTranslated(context, 'all'),enTitle:getTranslated(context, 'all'));
    categories.add(category);
    selectedList.add(true);

    for(int i =0;i<postModel!.data!.categories!.length;i++){
      categories.add(postModel!.data!.categories![i]);
      selectedList.add(false);
    }
    return postModel;
  }
  void getList(String catId) async{
    postModel = null;
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    Map map ;
    map = {"id":catId,
      "type":"lost-animal",
      "language":languageCode};
    print(' PostModel --> ${map}');
    PetMartService petMartService = PetMartService();
    postModel = await petMartService.post("lost",catId);
    setState(() {

    });

  }
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getHomeModel().whenComplete((){
      post("0").then((value) {
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
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,



            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),

            children: [
              Container(
                height: 35.h,
                child: categories.isEmpty?Container():ListView.separated(

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
                              getList(categories![index].id!);


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
                child:
                postModel== null?
                Container(
                  child: CircularProgressIndicator(


                  ),
                  alignment: AlignmentDirectional.center,
                ):
                postModel!.data!.items!.isEmpty?

                Container(
                  child: Text(
                    getTranslated(context, 'no_product_available')!,
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
                      childAspectRatio:itemWidth!/itemHeight!),
                  itemCount: postModel!.data!.items!.length,

                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                          return new LostDetailScreen(postId:postModel!.data!.items![index].id!,postName:languageCode =="en"? postModel!.data!.items![index].enTitle!:postModel!.data!.items![index].arTitle!);
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.all(6.w),

                          child:
                          Card(elevation: 1.w,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0.h),
                              ),
                              color: Color(0xFFFFFFFF),
                              child: buildItem(postModel!.data!.items![index],context))),
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
      child: Text(languageCode == "en"?category.enTitle!:category.arTitle!,style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
    );
  }
  Container selectRow(PostModel.Categories category,BuildContext context,int selectedIndex){

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
            languageCode == "en"?category.enTitle!:category.arTitle!,
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
            languageCode == "en"?category.enTitle!:category.arTitle!,
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
                  imageUrl:KImageUrl+data.image!,
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
                        fit: BoxFit.fill,
                        colorBlendMode: BlendMode.difference,)),

                ),
                Positioned.directional(
                  textDirection:  Directionality.of(context),
                  bottom: 2.h,
                  start: 10.w,
                  child: Text(
                    data.date!.split(" ")[0],
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
                    languageCode =="en"? data.enTitle!:data.arTitle!,
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

