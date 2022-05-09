import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart' as path_provider;


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ndialog/ndialog.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/age_model.dart';

import 'package:pet_mart/model/check_credit_model.dart';
import 'package:pet_mart/model/gender_model.dart';



import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/type_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/create_auction_screen.dart';
import 'package:pet_mart/screens/splash_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/utilities/shared_prefs.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/InitModel.dart';
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

  List<AgeModel> agesList = [];
  List<GenderModel> genderList = [];
  List<Category> categories = null;
  List<Sub> subCategory = null;
  String genderId ="";
  String ageName="";
  String key ="sell";
  LoginModel loginModel;
  bool hidePrice = false;

  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();
  final TextEditingController _titleArController = new TextEditingController();
  final TextEditingController _descriptionArController = new TextEditingController();
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

  InitModel initModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typesList.add(TypeModel(typeNameAr: 'للبيع',typeNameEn: 'For Sale',key: 'sell',selected: true));
    typesList.add(TypeModel(typeNameAr: 'تبني',typeNameEn: 'Adaption',key: 'adoption',selected: false));
    typesList.add(TypeModel(typeNameAr: 'مفقود',typeNameEn: 'Lost',key: 'lost-animal',selected: false));
    // typesList.add(TypeModel(typeNameAr: 'إنشاء مزاد',typeNameEn: 'Create Auction',key: '',selected: false));
    genderList.add(GenderModel("0", "زوج", "couple"));
    genderList.add(GenderModel("1", "ذكر", "Male"));
    genderList.add(GenderModel("2", "أنثى", "Female"));
    genderList.add(GenderModel("3", "غير معروف", "Not Applicable"));
    agesList.add(AgeModel("0", "يوم", "day"));
    agesList.add(AgeModel("1", "أسبوع", "week"));
    agesList.add(AgeModel("2", "شهر", "month"));
    agesList.add(AgeModel("3", "عام", "year"));
    map().then((value) {
      setState(() {
        initModel = value;
        categories = initModel.data.category;
        subCategory = initModel.data.category[0].sub;
        categoryId = initModel.data.category[0].sub[0].id;

      });



    });

  }


  Future<CheckCreditModel> checkCreditModel() async{



    Map map ;


    map = {"user_id":loginModel.data.id};





    PetMartService petMartService = PetMartService();
    CheckCreditModel creditModel = await petMartService.checkCredit(map);
    return creditModel;
  }
  Future<InitModel> map() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;

    PetMartService petMartService = PetMartService();
    InitModel initModel =  await petMartService.initModel();


    String loginData = _preferences.getString(kUserModel);
    final body = json.decode(loginData);
       loginModel = LoginModel.fromJson(body);
    String initData = _preferences.getString("initModel");
    print('initData --> ${initData}');
    userId = loginModel.data.id;

    // agesList = initModel.data.age;
    ageId = agesList[0].id;
    ageName =mLanguage == "en" ?agesList[0].ageEn:agesList[0].ageAr;
    // genderList = initModel.data.genderList;
    Map map ;
    map = {"language":languageCode,
      "userId":loginModel.data.id};
    return initModel;
  }
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();

        },
        child: ModalProgressHUD(
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
              SizedBox(width: 30.h,)

            ],

          ),
          backgroundColor: Color(0xFFFFFFFF),
          body: Container(
            margin: EdgeInsets.all(10.h),
            child: initModel == null?
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

                                  }else if(key == 'adoption'){

hidePrice = true;
categories = null;
subCategory = null;
setState(() {

});
categories = initModel.data.adoption;
print(categories);
subCategory = initModel.data.adoption[0].sub;
categoryId = initModel.data.adoption[0].sub[0].id;
print(subCategory);
setState(() {

});

                                  }else if(key == 'lost-animal'){
                                    hidePrice = true;
                                    categories = null;
                                    subCategory = null;
                                    setState(() {

                                    });
                                    categories = initModel.data.lost;
                                    subCategory = initModel.data.lost[0].sub;
                                    categoryId = initModel.data.lost[0].sub[0].id;
                                    setState(() {

                                    });
                                  }if(key == 'sell'){
                                    hidePrice = false;
                                    categories = null;
                                    subCategory = null;
                                    setState(() {

                                    });
                                    categories = initModel.data.category;
                                    subCategory = initModel.data.category[0].sub;
                                    categoryId = initModel.data.category[0].sub[0].id;
                                    setState(() {

                                    });
                                  }
                                  else{
                                    hidePrice = false;
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
                    child:categories == null?
                    Container():
                    DropDown<Category>(



                   isCleared: true,

                      items: categories,
                      initialValue: categories[0],


                      hint:  Text(mLanguage == "en"?categories[0].enTitle:categories[0].arTitle,
                        textAlign: TextAlign.start,
                        style: TextStyle(

                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w600,
                            fontSize: screenUtil.setSp(15)
                        ),),
                      onChanged: (Category category){
                        subCategory =[];
                        categoryId = category.sub[0].id;
                        print("categoryid ---> ${categoryId}");
                        subCategory = category.sub;
                        setState(() {

                        });



                      },
                      customWidgets: categories.map((p) => buildDropDownRow(p)).toList(),
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
                    child:subCategory == null?
                    Container():
                    SizedBox(
                      height: 50.h,
                      width: screenUtil.screenWidth,
                      child:
                      DropDown<Sub>(



isCleared: true,

                        items: subCategory,

                        hint:  Text( mLanguage == "en"?subCategory[0].enTitle:
                        subCategory[0].arTitle,
                          textAlign: TextAlign.start,
                          style: TextStyle(

                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w600,
                              fontSize: screenUtil.setSp(15)
                          ),),
                        onChanged: (Sub category){
                          categoryId = category.id;
                          print("subCategoryId ---> ${categoryId}");



                        },
                        customWidgets: subCategory.map((p) => buildSubCategoryRow(p)).toList(),
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

                    keyboardType: TextInputType.text,
                    minLines: 1,
                    maxLines: 1,
                    enableInteractiveSelection: true,
                    controller: _titleArController,


                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,



                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(hintText: getTranslated(context, 'post_title_ar'),
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
                    ),),
                  SizedBox(height: 10.h,),
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
                  TextField(

                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 50,
                    enableInteractiveSelection: true,
                    controller: _descriptionArController,

                    textInputAction: TextInputAction.newline,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,


                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(hintText: getTranslated(context, 'post_description_ar'),
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
                          child:
                          DropDown<String>(





                            items: mLanguage == "en"?initModel.data.ageType.english:initModel.data.ageType.arabic,

                            hint:  Text(mLanguage == "en" ?initModel.data.ageType.english[0]:initModel.data.ageType.arabic[0],
                              textAlign: TextAlign.start,
                              style: TextStyle(

                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenUtil.setSp(15)
                              ),),
                            onChanged: (String age){
                              ageId = age;
                              ageName = age;
                              if(mLanguage == "en"){
                                ageId = "${initModel.data.ageType.english.indexOf(age)}";
                              }else {
                                ageId = "${initModel.data.gender.arabic.indexOf(age)}";
                              }
                              print(ageId);


                            },
                            customWidgets:mLanguage =="en"? initModel.data.ageType.english.map((p) => buildAgeRow(p)).toList():
                            initModel.data.ageType.arabic.map((p) => buildAgeRow(p)).toList(),
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
                    child: DropDown<String>(





                      items:mLanguage == "en"? initModel.data.gender.english:initModel.data.gender.arabic,

                      hint:  Text(getTranslated(context, 'select_gender') ,
                        textAlign: TextAlign.start,
                        style: TextStyle(

                            color: Color(0xFFc3c3c3),
                            fontWeight: FontWeight.w600,
                            fontSize: screenUtil.setSp(15)
                        ),),
                      onChanged: (String gender){
                        if(mLanguage == "en"){
                          genderId = "${initModel.data.gender.english.indexOf(gender)}";
                        }else {
                          genderId = "${initModel.data.gender.arabic.indexOf(gender)}";
                        }
                        print(genderId);



                      },
                      customWidgets:
                      mLanguage == "en"? initModel.data.gender.english.map((p) => builGenderRow(p)).toList():initModel.data.gender.arabic.map((p) => builGenderRow(p)).toList(),

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
                  Container(
                    child:hidePrice == true?
                        Container()
                        :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                      ],
                    ),
                  ),
                  sumbitButton(getTranslated(context, 'sumbit_post'),context)


                ],
              ),
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
  Widget builGenderRow(String gender) {
    return Container(






        alignment: AlignmentDirectional.centerStart,

        child: Text(gender ,
          style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w600,
              fontSize: screenUtil.setSp(15)
          ),));
  }
  Widget buildSubCategoryRow(Sub category) {
    return Container(






        alignment: AlignmentDirectional.centerStart,

        child: Text(mLanguage == "en"?category.enTitle:category.arTitle ,
          style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w600,
              fontSize: screenUtil.setSp(15)
          ),));
  }
  Widget buildAgeRow(String age) {
    return Container(






        alignment: AlignmentDirectional.centerStart,

        child: Text(age ,
          style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w600,
              fontSize: screenUtil.setSp(15)
          ),));
  }
  Widget buildDropDownRow(Category category) {
  return Container(






      alignment: AlignmentDirectional.centerStart,

      child: Text(mLanguage=="en"?category.enTitle:category.arTitle ,
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
    print("subCategoryId ---> ${categoryId}");
    String postTitle = _titleController.text;
    String postDescription =_descriptionController.text;
    String postTitleAr = _titleArController.text;
    String postDescriptionAr = _descriptionArController.text;
    String age = _ageController.text;
    String price = _priceController.text;
    if(mImages.isEmpty){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'image_error'))));

    }else if(categoryId==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'sub_category_error'))));

    }
    else if(postTitle.trim()==""||postTitleAr.trim()==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'title_error'))));

    }else if(postDescription==""||postDescriptionAr.trim()==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'description_error'))));

    }else if(genderId==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'gender_error'))));

    }else {
      List<File> mCompressedImages  = List();

      for(int i =0;i<mImages.length;i++){
        File compressImage = await  CompressFile(mImages[i]);
        mCompressedImages.add(compressImage);

      }
      if (key == 'sell') {

        if (price == "") {
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(getTranslated(context, 'price_error'))));
        }else{
          String userId = loginModel.data.id;
          String phoneNumber ="";
          final modelHud = Provider.of<ModelHud>(context, listen: false);
          modelHud.changeIsLoading(true);
          PetMartService petMartService = PetMartService();
          dynamic response = await petMartService.addPost(
              postTitle,

              postTitleAr,

              key,
              postDescription,
              postDescriptionAr,
              price,
              categoryId,
              age,
              ageId,
              genderId,
              userId,
              categoryId,
              phoneNumber,
              mLanguage,
              mCompressedImages,
              null);
          modelHud.changeIsLoading(false);
          bool status = response['ok'];
          if (status) {
            ShowPostAlertDialog(context, response['data']['msg'], true);
          } else {
            ShowPostAlertDialog(context, response['data']['msg'], false);
          }
        }
      } else {
        String userId = loginModel.data.id;
        String phoneNumber ="";
        final modelHud = Provider.of<ModelHud>(context, listen: false);
        modelHud.changeIsLoading(true);
        PetMartService petMartService = PetMartService();
        dynamic response = await petMartService.addPost(
            postTitle,
            postTitle,
            key,
            postDescription,
            postDescription,
            price,
            categoryId,
            age,
            ageId,
            genderId,
            userId,
            categoryId,
            phoneNumber,
            mLanguage,
            mCompressedImages,
            null);
        modelHud.changeIsLoading(false);
        bool status = response['ok'];
        if (status) {
          ShowPostAlertDialog(context, response['data']['msg'], true);
        } else {
          ShowPostAlertDialog(context, response['data']['msg'], false);
        }
      }
    }

  }
  Future<File> CompressFile(File file) async {
    final dir = await path_provider.getTemporaryDirectory();
    String targetPath = "${dir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";



    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70,


    );

    return result;
  }
  File createFile(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    return file;
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
              Navigator.pushReplacementNamed(context,SplashScreen.id);
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
