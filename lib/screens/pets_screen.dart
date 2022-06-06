import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/category_model.dart';

import 'package:pet_mart/model/pets_model.dart' as Model;
import 'package:pet_mart/screens/pets_details_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PetsScreen extends StatefulWidget {
  static String id = 'PetsScreen';
  Categories childcategory;
  String parentCategoryId;

  CategoryModel categoryModel;
  int selectCategory;
  String categryName;

   PetsScreen({Key key,@required this.childcategory,@required this.categoryModel,@required this.parentCategoryId,@required this.selectCategory,@required this.categryName}) : super(key: key);

  @override
  _PetsScreenState createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  List<Categories> categoryList= List();
  List<bool> selectedList = List();
  ScreenUtil screenUtil = ScreenUtil();
  Model.PetsModel petsModel;
  String catId ="";
  double itemWidth;
  double itemHeight;
  String mLanguage ="";
  Future<Model.PetsModel> pets() async{

    for(int i =0;i<categoryList.length;i++){
      if(i == widget.selectCategory){

        catId =categoryList[i].id;
      }
    }
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    Map map = {
      'id':widget.parentCategoryId,
      'sub_category_id':catId,
      'type':'sell',
      'language':languageCode



    };
    print('map --> ${map}');

    PetMartService petMartService = PetMartService();
    Model.PetsModel petsModel = await petMartService.pets(catId,widget.parentCategoryId);
    return petsModel;
  }
  Future<void> petsList() async{
    petsModel = null;
    for(int i =0;i<selectedList.length;i++){
      if(selectedList[i]){
        catId = categoryList[i].id;


      }
    }
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    Map map = {
      'id':widget.parentCategoryId,
      'sub_category_id':catId,
      'type':'sell',
      'language':languageCode



    };
    print('map --> ${map}');

    PetMartService petMartService = PetMartService();
    petsModel = await petMartService.pets(catId,widget.parentCategoryId);
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String catId ="0";
    Categories cat = Categories(id:catId,arTitle:"الكل",enTitle:"ALL",image:"");

    categoryList.add(cat);
    for(int i =0;i<widget.categoryModel.data.categories.length;i++){
      categoryList.add(widget.categoryModel.data.categories[i]);


    }

    for(int i =0;i<categoryList.length;i++){
      if(i == widget.selectCategory){
        selectedList.add(true);
         catId =categoryList[i].id;
      }else{
        selectedList.add(false);
      }
    }
    setState(() {

    });

    pets().then((value){
      setState(() {
        petsModel = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    itemWidth = width / 2;
    itemHeight = 200.h;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.h),
            child: mLanguage != ""?Text(
              widget.categryName,
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: screenUtil.setSp(16),
                  fontWeight: FontWeight.bold

              ),


            ):Text(
              "",
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
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10.h),
            height: 35.h,
            child: mLanguage == ""?
            Container():ListView.separated(

                scrollDirection: Axis.horizontal,

                itemBuilder: (context,index){
                  return
                    GestureDetector(
                      onTap: (){
                        bool selectedIndex = selectedList[index];
                        if(!selectedIndex){
                          petsModel = null;

                          for(int i =0;i<selectedList.length;i++){
                            if(i == index){
                              catId = categoryList[i].id;
                              selectedList[i]= true;

                            }else{
                              selectedList[i]= false;
                            }
                          }

                          setState(() {

                          });
                          petsList();

                        }

                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: selectRow(categoryList[index],context,index)),
                    );
                }
                ,
                separatorBuilder: (context,index) {
                  return Container(height: 10.h,
                    color: Color(0xFFFFFFFF),);
                }
                ,itemCount: categoryList.length),

          ),
          SizedBox(height: 5.h,width: width,
          ),
          Container(
            child:
            petsModel== null?
    Container(
    child: CircularProgressIndicator(


    ),
    alignment: AlignmentDirectional.center,
    ):
    petsModel.data.items.isEmpty?

    Container(
    child: Text(
   getTranslated(context, "no_products"),
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
              itemCount: petsModel.data.items.length,

              itemBuilder: (context,index){
              print(index);
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                      return new PetsDetailsScreen(postId:petsModel.data.items[index].id,postName: mLanguage == "en"?petsModel.data.items[index].enTitle:
                      petsModel.data.items[index].arTitle);
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
                          child: buildItem(petsModel.data.items[index],context))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget buildItem(Model.Items data, BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: itemWidth,
                  imageUrl:KImageUrl+data.image,
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
                      child: Image.asset('assets/images/placeholder_error.png',  fit: BoxFit.fill,color: Color(0x80757575).withOpacity(0.5),
                        colorBlendMode: BlendMode.difference,)),

                ),
                Positioned.directional(
                  textDirection:  Directionality.of(context),
                  bottom: 2.h,
                  start: 4.w,
                  child:
                  Text(
                    data.date,
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
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    mLanguage == "en"?
                    data.enTitle:data.arTitle,
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                        fontSize: screenUtil.setSp(12)
                    ),

                  ),
                )),
                Expanded(flex:1,child:
                Row(
                  children: [

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        '${data.price}',
                        style: TextStyle(
                            color: kMainColor,
                            fontWeight: FontWeight.normal,
                            fontSize: screenUtil.setSp(14)
                        ),

                      ),
                    ),
                  ],
                ))
              ],
            ),
          ))

        ],
      ),
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
            mLanguage == "en"?
            category.enTitle:category.arTitle,
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
            mLanguage == "en"?
            category.enTitle:category.arTitle,
            style: TextStyle(
                color: Color(0xCC000000),
                fontSize: screenUtil.setSp(14),
                fontWeight: FontWeight.w500

            ),
          ),
        ),
      );
  }
}
