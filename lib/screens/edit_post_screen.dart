import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';
import 'package:pet_mart/model/InitEditModel.dart';

import 'package:pet_mart/model/post_details_model.dart';
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

import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/type_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/create_auction_screen.dart';
import 'package:pet_mart/screens/vedio_screen.dart';
import 'package:pet_mart/screens/youtube_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

import '../model/DeletePostImageModel.dart';
import '../model/age_model.dart';
import '../model/gender_model.dart';
import 'main_sceen.dart';
class EditPostScreen extends StatefulWidget {
  static String id = 'PetsDetailsScreen';
  PostDetailsModel  postDetailsModel;
  String userId;

  EditPostScreen({Key key,@required this.postDetailsModel,@required this.userId}) : super(key: key);

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {

  ScreenUtil screenUtil = ScreenUtil();
  List<TypeModel> typesList = List();
  bool hidePrice = false;
  String mLanguage='';
  String userId ='';
  List<File> vedios =[];
  String vedioUrl ="";
  List<AgeModel> agesList = [];
  List<GenderModel> genderList = [];
  List<Category> categories = null;
  List<Sub> subCategory = null;
  List<File> mImages = List();
  NAlertDialog nAlertDialog;
  List<String> Paths= List();
  String path =null;
  bool isSelected = false;
  String mChooseImage="اختار الصورة";
  String categoryId ="";
  String subCategoryId ="";

  String genderId ="";
  String ageName="";
  String genderName ="";
  String key ="";
  LoginModel loginModel;
  String categoryName;
  String subCategoryName;
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
    List<XFile> pickedFile = [];
    ImagePicker picker = ImagePicker();
    try {
      List<Media> res = await ImagesPicker.pick(
        count: 10,
        pickType: PickType.all,
        language: Language.System,
        maxTime: 30,
        // maxSize: 500,
        cropOpt: CropOption(
          // aspectRatio: CropAspectRatio.wh16x9,
          cropType: CropType.rect,
        ),
      );

      if (res!= null || res.isNotEmpty) {
        isSelected = true;
        for (int i = 0; i < res.length; i++) {
          File _image = File(res[i].path);
          mImages.add(_image);
          Paths.add(_image.path);
        }


        // updateImage(context);


      } else {
        mChooseImage = 'لم يتم اختيار الصورة';
      }

      setState(() {


      });


      Navigator.pop(context);
    }catch(e){
      print(e.toString());
    }
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
  InitEditModel initModel;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CategoryParent.HomeModel homeModel;

  List<String> galleryList = [];
  List<String> imagesUrl =[];
  List<String> vediosUrl =[];
  Category category;
  Sub mSubCategory;

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
    galleryList.clear() ;

    categoryId = widget.postDetailsModel.data.items[0].categoryId;
    subCategoryId = widget.postDetailsModel.data.items[0].categoryId;

    _titleController.text =mLanguage == "en"? widget.postDetailsModel.data.items[0].enTitle:widget.postDetailsModel.data.items[0].arTitle;
    _descriptionController.text = mLanguage == "en"? widget.postDetailsModel.data.items[0].enDetails:widget.postDetailsModel.data.items[0].arTitle;
    _priceController.text = widget.postDetailsModel.data.items[0].price;
    _ageController.text = widget.postDetailsModel.data.items[0].age;
    genderName = mLanguage == "en"?widget.postDetailsModel.data.items[0].gender:widget.postDetailsModel.data.items[0].genderAr;
    ageId = widget.postDetailsModel.data.items[0].ageType;
    subCategoryId = widget.postDetailsModel.data.items[0].categoryId;





    map().then((value) {
      initModel = value;
      categories =[];
      subCategory =[];
      galleryList = initModel.data.post[0].image;
      imagesUrl = initModel.data.post[0].imageId;
      ageId = initModel.data.post[0].ageType;
      vedioUrl = initModel.data.post[0].video;
      if(vedioUrl.trim() !=""){
        vediosUrl.add(vedioUrl);
      }
      genderId = initModel.data.post[0].gender;
      for(int i =0;i<initModel.data.category.length;i++)
        {
          for(int j=0;j<initModel.data.category[i].sub.length;j++){
            String id = initModel.data.category[i].sub[j].id;
            if(id == subCategoryId){
              categories = initModel.data.category;
              category = categories[i];
              subCategory = initModel.data.category[i].sub;
              mSubCategory = subCategory[j];
              categoryId = initModel.data.category[i].sub[j].id;
              typesList[0].selected  = true;
              typesList[1].selected  = false;

              typesList[2].selected  = false;
              break;
            }
          }

        }
      for(int i =0;i<initModel.data.lost.length;i++)
      {
        for(int j=0;j<initModel.data.lost[i].sub.length;j++){
          String id = initModel.data.lost[i].sub[j].id;
          if(id == subCategoryId){
            categories = initModel.data.lost;
            category = categories[i];
            subCategory = initModel.data.lost[i].sub;
            mSubCategory = subCategory[j];
            categoryId = initModel.data.lost[i].sub[j].id;
            typesList[0].selected  = false;
            typesList[1].selected  = false;

            typesList[2].selected  = true;
            break;
          }
        }

      }
      for(int i =0;i<initModel.data.adoption.length;i++)
      {
        for(int j=0;j<initModel.data.adoption[i].sub.length;j++){
          String id = initModel.data.adoption[i].sub[j].id;
          if(id == subCategoryId){
            categories = initModel.data.adoption;
            category = categories[i];
            subCategory = initModel.data.adoption[i].sub;
            mSubCategory = subCategory[j];
            categoryId = initModel.data.adoption[i].sub[j].id;
            typesList[0].selected  = false;
            typesList[1].selected  = true;

            typesList[2].selected  = false;
            break;
          }
        }

      }

      setState(() {

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
  Future<InitEditModel> map() async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;

    PetMartService petMartService = PetMartService();
    InitEditModel initModel =  await petMartService.initEdit(widget.postDetailsModel.data.items[0].id);


    String loginData = _preferences.getString(kUserModel);
    final body = json.decode(loginData);
    loginModel = LoginModel.fromJson(body);


    userId = loginModel.data.id;

    // agesList = initModel.data.age;

    // genderList = initModel.data.genderList;

    return initModel;
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
                  getTranslated(context, 'edit_post'),
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
                                category = null;
                                mSubCategory = null;
                                setState(() {

                                });
                                if(!selectedIndex){
                                  key = typesList[index].key;

                                  for(int i =0;i<typesList.length;i++){
                                    if(i == index){
                                      typesList[i].selected= true;
                                    }else{
                                      typesList[i].selected= false;
                                    }

                                  }

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
                                    setState(() {
                                      hidePrice = true;
                                      categories = null;
                                      subCategory = null;

                                      categories = initModel.data.adoption;

                                      print(categories.length);
                                      subCategory = initModel.data.adoption[0].sub;


                                      categoryId = initModel.data.adoption[0].sub[0].id;
                                      print(subCategory);

                                    });

                                  }else if(key == 'lost-animal'){

                                    setState(() {
                                      hidePrice = true;
                                      categories = null;
                                      subCategory = null;



                                      categories=initModel.data.lost;
                                      print(categories.length);
                                      subCategory = categories[0].sub;


                                      print("enTitlte--->"+category.enTitle);
                                      subCategory = initModel.data.lost[0].sub;
                                      categoryId = initModel.data.lost[0].sub[0].id;
                                    });
                                  }if(key == 'sell'){

                                    setState(() {
                                      hidePrice = false;
                                      categories = null;
                                      subCategory = null;

                                      categories = initModel.data.category;
                                      subCategory = initModel.data.category[0].sub;
                                      categoryId = initModel.data.category[0].sub[0].id;


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
                  Text(getTranslated(context, 'add_photo'),
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
                              return buildImage(galleryList[index],index);
                            }, separatorBuilder: (context,index) {
                          return Container(width: 10.h,
                            color: Color(0xFFFFFFFF),);
                        }
                            , itemCount: galleryList.length),
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
                  SizedBox(height: 5.h,width: screenUtil.screenWidth,
                  ),
                  Text(getTranslated(context, 'add_vedio'),
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
                        Container(
                          child: vedioUrl.trim()!=""?
                          Container():GestureDetector(
                            onTap: (){
                              showVedioPickerDialog(context).then((value){
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
                        ),
                        SizedBox(width: 10.w,
                          height: 100.h,),
                        Container(
                          child: vedioUrl == ""?
                          Container():ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                    onTap: (){

                                      String title = "";
                                      if(mLanguage == "en"){
                                        title = initModel.data.post[0].enTitle;
                                      }else{
                                        title =  initModel.data.post[0].arTitle;
                                      }
                                      if(vedioUrl.trim()!=""){
                                        if(vedioUrl.contains("youtu")){
                                          Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                                            return new YouTubeScreen(youtubeId:vedioUrl,auctionName: title);
                                          }));
                                        }else{
                                          Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                                            return new VideoScreen(vedioUrl:vedioUrl,auctionName: title,);
                                          }));
                                        }

                                      }

                                    },
                                    child: pickVedio(vedioUrl,index));
                              }, separatorBuilder: (context,index) {
                            return Container(width: 10.h,
                              color: Color(0xFFFFFFFF),);
                          }
                              , itemCount: vediosUrl.length),
                        ),
                        SizedBox(width: 10.w,
                          height: 100.h,),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index){
                              return pickedVedio(vedios[index],index);
                            }, separatorBuilder: (context,index) {
                          return Container(width: 10.h,
                            color: Color(0xFFFFFFFF),);
                        }
                            , itemCount: vedios.length),


                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                    width: screenUtil.screenWidth,
                    child:categories == null?
                    Container(

                    ):
                    DropDown<Category>(









                      items: categories,
                      initialValue: categories.first,











                      customWidgets: categories.map((p) => buildDropDownRow(p)).toList(),
                      hint:  Text(mLanguage == "en"?categories[0].enTitle:categories[0].arTitle,
                        textAlign: TextAlign.start,
                        style: TextStyle(

                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w600,
                            fontSize: screenUtil.setSp(15)
                        ),),
                      onChanged: (Category category){

                        setState(() {

                          this.category = category;
                          subCategory = category.sub;
                          mSubCategory = null;

                        });





                      },

                      isExpanded: false,
                      showUnderline: false,
                      isCleared: category == null?true:false,

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
                    child:subCategory==null?
                    Container():
                    SizedBox(
                      height: 50.h,
                      width: screenUtil.screenWidth,
                      child: new
                      DropDown<Sub>(





                        items: subCategory,


                        hint:  Text( mLanguage == "en"?subCategory.isNotEmpty?subCategory[0].enTitle:"":
                        subCategory.isNotEmpty? subCategory[0].arTitle:"",
                          textAlign: TextAlign.start,
                          style: TextStyle(

                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w600,
                              fontSize: screenUtil.setSp(15)
                          ),),
                        onChanged: (Sub category){
                          categoryId = category.id;

                          setState(() {
                            mSubCategory = category;

                          });
                          print("subCategoryId ---> ${categoryId}");



                        },
                        customWidgets: subCategory.map((p) => buildSubCategoryRow(p)).toList(),
                        isExpanded: true,
                        showUnderline: false,
                        isCleared: mSubCategory == null?true:false,
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
                          child:
                          DropDown<String>(
                            initialValue:mLanguage == "en"?initModel.data.ageType.english[int.parse(initModel.data.post[0].ageType)]:initModel.data.ageType.arabic[int.parse(initModel.data.post[0].ageType)],





                            items: mLanguage == "en"?initModel.data.ageType.english:initModel.data.ageType.arabic,

                            hint:  Text(mLanguage == "en"?initModel.data.ageType.english[int.parse(initModel.data.post[0].ageType)]:initModel.data.ageType.arabic[int.parse(initModel.data.post[0].ageType)],
                              textAlign: TextAlign.start,
                              style: TextStyle(

                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenUtil.setSp(15)
                              ),),
                            onChanged: (String age){

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

                      hint:  Text(mLanguage == "en"?initModel.data.gender.english[int.parse(initModel.data.post[0].gender)]:initModel.data.gender.arabic[int.parse(initModel.data.post[0].gender)],
                        textAlign: TextAlign.start,
                        style: TextStyle(

                            color: Color(0xFF000000),
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
                  Container(
                      child: key =='sell'?
                      Column(
                        children: [
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
                        ],
                      ):Container()
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
    String postTitle = _titleController.text;
    String postDescription =_descriptionController.text;
    String age = _ageController.text;
    String price = _priceController.text.trim().isEmpty?"0.5":_priceController.text;
    if(subCategoryId==""){
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

    }else if(genderId==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'gender_error'))));

    }else{
      if(key =='sell') {
        if(price == ""){
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'price_error'))));

        }else {
          String userId = loginModel.data.id;
          String phoneNumber = "";
          final modelHud = Provider.of<ModelHud>(context, listen: false);
          modelHud.changeIsLoading(true);
          PetMartService petMartService = PetMartService();
          dynamic response = await petMartService.editPost(
              widget.postDetailsModel.data.items[0].id,
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
              mImages,
              null,
          vedioUrl);
          modelHud.changeIsLoading(false);
          bool status = response['ok'];
          if (status) {
            ShowPostAlertDialog(context, getTranslated(context, "post_add_successfuly"), true);
          } else {
            ShowPostAlertDialog(context, response['data']['msg'], false);
          }
        }
      }else{
        String userId = loginModel.data.id;
        String phoneNumber = "";
        final modelHud = Provider.of<ModelHud>(context, listen: false);
        modelHud.changeIsLoading(true);
        PetMartService petMartService = PetMartService();
        dynamic response = await petMartService.editPost(
            widget.postDetailsModel.data.items[0].id,
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
            mImages,
            null,vedioUrl);
        modelHud.changeIsLoading(false);

        bool status = response['ok'];
        if (status) {
          ShowPostAlertDialog(context, getTranslated(context, "post_add_successfuly"), true);
        } else {
          ShowPostAlertDialog(context, response['data']['msg'], false);
        }
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
            getTranslated(context, 'ok'),
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
            getTranslated(context, 'ok'),
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
  Widget buildImage(String gallery, int index) {
    return Container(
      width: 100.h,
      height: 100.h,


      child: Container(

        child:   CachedNetworkImage(
          width: 100.h,
          height: 100.h,
          imageUrl:KImageUrl+gallery,
          imageBuilder: (context, imageProvider) => Stack(
            children: [
              ClipRRect(

                child: Container(
                  width: 100.h,

                  decoration:BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0.h),
                      color: Color(0xFFFFFFFF),
                      border: Border.all(
                          color: Color(0xCC000000),
                          width: 1.0.w
                      ),
                      image: DecorationImage(
                          fit: BoxFit.fill,

                          image: imageProvider)
                  ), child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
                  alignment: AlignmentDirectional.topStart,
                  child: GestureDetector(
                      onTap: (){
                        removeImage(index);

                      },
                      child: Icon(Icons.delete,color: Colors.red,size: 20.h,)),

                ),



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

      ),


    );

  }
  Future<void> removeImage(int index)async{
    String id = imagesUrl[index];
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeIsLoading(true);
    PetMartService petMartService = PetMartService();
    DeletePostImageModel deletePostImageModel =await petMartService.deleteImage(id);
    modelHud.changeIsLoading(false);
    if(deletePostImageModel.ok){
      imagesUrl.removeAt(index);
      galleryList.removeAt(index);
      setState(() {

      });

    }


  }
  Future<NAlertDialog> showVedioPickerDialog(BuildContext context)async {
    nAlertDialog =   await NAlertDialog(
      dialogStyle: DialogStyle(titleDivider: true,borderRadius: BorderRadius.circular(10)),

      content: Padding(child: Text(getTranslated(context, 'select_vedio')),
        padding: EdgeInsets.all(10),),
      actions: <Widget>[
        FlatButton(child: Text(getTranslated(context, 'camera')),onPressed: () {

          _getVedioFromCamera(context);
        }),
        FlatButton(child: Text(getTranslated(context, 'gallery')),onPressed: () {
          _getVedioFromGallery(context);
        }),

      ],
    );
    return nAlertDialog;
  }
  Container pickedVedio(File image,int position){
    return Container(
      width: 100.h,
      height: 100.h,
      padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0.h),
        color: Color(0xFFAAAAAA),
        border: Border.all(
            color: Color(0xCC000000),
            width: 1.0.w
        ),

      ),
      child: Container(
        alignment: AlignmentDirectional.topStart,
        child: Stack(

          children: [
            Center(
              child: Icon(Icons.video_library_sharp,color: kMainColor,size: 50.h,),
            ),
            Positioned.directional(
              textDirection:  Directionality.of(context),

              child: GestureDetector(
                  onTap: (){
                    vedios.removeAt(position);
                    vedioUrl ="";
                    setState(() {

                    });

                  },
                  child: Icon(Icons.delete,color: Colors.red,size: 20.h,)),
            ),
          ],
        ),

      ),


    );
  }
  Container pickVedio(String vedioUrl,int position){
    return Container(
      width: 100.h,
      height: 100.h,
      padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0.h),
        color: Color(0xFFAAAAAA),
        border: Border.all(
            color: Color(0xCC000000),
            width: 1.0.w
        ),

      ),
      child: Container(
        alignment: AlignmentDirectional.topStart,
        child: Stack(

          children: [
            Center(
              child: Icon(Icons.video_library_sharp,color: kMainColor,size: 50.h,),
            ),
            Positioned.directional(
              textDirection:  Directionality.of(context),

              child: GestureDetector(
                  onTap: (){


                    vediosUrl.removeAt(0);
                    this.vedioUrl= "";

                    setState(() {

                    });

                  },
                  child: Icon(Icons.delete,color: Colors.red,size: 20.h,)),
            ),
          ],
        ),

      ),


    );
  }
  Future _getVedioFromGallery(BuildContext context) async {
    var pickedFile = null;
    final picker = ImagePicker();
    pickedFile = await picker.pickVideo(source: ImageSource.gallery,maxDuration:Duration(seconds: 15));

    if (pickedFile != null) {
      VideoPlayerController testLengthController = new VideoPlayerController.file(File(pickedFile.path));//Your file here
      await testLengthController.initialize();
      if (testLengthController.value.duration.inSeconds > 15) {
        pickedFile = null;
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'select_vedio_error'))));
      }else {
        final modelHud = Provider.of<ModelHud>(context, listen: false);
        modelHud.changeIsLoading(true);
        await VideoCompress.setLogLevel(0);
        final MediaInfo info = await VideoCompress.compressVideo(
          pickedFile.path,
          quality: VideoQuality.MediumQuality,
          deleteOrigin: false,
          includeAudio: true,
        );
        print(info.path);


        isSelected = true;
        File _image = File(info.path);

        vedios.add(_image);
        Navigator.pop(context);
        PetMartService petMartService = PetMartService();
        dynamic response = await petMartService.addVedio(_image);
        modelHud.changeIsLoading(false);
        bool status = response['ok'];
        if (status) {
          vedioUrl = response['data']['link'];
        } else {
          ShowPostAlertDialog(context, response['data']['msg'], false);
        }

        // updateImage(context);
      }


    } else {


      mChooseImage = 'لم يتم اختيار الصورة';
    }


    setState(() {


    });



  }
  Future _getVedioFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    var pickedFile = await picker.pickVideo(source: ImageSource.camera,maxDuration:Duration(seconds: 15));

    if (pickedFile != null) {
      final modelHud = Provider.of<ModelHud>(context,listen: false);
      modelHud.changeIsLoading(true);
      await VideoCompress.setLogLevel(0);
      final MediaInfo  info = await VideoCompress.compressVideo(
        pickedFile.path,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false,
        includeAudio: true,
      );
      print(info.path);





      isSelected = true;
      File _image = File(info.path);

      vedios.add(_image) ;

      PetMartService petMartService = PetMartService();
      dynamic response = await petMartService.addVedio(_image);
      modelHud.changeIsLoading(false);
      bool status = response['ok'];
      if (status) {
        vedioUrl = response['data']['link'];
      } else {
        ShowPostAlertDialog(context, response['data']['msg'], false);
      }




    } else {
      mChooseImage= 'لم يتم اختيار الصورة';
    }

    setState(() {

    });




  }

}


