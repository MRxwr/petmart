import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:images_picker/images_picker.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ndialog/ndialog.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';

import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/splash_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_mart/model/category_model.dart' as SubCategory;

import 'package:pet_mart/model/home_model.dart' as CategoryParent;
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';


import '../model/InterestModel.dart' as Interest;
import '../model/home_model.dart';
import 'main_sceen.dart';
class CreateAuctionScreen extends StatefulWidget {
  const CreateAuctionScreen({Key key}) : super(key: key);

  @override
  _CreateAuctionScreenState createState() => _CreateAuctionScreenState();
}

class _CreateAuctionScreenState extends State<CreateAuctionScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  String mLanguage;
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();


  LoginModel loginModel;
  List<File> mImages = List();
  NAlertDialog nAlertDialog;
  List<String> Paths= List();
  List<File> vedios = List();
  String categoryId ="";
  String subCategoryId ="";
  CategoryParent.HomeModel homeModel;
  List<CategoryParent.Categories> categoryList;
  SubCategory.CategoryModel mSubCategoryModel;
  String path =null;
  String vedioUrl ="";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isSelected = false;
  String mChooseImage="اختار الصورة";
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

  String ageId ="";
  String languageCode = "";
  Future<CategoryParent.HomeModel> home() async{



    SharedPreferences _preferences = await SharedPreferences.getInstance();
    languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    String homeString = _preferences.getString('home');
    final body = json.decode(homeString);
    CategoryParent.HomeModel   homeModel =CategoryParent.HomeModel.fromJson(body);
    return homeModel;
  }
  Future _getImageFromGallery(BuildContext context) async {
    List<XFile> pickedFile = [];

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
    final picker = ImagePicker();
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


String userId ="";
  Future<HomeModel> interest() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    String loginData = _preferences.getString(kUserModel);



    final body = json.decode(loginData);
    loginModel = LoginModel.fromJson(body);
    userId = loginModel.data.id;



    PetMartService petMartService = PetMartService();
   HomeModel interestModel = await petMartService.home(userId);







    return interestModel;
  }
  String mStartDate;
  String mEndDate;
  HomeModel interestModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime now = DateTime.now();
    DateTime end = now.add(Duration(days: 1));

    mStartDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    mEndDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(end);
    print("mStartDate-->"+mStartDate);
    print("mEndDate-->"+mEndDate);
    interest().then((value) {
      setState(() {
        interestModel = value;

      });






    });
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
                  getTranslated(context, 'create_auction'),
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
            margin: EdgeInsets.all(10.w),
            child:

            Container(
              child: interestModel == null?
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
                    Text(getTranslated(context, 'auction_cover_photo'),
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(16),
                          fontWeight: FontWeight.bold
                      ),),
                    SizedBox(height: 5.h,width: screenUtil.screenWidth,
                    ),
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
                              , itemCount: mImages.length),


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
                            child: vedios.length>=1?
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
                    SizedBox(height: 10.h,),
                    SizedBox(
                      height: 50.h,
                      width: screenUtil.screenWidth,
                      child:interestModel == null?
                      Container(

                      ):
                      DropDown<Categories>(









                        items: interestModel.data.categories,












                        customWidgets: interestModel.data.categories.map((p) => buildDropDownRow(p)).toList(),
                        hint:  Text(getTranslated(context, 'select_category'),
                          textAlign: TextAlign.start,
                          style: TextStyle(

                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w600,
                              fontSize: screenUtil.setSp(15)
                          ),),
                        onChanged: (Categories category){
                          categoryId = category.id;
                          setState(() {



                          });





                        },

                        isExpanded: false,
                        showUnderline: false,


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
                      decoration: InputDecoration(hintText: getTranslated(context, 'auction_title'),
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
                      decoration: InputDecoration(hintText: getTranslated(context, 'auction_description'),
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

                      keyboardType: TextInputType.number,
                      minLines: 1,
                      maxLines: 1,
                      enableInteractiveSelection: true,
                      controller: _priceController,

                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,



                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(hintText: getTranslated(context, 'minimum_bid'),
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
                    sumbitButton(getTranslated(context, 'create_auction'),context)
                  ],
                ),
              ),
            ),

          ),
    ),
        ),
      );
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

  Future<SubCategory.CategoryModel> subCategory(String categoryId) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;


    Map map ;


    map = {"id":categoryId,

      "language":languageCode};





    PetMartService petMartService = PetMartService();
    SubCategory.CategoryModel auctionDetailsModel = await petMartService.category(categoryId);
    return auctionDetailsModel;
  }
  Widget buildDropDownRow(Categories category) {
    return Container(






        alignment: AlignmentDirectional.centerStart,

        child: Text(mLanguage =="en"?category.enTitle:category.arTitle ,
          style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w600,
              fontSize: screenUtil.setSp(15)
          ),));
  }
  Widget buildSubCategoryRow(SubCategory.Categories category) {
    return Container(







        alignment: AlignmentDirectional.centerStart,

        child: Text(mLanguage == "en"?category.enTitle:category.arTitle ,
          style: TextStyle(
              color: Color(0xFF000000),
              fontWeight: FontWeight.w600,
              fontSize: screenUtil.setSp(15)
          ),));
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
  String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    print("$input");
    return input;
  }
  void validate(BuildContext context) async {
    String postTitle = _titleController.text;
    String postDescription =_descriptionController.text;

    String price = _priceController.text;
    if(mImages.isEmpty){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'image_error'))));

    }
    else if(categoryId==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'category_error'))));

    }
    else if(postTitle==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'auction_title_error'))));

    }else if(postDescription==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'auction_desc_error'))));

    }else if(price==""){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'bid_price_error'))));

    }else{
      List<File> mCompressedImages  = List();


      String userId = loginModel.data.id;

      final modelHud = Provider.of<ModelHud>(context,listen: false);
      modelHud.changeIsLoading(true);
      for(int i =0;i<mImages.length;i++){
        File compressImage = await  CompressFile(mImages[i]);
        mCompressedImages.add(compressImage);

      }
      PetMartService petMartService = PetMartService();
      dynamic response = await petMartService.addAuction(postTitle, postTitle, postDescription, postDescription, mStartDate,mEndDate, replaceArabicNumber(price),"running",categoryId, userId, subCategoryId, mLanguage, mCompressedImages, vedios,vedioUrl);
      modelHud.changeIsLoading(false);
      bool status = response['ok'];
      if(status){
        ShowAlertDialog(context, getTranslated(context, "auction_success"),true);

      }else{
        ShowAlertDialog(context, response['data']['msg'],false);
      }
    }

  }
  Future<void> ShowAlertDialog(BuildContext context ,String title,bool success) async{
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
              Navigator.pop(context,"true");
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

}
