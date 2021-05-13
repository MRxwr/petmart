import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/category_model.dart';
import 'package:pet_mart/model/category_model.dart';
import 'package:pet_mart/model/home_model.dart'as CategoryParent;
import 'package:pet_mart/screens/pets_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CategoriesScreen extends StatefulWidget {
  static String id = 'CategoriesScreen';
  CategoryParent.Category category;
  CategoriesScreen({Key key,@required this.category}): super(key: key);


  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  CategoryModel categoryModel;
  double itemWidth;
  double itemHeight;
  Future<CategoryModel> category() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;


    Map map ;


      map = {"id":widget.category.categoryId,

        "language":languageCode};





    PetMartService petMartService = PetMartService();
    CategoryModel auctionDetailsModel = await petMartService.category(map);
    return auctionDetailsModel;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category().then((value){
      setState(() {
        categoryModel = value;
      });
    }
    );
}
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    itemWidth = width / 2;
    itemHeight = 200.h;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10.h),
        child: categoryModel == null ?
        Container(
          child: CircularProgressIndicator(


          ),
          alignment: AlignmentDirectional.center,
        )
            :GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio:itemWidth/itemHeight),
          itemCount: categoryModel.data.category[0].childcategory.length,
          itemBuilder: (context,index){
            return GestureDetector(child: buildItem(categoryModel.data.category[0].childcategory[index],context)
            ,onTap: (){
               Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                          return new PetsScreen(childcategory: categoryModel.data.category[0].childcategory[index],
                          categoryModel : categoryModel,parentCategoryId: widget.category.categoryId,selectCategory: index+1,);
                        }));
              },);
          },
        )

      ),
    );
  }

  Container buildItem(Childcategory childcategory, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.h),
      child: Column(
        children: [
          Expanded(child: CachedNetworkImage(
            width: 150.w,
            height: 150.h,
            imageUrl:'${childcategory.categoryImage}',
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
                width: 50.w,
                height: 50.h,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  image: DecorationImage(
                      image: AssetImage('assets/images/icon.png')),
                )
            ),

          ),
          flex: 4,),
          Expanded(child: Container(
            alignment: AlignmentDirectional.center,
            child: Text(
                childcategory.categoryName,
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
