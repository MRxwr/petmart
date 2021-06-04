import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ndialog/ndialog.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/category_model.dart' as SubCategory;
import 'package:pet_mart/model/check_credit_model.dart';
import 'package:pet_mart/model/home_model.dart' as CategoryParent;
import 'package:pet_mart/model/init_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/type_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/create_auction_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'credit_screen.dart';
import 'main_sceen.dart';
class AddAdvertiseScreen extends StatefulWidget {
  static String id = 'AddAdvertiseScreen';
  @override
  _AddAdvertiseScreenState createState() => _AddAdvertiseScreenState();
}

class _AddAdvertiseScreenState extends State<AddAdvertiseScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  List<TypeModel> typesList = List();
  String mLanguage='';
  String userId ='';
  List<File> mImages = List();
  NAlertDialog nAlertDialog;
  List<String> Paths= List();
  String path =null;
  bool isSelected = false;
  String mChooseImage="اختار الصورة";
  String categoryId ="";
  String subCategoryId ="";
  InitModel initModel;
  List<Age> agesList;
  List<Gender_list> genderList;
  String genderId ="";
  String ageName="";
  String key ="sell";
  LoginModel loginModel;
  SubCategory.CategoryModel mSubCategoryModel;
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();
  final TextEditingController _ageController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();
  Future<NAlertDialog> showPickerDialog(BuildContext context)async {
    nAlertDialog =   await NAlertDialog(
      dialogStyle: DialogStyle(titleDivider: true,borderRadius: BorderRadius.circular(10)),

      content: Padding(child: Text(getTranslated(context, 'select_image')),
        padding: EdgeInsets.all(10),),
      actions: <Widget>[
        FlatButton(child: Text(getTranslated(context, 'camera')),onPressed: () {

          _getImageFromCamera(context);
        }),
        FlatButton(child: Text(getTranslated(context, 'gallery')),onPressed: () {
          _getImageFromGallery(context);
        }),

      ],
    );
    return nAlertDialog;
  }
  final picker = ImagePicker();
  String ageId ="";
  Future _getImageFromGallery(BuildContext context) async {
    var pickedFile = null;
    pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {





      isSelected = true;
      File _image = File(pickedFile.path);
      print('Path --->${_image.absolute.path}');

      mImages.add(_image) ;
    Paths.add(_image.path);
      // updateImage(context);



    } else {
      mChooseImage = 'لم يتم اختيار الصورة';
    }
    setState(() {


    });


    Navigator.pop(context);
  }
  Future _getImageFromCamera(BuildContext context) async {
    var pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {

      isSelected = true;
      File _image = File(pickedFile.path);

      mImages.add(_image) ;
      Paths.add(_image.path);
      mChooseImage="تم اختيار الصورة";


      // updateImage(context);




    } else {
      mChooseImage= 'لم يتم اختيار الصورة';
    }

    setState(() {

    });


    Navigator.pop(context);

  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
   CategoryParent.HomeModel homeModel;
  List<CategoryParent.Category> categoryList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typesList.add(TypeModel(typeNameAr: 'للبيع',typeNameEn: 'For Sale',key: 'sell',selected: true));
    typesList.add(TypeModel(typeNameAr: 'تبني',typeNameEn: 'Adaption',key: 'adoption',selected: false));
    typesList.add(TypeModel(typeNameAr: 'مفقود',typeNameEn: 'Lost',key: 'lost-animal',selected: false));
    typesList.add(TypeModel(typeNameAr: 'إنشاء مزاد',typeNameEn: 'Create Auction',key: '',selected: false));

    map().then((value) {

        userId = value["userId"];
        mLanguage = value['language'];

    }).whenComplete((){
      home().then((value) {
        setState(() {
          homeModel = value;
          categoryList = value.data.category;
        });
      });

    }
    );

  }
  Future<SubCategory.CategoryModel> subCategory(String categoryId) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;


    Map map ;


    map = {"id":categoryId,

      "language":languageCode};





    PetMartService petMartService = PetMartService();
    SubCategory.CategoryModel auctionDetailsModel = await petMartService.category(map);
    return auctionDetailsModel;
  }
  Future<CategoryParent.HomeModel> home() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String homeString = _preferences.getString('home');
    final body = json.decode(homeString);
    CategoryParent.HomeModel   homeModel =CategoryParent.HomeModel.fromJson(body);
    return homeModel;
  }
  Future<CheckCreditModel> checkCreditModel() async{



    Map map ;


    map = {"user_id":loginModel.data.customerId};





    PetMartService petMartService = PetMartService();
    CheckCreditModel creditModel = await petMartService.checkCredit(map);
    return creditModel;
  }
  Future<Map> map() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;


    String loginData = _preferences.getString(kUserModel);
    final body = json.decode(loginData);
       loginModel = LoginModel.fromJson(body);
    String initData = _preferences.getString("initModel");
    print('initData --> ${initData}');
    final initBody = json.decode(initData);
     initModel = InitModel.fromJson(initBody);
    agesList = initModel.data.age;
    ageId = agesList[0].id;
    ageName = agesList[0].name;
    genderList = initModel.data.genderList;
    Map map ;
    map = {"language":languageCode,
      "userId":loginModel.data.customerId};
    return map;
  }
  @override
  Widget build(BuildContext context) {
    return
      ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoading,
        child: Scaffold(
          key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: kMainColor,
          title: Container(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.h),
              child: Text(
                getTranslated(context, 'create_post'),
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
          child: homeModel == null?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          )
          :
          Container(
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,



              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),

              children: [
                Text(getTranslated(context, 'select_post_type'),
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: screenUtil.setSp(16),
                      fontWeight: FontWeight.bold
                  ),),
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
                                key = typesList[index].key;
                                for(int i =0;i<typesList.length;i++){
                                  if(i == index){
                                    typesList[i].selected= true;
                                  }else{
                                    typesList[i].selected= false;
                                  }

                                }
setState(() {

});
                                if(key ==''){
                                  final modelHud = Provider.of<ModelHud>(context,listen: false);
                                  modelHud.changeIsLoading(true);
                                  checkCreditModel().then((value){
                                    modelHud.changeIsLoading(false);
                                  int credit = int.parse(value.data.credit);
                                  print('credit --->${credit}');

                                  if(credit>0){
                                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
                                      return new CreateAuctionScreen();
                                    }));
                                  }else{
                                    ShowAlertDialog(context, value.message);
                                  }
                                  });

                                }


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
                SizedBox(height: 5.h,width: screenUtil.screenWidth,
                ),
                Text(getTranslated(context,'add_photo'),
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: screenUtil.setSp(16),
                      fontWeight: FontWeight.bold
                  ),),
                Container(
                  height: 100.h,
                  width: screenUtil.screenWidth,

                  child:
                  ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,


                    children: [
                      GestureDetector(
                        onTap: (){
                          showPickerDialog(context).then((value){
                            value.show(context);
                          });
                        },
                        child:
                        Container(
                          width: 100.h,
                          height: 100.h,
                          padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0.h),
                              color: Color(0xFFFFFFFF),
                              border: Border.all(
                                  color: Color(0xCC000000),
                                  width: 1.0.w
                              )
                          ),
                          child: Icon(Icons.add,color: kMainColor,size: 50.h,),
                        ),
                      ),
                      SizedBox(width: 10.w,
                      height: 100.h,),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                        return pickedImga(mImages[index],index);
                      }, separatorBuilder: (context,index) {
                        return Container(width: 10.h,
                          color: Color(0xFFFFFFFF),);
                      }
                          , itemCount: mImages.length)

                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                  width: screenUtil.screenWidth,
                  child: DropDown<CategoryParent.Category>(





                    items: categoryList,

                    hint:  Text(getTranslated(context, 'select_category') ,
                      textAlign: TextAlign.start,
                      style: TextStyle(

                          color: Color(0xFFc3c3c3),
                          fontWeight: FontWeight.w600,
                          fontSize: screenUtil.setSp(15)
                      ),),
                    onChanged: (CategoryParent.Category category){
                      mSubCategoryModel = null;
                      categoryId = category.categoryId;
                      print('CategoryId -->${categoryId}');
                      final modelHud = Provider.of<ModelHud>(context,listen: false);
                      modelHud.changeIsLoading(true);
                      subCategory(categoryId).then((value){
                        modelHud.changeIsLoading(false);
                        setState(() {
                          subCategoryId = value.data.category[0].childcategory[0].categoryId;
                          mSubCategoryModel = value;
                          print('subCategoryId -->${subCategoryId}');
                        });
                      });


                    },
                    customWidgets: categoryList.map((p) => buildDropDownRow(p)).toList(),
                    isExpanded: true,
                    showUnderline: false,
                  ),
                ),
                SizedBox(height: 1.h,
                width: screenUtil.screenWidth,
                child: Container(
                  color: Color(0xFFc3c3c3),
                ),),
                SizedBox(height: 10.h,),
                SizedBox(
                  height: 50.h,
                  width: screenUtil.screenWidth,
                  child: mSubCategoryModel == null?
                  Container(
                    alignment: AlignmentDirectional.centerStart,

                    child: Text(getTranslated(context,'select_sub_category'),
                      textAlign: TextAlign.start,
                      style: TextStyle(

                          color: Color(0xFFc3c3c3),
                          fontWeight: FontWeight.w600,
                          fontSize: screenUtil.setSp(15)
                      ),),
                  ):  SizedBox(
                    height: 50.h,
                    width: screenUtil.screenWidth,
                    child:
                    DropDown<SubCategory.Childcategory>(





                      items: mSubCategoryModel.data.category[0].childcategory,

                      hint:  Text(mSubCategoryModel.data.category[0].childcategory[0].categoryName ,
                        textAlign: TextAlign.start,
                        style: TextStyle(

                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w600,
                            fontSize: screenUtil.setSp(15)
                        ),),
                      onChanged: (SubCategory.Childcategory category){
                        subCategoryId = category.categoryId;



                      },
                      customWidgets: mSubCategoryModel.data.category[0].childcategory.map((p) => buildSubCategoryRow(p)).toList(),
                      isExpanded: true,
                      showUnderline: false,
                    ),
                  ),
                ),
                SizedBox(height: 1.h,
                  width: screenUtil.screenWidth,
                  child: Container(
                    color: Color(0xFFc3c3c3),
                  ),),
                SizedBox(height: 10.h,),
                TextField(

                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: 1,
                  enableInteractiveSelection: true,
                  controller: _titleController,

                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,



                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(hintText: getTranslated(context, 'post_title'),
                      isCollapsed: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.h),
                      hintStyle: TextStyle(
                      color: Color(0xFFa3a3a3),

                  )
                  ),
                ),
                SizedBox(height: 1.h,
                  width: screenUtil.screenWidth,
                  child: Container(
                    color: Color(0xFFc3c3c3),
                  ),),  SizedBox(height: 10.h,),
                TextField(

                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 50,
                  enableInteractiveSelection: true,
                  controller: _descriptionController,

                  textInputAction: TextInputAction.newline,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,


                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(hintText: getTranslated(context, 'post_description'),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(10.h),
                      hintStyle: TextStyle(
                        color: Color(0xFFa3a3a3),

                      )
                  ),
                ),
                SizedBox(height: 1.h,
                  width: screenUtil.screenWidth,
                  child: Container(
                    color: Color(0xFFc3c3c3),
                  ),),  SizedBox(height: 10.h,),
                Container(
                  height: 50.h,
                  width: screenUtil.screenWidth,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex:1,
                        child: TextField(

                          keyboardType: TextInputType.number,
                          minLines: 1,
                          maxLines: 1,
                          enableInteractiveSelection: true,
                          controller: _ageController,

                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,



                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(hintText: getTranslated(context, 'age_string'),
                              isCollapsed: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.all(10.h),
                              hintStyle: TextStyle(
                                color: Color(0xFFa3a3a3),

                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      Expanded(
                        flex: 1,
                        child: DropDown<Age>(





                          items: agesList,

                          hint:  Text(agesList[0].name,
                            textAlign: TextAlign.start,
                            style: TextStyle(

                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w600,
                                fontSize: screenUtil.setSp(15)
                            ),),
                          onChanged: (Age age){
                            ageId = age.id;
                            ageName = age.name;



                          },
                          customWidgets: agesList.map((p) => buildAgeRow(p)).toList(),
                          isExpanded: true,
                          showUnderline: false,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 1.h,
                  child: Row(
                    children: [
                      Expanded(flex: 1,
                          child: Container(
                        color: Color(0xFFc3c3c3),
                      )),
                      SizedBox(width: 5.w,),
                      Expanded(flex: 1,
                          child: Container(
                            color: Color(0xFFc3c3c3),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                SizedBox(
                  height: 50.h,
                  width: screenUtil.screenWidth,
                  child: DropDown<Gender_list>(





                    items: genderList,

                    hint:  Text(getTranslated(context, 'select_gender') ,
                      textAlign: TextAlign.start,
                      style: TextStyle(

                          color: Color(0xFFc3c3c3),
                          fontWeight: FontWeight.w600,
                          fontSize: screenUtil.setSp(15)
                      ),),
                    onChanged: (Gender_list gender){
                      genderId = gender.id;



                    },
                    customWidgets: genderList.map((p) => builGenderRow(p)).toList(),
                    isExpanded: true,
                    showUnderline: false,
                  ),
                ),
                Container(
                  height: 1.h,
                  child:

                  Container(
                    color: Color(0xFFc3c3c3),
                  )
                ),
                SizedBox(height: 10.h,),
                TextField(

                  keyboardType: TextInputType.number,
                  minLines: 1,
                  maxLines: 1,
                  enableInteractiveSelection: true,
                  controller: _priceController,

                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,



                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(hintText: getTranslated(context, 'post_price'),
                      isCollapsed: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.h),
                      hintStyle: TextStyle(
                        color: Color(0xFFa3a3a3),

                      )
                  ),
                ),
                Container(
                    height: 1.h,
                    child:

                    Container(
                      color: Color(0xFFc3c3c3),
                    )
                ),
                SizedBox(height: 10.h,),
                sumbitButton(getTranslated(context, 'sumbit_post'),context)


              ],
            ),
          ),
        ),
    ),
      );
  }
  TextButton sumbitButton(String text,BuildContext context){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFF000000),
      minimumSize: Size(100.w, 50.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: kMainColor,
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {
       validate(context);
      },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(16),
          fontWeight: FontWeight.bold
      ),),
    );
  }
  Widget builGenderRow(Gender_list gender) {
    return Container(






        alignment: AlignmentDirectional.centerStart,

        child: Text(gender.name ,
          style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w600,
              fontSize: screenUtil.setSp(15)
          ),));
  }
  Widget buildSubCategoryRow(SubCategory.Childcategory category) {
    return Container(






        alignment: AlignmentDirectional.centerStart,

        child: Text(category.categoryName ,
          style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w600,
              fontSize: screenUtil.setSp(15)
          ),));
  }
  Widget buildAgeRow(Age age) {
    return Container(






        alignment: AlignmentDirectional.centerStart,

        child: Text(age.name ,
          style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w600,
              fontSize: screenUtil.setSp(15)
          ),));
  }
  Widget buildDropDownRow(CategoryParent.Category category) {
  return Container(






      alignment: AlignmentDirectional.centerStart,

      child: Text(category.categoryName ,
        style: TextStyle(
            color: Color(0xFF000000),
            fontWeight: FontWeight.w600,
            fontSize: screenUtil.setSp(15)
        ),));
  }
  Container pickedImga(File image,int position){
    return Container(
      width: 100.h,
      height: 100.h,
      padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0.h),
          color: Color(0xFFFFFFFF),
          border: Border.all(
              color: Color(0xCC000000),
              width: 1.0.w
          ),
        image: DecorationImage(
            image: FileImage(File(image.path)),
            fit: BoxFit.fill),
      ),
      child: Container(
        alignment: AlignmentDirectional.topStart,
        child: GestureDetector(
          onTap: (){
            mImages.removeAt(position);
            setState(() {

            });

          },
            child: Icon(Icons.delete,color: Colors.red,size: 20.h,)),

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

  void validate(BuildContext context) async {
    String postTitle = _titleController.text;
    String postDescription =_descriptionController.text;
    String age = _ageController.text;
    String price = _priceController.text;
    if(mImages.isEmpty){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'image_error'))));

    }else if(subCategoryId==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'category_error'))));

    }else if(categoryId==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'sub_category_error'))));

    }
    else if(postTitle==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'title_error'))));

    }else if(postDescription==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'description_error'))));

    }else if(age==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'age_error'))));

    }else if(price==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'price_error'))));

    }else if(genderId==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'gender_error'))));

    }else{
      String userId = loginModel.data.customerId;
      String phoneNumber = loginModel.data.mobile;
      final modelHud = Provider.of<ModelHud>(context,listen: false);
      modelHud.changeIsLoading(true);
      PetMartService petMartService = PetMartService();
      dynamic response = await petMartService.addPost(postTitle, postTitle, key, postDescription, postDescription, price, categoryId, age, ageId, genderId, userId, subCategoryId, phoneNumber, mLanguage,mImages, null);
      modelHud.changeIsLoading(false);
      String status = response['status'];
      if(status == 'success'){
        ShowPostAlertDialog(context,response['message'],true);

      }else{
        ShowPostAlertDialog(context,response['message'],false);

      }
    }

  }
  Future<void> ShowAlertDialog(BuildContext context ,String title) async{
    var alert;
    var alertStyle = AlertStyle(

      animationType: AnimationType.fromBottom,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.normal,
          color: Color(0xFF0000000),
          fontSize: screenUtil.setSp(18)),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.normal,
          fontSize: screenUtil.setSp(16)
      ),
      alertAlignment: AlignmentDirectional.center,
    );
    alert =   Alert(
      context: context,
      style: alertStyle,

      title: title,


      buttons: [

        DialogButton(
          child: Text(
            getTranslated(context, 'ok_string'),
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();
            Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
              return new CreditScreen();

            }));

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        ),DialogButton(
          child: Text(
            getTranslated(context, 'no'),
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            await alert.dismiss();

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        )
      ],
    );
    alert.show();

  }
  Future<void> ShowPostAlertDialog(BuildContext context ,String title,bool success) async{
    var alert;
    var alertStyle = AlertStyle(

      animationType: AnimationType.fromBottom,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.normal,
          color: Color(0xFF0000000),
          fontSize: screenUtil.setSp(18)),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.normal,
          fontSize: screenUtil.setSp(16)
      ),
      alertAlignment: AlignmentDirectional.center,
    );
    alert =   Alert(
      context: context,
      style: alertStyle,

      title: title,


      buttons: [

        DialogButton(
          child: Text(
            getTranslated(context, 'ok_string'),
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: screenUtil.setSp(18)),
          ),
          onPressed: ()async {
            if(success){
              await alert.dismiss();
              Navigator.pushReplacementNamed(context,MainScreen.id);
            }else{
              await alert.dismiss();
            }

          },
          color: Color(0xFFFFC300),
          radius: BorderRadius.circular(6.w),
        )
      ],
    );
    alert.show();

  }

}
