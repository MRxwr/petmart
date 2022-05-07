
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/home_model.dart';
import 'package:pet_mart/model/search_model.dart';
import 'package:pet_mart/model/type_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/search_result_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_mart/model/category_model.dart'as SubCategory;
import '../model/login_model.dart';
class SearcgScreen extends StatefulWidget {
  const SearcgScreen({Key key}) : super(key: key);

  @override
  _SearcgScreenState createState() => _SearcgScreenState();
}

class _SearcgScreenState extends State<SearcgScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  String mLanguage="";
  int _stackIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String subCategoryId ="";
  SubCategory.CategoryModel subCategory = null;

  String _singleValue = "Text alignment right";
  String _verticalGroupValue = "Pending";

  List<String> _statusEn = ["For Sale", "Adaption", "Lost"];
  List<String> _statusAr = ["للبيع", "تبني", "مفقود"];
  List<String> _statusKey =["sell","adoption","animal"];
  List<bool> selectedList = List();
  List<bool> selectedSubList = List();
  final TextEditingController _commentController = new TextEditingController();
  final TextEditingController _startPriceController = new TextEditingController();
  final TextEditingController _endPriceController = new TextEditingController();
  List<TypeModel> typesList = List();
  double itemWidth;
  double itemHeight;
  int _groupValue = -1;
  List<String> selectedSubCategoriesId = List();
  List<Categories> _categoryList = List();
  String  categoryId ="";
  bool forSaleSelected = true;
  String type="sell";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typesList.add(TypeModel(typeNameAr: 'للبيع',typeNameEn: 'For Sale',key: 'sell',selected:  true));
    typesList.add(TypeModel(typeNameAr: 'تبني',typeNameEn: 'Adaption',key: 'adoption',selected: false));
    typesList.add(TypeModel(typeNameAr: 'مفقود',typeNameEn: 'Lost',key: 'lost-animal',selected: false));
    getLanguage().then((value) {
      _categoryList.clear();

        mLanguage = value;

    }).whenComplete(() {
      getHome().then((value){
        setState(() {
          _categoryList = value.data.categories;
          for(int i =0;i<_categoryList.length;i++){

            selectedList.add(false);
          }
          print('_categoryList${_categoryList.length}');
        });


      });
    });

  }
  Future<void> category() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;


    Map map ;


    map = {"id":categoryId,

      "language":languageCode};





    PetMartService petMartService = PetMartService();
    subCategory = await petMartService.category(categoryId);
    print('subCategory --> ${subCategory}');
    selectedSubList.clear();
    for(int i =0;i<subCategory.data.categories.length;i++){

      selectedSubList.add(false);
    }
    selectedSubCategoriesId.clear();
    setState(() {

    });

  }
  Future<HomeModel> getHome() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String loginData = sharedPreferences.getString(kUserModel);
    print('loginData ---> ${loginData}');
    Map map ;
    if(loginData != null){
      final body = json.decode(loginData);
      LoginModel   loginModel = LoginModel.fromJson(body);
      map = {'id': loginModel.data.id,
        "language":languageCode
      };
    }else{
      map = {'id': "",
        "language":languageCode
      };
    }

    print('map --> ${map}');

    PetMartService petMartService = PetMartService();
    HomeModel home = await petMartService.home(map);
    return home;
  }
  Future<String> getLanguage() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;


    return languageCode;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    itemWidth = width / 3;
    itemHeight = 60.h;
    return
      ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
          key: _scaffoldKey,
        appBar:
        AppBar(
          backgroundColor: kMainColor,
          title: Container(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.h),
              child: Text(
                getTranslated(context, 'advanced_search'),
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
            child: Icon(Icons.close,color: Colors.white,size: 20.h,),
          ),

          actions: [
            InkWell(
              onTap: (){
                String searchText=  _commentController.text;
                String mSelectCategory = categoryId;
                String mSubCatId = "";
                String mStartPrice = _startPriceController.text;
                String mEndPrice = _endPriceController.text;


                if(selectedSubList.isNotEmpty){
                  for(int i =0;i<selectedSubList.length;i++){
                    bool isSelect =selectedSubList[i];
                    if(isSelect){
                      mSubCatId = mSubCatId+subCategory.data.categories[i].id+",";
                    }

                  }
                  if (mSubCatId != null && mSubCatId.length > 0) {
                    mSubCatId = mSubCatId.substring(0, mSubCatId.length - 1);
                  }


                }
                search(searchText,mSelectCategory,mSubCatId,mStartPrice,mEndPrice,type);


              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(getTranslated(context, 'search'),
                    style: TextStyle(color:Color(0xFFFFFFFF),
                        fontSize: screenUtil.setSp(12),
                        fontWeight: FontWeight.normal),),
                ),
              ),
            )
          ],

        ),
        backgroundColor: Color(0xFFFFFFFF),
        body: Container(
          child:_categoryList.isEmpty?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          ): ListView(
            children: [
              _bulidSearchComposer(),
              Container(
                width: width,
                color: Color(0xFFdcdcdc),
                child:
                Padding(
                  padding:  EdgeInsets.all(5.h),
                  child: Text(
                    getTranslated(context, 'select_post_type'),
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.normal,
                      fontSize: screenUtil.setSp(12)
                    ),
                  ),
                ),
              ),
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
                            type = typesList[index].key;
                            selectedSubList.clear();
                            subCategory = null;

                            bool selectedIndex = typesList[index].selected;
                            print('selectedIndex ${selectedIndex}');

                            if(!selectedIndex){
                              if(index == 0){
                                forSaleSelected = true;
                              }else{
                                forSaleSelected = false;
                              }
                              for(int i =0;i<typesList.length;i++){
                                if(i == index){
                                  typesList[i].selected= true;
                                }else{
                                  typesList[i].selected= false;
                                }

                              }
                              selectedList.clear();
                              for(int i =0;i<_categoryList.length;i++){

                                selectedList.add(false);
                              }
                              setState(() {

                              });




                            }

                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: _buildAdType(typesList[index],context,index)),
                        );
                    }
                    ,
                    separatorBuilder: (context,index) {
                      return Container(height: 10.h,
                        color: Color(0xFFFFFFFF),);
                    }
                    ,itemCount: typesList.length),
              ),
              Container(
                width: width,
                color: Color(0xFFdcdcdc),
                child:
                Padding(
                  padding:  EdgeInsets.all(5.h),
                  child: Text(
                   getTranslated(context, 'select_category'),
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.normal,
                        fontSize: screenUtil.setSp(12)
                    ),
                  ),
                ),
              ),
              GridView.builder(scrollDirection: Axis.vertical,


                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                    childAspectRatio:itemWidth/itemHeight),
                itemCount: _categoryList.length,

                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      selectedSubList.clear();
                      bool selectedIndex = selectedList[index];
                      if(!selectedIndex){
                        for(int i =0;i<selectedList.length;i++){
                          if(i == index){
                            selectedList[i]= true;
                            categoryId = _categoryList[i].id;
                          }else{
                            selectedList[i]= false;
                          }
                        }
                        print(selectedList);

                        setState(() {


                        });
                        subCategory = null;
category();


                      }
                      // Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                      //   return new AuctionDetailsScreen(mAuctionModel:auctionModel.data[index]);
                      // }));
                    },
                    child: Container(
                        margin: EdgeInsets.all(6.w),

                        child:_buildCategory(_categoryList[index],context,index)
                        ),
                  );
                },
              ),
              Container(
                child: subCategory == null?
                Container():
                Column(
                  children: [
                    Container(
                      width: width,
                      color: Color(0xFFdcdcdc),
                      child:
                      Padding(
                        padding:  EdgeInsets.all(5.h),
                        child: Text(
                          getTranslated(context, 'select_sub_category'),
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.normal,
                              fontSize: screenUtil.setSp(12)
                          ),
                        ),
                      ),
                    ),
                    GridView.builder(scrollDirection: Axis.vertical,


                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                          childAspectRatio:itemWidth/itemHeight),
                      itemCount: subCategory.data.categories.length,

                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            bool selectedIndex = selectedSubList[index];
                            selectedSubList[index]=!selectedIndex;
                            setState(() {

                            });
                            print(selectedSubList);

                            // if(!selectedIndex){
                            //   for(int i =0;i<selectedSubList.length;i++){
                            //     if(i == index){
                            //       selectedSubList[i]= true;
                            //       subCategoryId =  subCategory.data.category[0].childcategory[i].categoryId;
                            //     }else{
                            //       selectedSubList[i]= false;
                            //     }
                            //   }
                            //   print(selectedSubList);
                            //
                            //   setState(() {
                            //
                            //   });
                            //
                            //
                            //
                            // }
                            // Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                            //   return new AuctionDetailsScreen(mAuctionModel:auctionModel.data[index]);
                            // }));
                          },
                          child: Container(
                              margin: EdgeInsets.all(6.w),

                              child:_buildSubCategory(subCategory.data.categories[index],context,index)
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                child: !forSaleSelected?
                Container():
                Column(
                  children: [
                    Container(
                      width: width,
                      color: Color(0xFFdcdcdc),
                      child:
                      Padding(
                        padding:  EdgeInsets.all(5.h),
                        child: Text(
                          getTranslated(context, 'basic'),
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.normal,
                              fontSize: screenUtil.setSp(12)
                          ),
                        ),
                      ),
                    ),Container(
                      width: width,

                      child:
                      Padding(
                        padding:  EdgeInsets.all(5.h),
                        child: Text(
                          getTranslated(context, 'price'),
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.normal,
                              fontSize: screenUtil.setSp(12)
                          ),
                        ),
                      ),

                    ),

                    Row(
                      children: [
                        Expanded(flex:1,child: _bulidStartPrice()),
                        Expanded(flex:1,child: _bulidEndPrice()),

                      ],
                    )

                  ],
                ),

              )

            ],
          ),
        ),
    ),
      );
  }
  _bulidSearchComposer(){
    return
      Column(

        children: [

          Container(
            child:
            Container(
              margin: EdgeInsets.all(10.h),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              height: 60.0,

              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(6.h),
                  color: Color(0xFFdcdcdc)
              ),
              child:

              Row(
                children: <Widget>[

                  Expanded(
                    child: TextField(

                      keyboardType: TextInputType.text,
                      minLines: 1,
                      maxLines: 1,
                      enableInteractiveSelection: true,
                      controller: _commentController,

                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,


                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration.collapsed(hintText: getTranslated(context, 'type_text_here'),hintStyle: TextStyle(
                        color: Color(0xFFa3a3a3)
                      )
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
          SizedBox(height: 10.h,)
        ],
      );
  }
  _bulidStartPrice (){
    return
      Column(

        children: [

          Container(
            child:
            Container(
              margin: EdgeInsets.all(10.h),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              height: 60.0,

              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF000000),
                  ),
                  borderRadius: BorderRadius.circular(6.h),
                  color: Color(0xFFFFFFFF)
              ),
              child: Row(
                children: <Widget>[

                  Expanded(
                    child:
                    TextField(

                      keyboardType: TextInputType.number,
                      minLines: 1,
                      maxLines: 1,
                      enableInteractiveSelection: true,
                      controller: _startPriceController,

                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,


                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration.collapsed(hintText: '0.000 ${getTranslated(context, 'kwd')}',hintStyle: TextStyle(
                          color: Color(0xFFa3a3a3)
                      )
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
          SizedBox(height: 10.h,)
        ],
      );
  }
  _bulidEndPrice (){
    return
      Column(

        children: [

          Container(
            child:
            Container(
              margin: EdgeInsets.all(10.h),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              height: 60.0,

              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF000000),
                  ),
                  borderRadius: BorderRadius.circular(6.h),
                  color: Color(0xFFFFFFFF)
              ),
              child: Row(
                children: <Widget>[

                  Expanded(
                    child: TextField(

                      keyboardType: TextInputType.number,
                      minLines: 1,
                      maxLines: 1,
                      enableInteractiveSelection: true,
                      controller: _endPriceController,

                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,


                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration.collapsed(hintText: '1000.000 ${getTranslated(context, 'kwd')}',hintStyle: TextStyle(
                          color: Color(0xFFa3a3a3)
                      )
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
          SizedBox(height: 10.h,)
        ],
      );
  }
  _buildAdType(TypeModel typeModel,BuildContext context,int index,){
    return  Container(

      child: Row(
        children: [
          Container(
            child: typeModel.selected ?
            Icon(Icons.radio_button_checked_outlined,color: kMainColor,size: 20.h,):
            Icon(Icons.radio_button_off,color: Color(0xFF000000),size: 20.h,)

          ),

      Text(mLanguage =="ar"?typeModel.typeNameAr:typeModel.typeNameEn,
        style: TextStyle(color:Color(0xFF000000),
            fontSize: screenUtil.setSp(12),
            fontWeight: FontWeight.normal),),

        ],
      ),
    );
  }
  _buildCategory(Categories typeModel,BuildContext context,int index,){
    return  Container(

      child: Row(
        children: [
          Container(
              child: selectedList[index]? Icon(Icons.radio_button_checked_outlined,color: kMainColor,size: 20.h,)
                  :
              Icon(Icons.radio_button_off,color: Color(0xFF000000),size: 20.h,)
          ),

          Expanded(
            flex: 1,
            child: Text(mLanguage == "en"?typeModel.enTitle:typeModel.arTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(color:Color(0xFF000000),
                  fontSize: screenUtil.setSp(12),

                  fontWeight: FontWeight.normal),),
          ),

        ],
      ),
    );
  }
  _buildSubCategory(SubCategory.Categories typeModel,BuildContext context,int index,){
    return  Container(

      child: Row(
        children: [
          Container(
              child: selectedSubList[index]? Icon(Icons.radio_button_checked_outlined,color: kMainColor,size: 20.h,)
                  :
              Icon(Icons.radio_button_off,color: Color(0xFF000000),size: 20.h,)
          ),

          Expanded(
            flex: 1,
            child: Text(mLanguage == "en"?typeModel.enTitle:typeModel.arTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(color:Color(0xFF000000),
                  fontSize: screenUtil.setSp(12),

                  fontWeight: FontWeight.normal),),
          ),

        ],
      ),
    );
  }

  void search(String searchText, String mSelectCategory, String mSubCatId, String mStartPrice, String mEndPrice,String type) async{

    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeIsLoading(true);
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    PetMartService petMartService = PetMartService();
    Map map = {
      'id': mSelectCategory.toString(),
      'sub_category_id': mSubCatId,
      'language': languageCode,
      'min_price': mStartPrice,
      'max_price': mEndPrice,
      'search_keyword': searchText,
      'type':type
    };
    print(map);
    SearchModel searchModel = await petMartService.search(map);
    modelHud.changeIsLoading(false);
String status = searchModel.status;
if(status == "success"){
  Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
    return new SearchResultScreen(searchModel:searchModel);
  }));

}else{
  _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(searchModel.message)));
}

  }
}
