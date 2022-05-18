import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ndialog/ndialog.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/credit_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/update_profile_model.dart';
import 'package:pet_mart/model/user_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/credit_screen.dart';
import 'package:pet_mart/screens/favorite_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:pet_mart/widgets/name_textfield.dart';
import 'package:pet_mart/widgets/phone_textfield.dart';
import 'package:pet_mart/widgets/user_name_textfield.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';

import 'main_sceen.dart';
class MyAccountScreen extends StatefulWidget {
  static String id = 'MyAccountScreen';

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  NAlertDialog nAlertDialog;
  String path =null;
  String mChooseImage="اختار الصورة";
  File _image = null;
  bool isSelected = false;
  String userId ="";

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
  Future _getImageFromGallery(BuildContext context) async {
    var pickedFile = null;
     pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {





      isSelected = true;


      _image = File(pickedFile.path);
      path = _image.path;
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
      _image = File(pickedFile.path);
      path = _image.path;
      mChooseImage="تم اختيار الصورة";


      // updateImage(context);




    } else {
      mChooseImage= 'لم يتم اختيار الصورة';
    }

    setState(() {

    });


    Navigator.pop(context);

  }
  LoginModel   loginModel;
  UserModel userModel;

  ScreenUtil screenUtil = ScreenUtil();
  String imageUrl ="";
  String firstName = "";
  String lastName = "";
  String phone ="";
  String email ="";
  String mLanguage="";

  Future<UserModel> user() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    String loginData = _preferences.getString(kUserModel);



      final body = json.decode(loginData);
         loginModel = LoginModel.fromJson(body);
      userId = loginModel.data.id;

    Map<String, String> map = Map();
    map['id']=userId;
    map['email']= email;




    PetMartService petMartService = PetMartService();
    UserModel userModel = await petMartService.user(map);







    return userModel;
  }
  Future<CreditModel> credit() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String loginData = _preferences.getString(kUserModel);
    Map map ;


    final body = json.decode(loginData);
    LoginModel   loginModel = LoginModel.fromJson(body);
    map = {
      "user_id":loginModel.data.id,
      "language":languageCode};





    PetMartService petMartService = PetMartService();
    CreditModel creditModel = await petMartService.credit(map);
    return creditModel;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user().then((value){
      setState(() {
        userModel = value;
        imageUrl = value.data.logo;
      });
    });




  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
              getTranslated(context, 'my_account'),
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

            GestureDetector(
              onTap: (){
                Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                  return new FavoriteScreen();
                }));

              },
              child: Icon(Icons.interests,color: Colors.white,size: 30.h,),
            ),
            SizedBox(width: 10.w,),

          ],

        ),
        backgroundColor: Color(0xFFFFFFFF),
        body: Form(
          key: _globalKey,
          child: Container(

            child: userModel == null?
            Container(
              child: CircularProgressIndicator(


              ),
              alignment: AlignmentDirectional.center,
            ):
                Container(

                  child:
                  ListView(
                    children: [
                      Container(
                        color: Color(0xFFFFC300),
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${getTranslated(context, 'your_credit')} ${ userModel.data.points}',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.normal,
                                fontSize: screenUtil.setSp(18)
                              ),),
                              GestureDetector(
                                onTap: (){
                                  _buttonTapped();
                                },
                                child: Text(getTranslated(context,'purchase_credit'),
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenUtil.setSp(18)
                                  ),),
                              )

                            ],
                          ),
                        ),
                      ),
                      Container(

                        width: width,
                        height: 200.h,
                        child:

                        Stack(
                          children: [



                            Container(
                              child: isSelected?
                                  Container(
                                    child: ClipRRect(

                                      child: Container(
                                          width: width,
                                          child:
                                          new BackdropFilter(
                                            filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                            child: new Container(
                                              decoration: new BoxDecoration(color: Colors.white.withOpacity(0.1)),
                                            ),
                                          ),

                                          decoration: BoxDecoration(

                                            shape: BoxShape.rectangle,

                                            image: DecorationImage(
                                                fit: BoxFit.fill,

                                                image: FileImage(File(path))),
                                          )
                                      ),
                                    ),
                                  )
                              :CachedNetworkImage(
                                width: width,
                                imageUrl:KImageUrl+imageUrl,
                                imageBuilder: (context, imageProvider) => Stack(
                                  children: [
                                    ClipRRect(

                                      child: Container(
                                          width: width,
                                          child:
                                          new BackdropFilter(
                                            filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                            child: new Container(
                                              decoration: new BoxDecoration(color: Colors.white.withOpacity(0.1)),
                                            ),
                                          ),

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


                                errorWidget: (context, url, error) =>

                                    ClipRRect(
                                    child:  Container(
                                      child: BackdropFilter(
                                        filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                        child: new Container(
                                          decoration: new BoxDecoration(color: Colors.white.withOpacity(0.1)),
                                        ),
                                      ),
                                        decoration: BoxDecoration(

                                          shape: BoxShape.rectangle,

                                          image: DecorationImage(
                                              fit: BoxFit.fill,

                                              image: AssetImage('assets/images/placeholder_error.png')),
                                        )

                                    ),

                                )

                              ),
                            ),
                            Positioned.directional( textDirection:  Directionality.of(context)
                                ,
                                top: 0,
                                bottom: 0,
                                start: 0,
                                end: 0
                                , child:
                                GestureDetector(
                                  onTap: (){
                                    showPickerDialog(context).then((value){
                                      value.show(context);
                                    });
                                  },
                                  child: Center(
                                    child: isSelected?
                                    Container(
                                        width: 100.w,
                                        height: 100.h,

                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,

                                          image: DecorationImage(
                                              image: FileImage(File(path)),
                                              fit: BoxFit.fill),
                                        )
                                    )
                                        :
                                    CachedNetworkImage(
                                      width: 100.w,
                                      height: 100.h,
                                      imageUrl:KImageUrl+imageUrl,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                              width: 100.w,
                                              height: 100.h,

                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,

                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill),
                                              )
                                          ),
                                      placeholder: (context, url) =>
                                          Center(
                                            child: SizedBox(
                                                height: 30.h,
                                                width: 30.h,
                                                child: new CircularProgressIndicator()),
                                          ),


                                      errorWidget: (context, url, error) =>


                                          ClipRRect(
                                            child:  Container(

                                                decoration: BoxDecoration(

                                                  shape: BoxShape.circle,

                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,

                                                      image: AssetImage('assets/images/placeholder_error.png')),
                                                )

                                            ),

                                          )

                                    ),
                                  ),
                                ))


                          ],
                        ),

                      ),
                      SizedBox(height: 10.h,width: width,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.h),
                        child: UserNameTextField(hint:getTranslated(context,'first_name'),onClick: (value){
                          firstName = value;

                        },mText: userModel.data.name.split(" ")[0],

                        ),
                      ),
                      SizedBox(height: 10.h,width: width,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.h),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: UserNameTextField(hint:getTranslated(context, 'last_name'),onClick: (value){
                            lastName = value;

                          },mText: userModel.data.name.split(" ")[1],

                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,width: width,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.h),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: NameTextField(hint:getTranslated(context, 'email_address'),onClick: (value){
                            email = value;

                          },
                            mText: userModel.data.email,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,width: width,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.h),
                        child:
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: PhoneTextField(hint:getTranslated(context, 'mobile'),onClick: (value){
                            phone = value;

                          },
                            mText: userModel.data.mobile,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h,width: width,),
                      Container(margin: EdgeInsets.symmetric(horizontal: 20.w),
                          child: confirmButton(getTranslated(context, 'update_profile'),context)),
                    ],
                  )
                  ,

                )


          ),
        ),
    ),
      );
  }
  TextButton confirmButton(String text,BuildContext context){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFF000000),
      minimumSize: Size(120.w, 35.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: Color(0xFFFFC300),
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {

        validate(context);
      },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(14),
          fontWeight: FontWeight.w500
      ),),
    );
  }
  void validate(BuildContext context) async {
    if(_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if(path != null)
      {
        dynamic response;
        final modelHud = Provider.of<ModelHud>(context,listen: false);
        modelHud.changeIsLoading(true);
        // final bytes =_image.readAsBytesSync();
        // String _img64 = base64Encode(bytes);
        // print(_img64);
        PetMartService petMartService = PetMartService();
        String deviceType="";
        String uniqueId="";

        if(Platform.isAndroid){
          deviceType = "a";
          uniqueId = await UniqueIdentifier.serial;
        }else{
          deviceType = "i";
          final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
          var data = await deviceInfoPlugin.iosInfo;
          uniqueId = data.identifierForVendor;
        }
        Map<String, dynamic> map = Map();
        map['id']=userId;
        map['name']= firstName+" "+lastName;
        map['email']=email;
        map['mobile']=phone;

          String imagePath = File(path).absolute.path;


          String childFileName = imagePath
              .split('/')
              .last;
          print ('childFileName ${childFileName}');
          map['image']=  await MultipartFile.fromFile(imagePath, filename: childFileName);




        UserModel userModel  =await petMartService.updateProfile(userId,firstName+" "+lastName,email,phone,path);
        bool  status = userModel.ok;
        modelHud.changeIsLoading(false);
        if(status ){
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(userModel.status)));
          Navigator.pushReplacementNamed(context,MainScreen.id);
        }else{
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(userModel.status)));

        }




      }else {
        if (firstName == userModel.data.name.split(" ")[0] &&
            lastName == userModel.data.name.split(" ")[1] &&
            email == userModel.data.email && phone == userModel.data.mobile) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'update_data'))));

        }else{
          dynamic response;
          final modelHud = Provider.of<ModelHud>(context,listen: false);
          modelHud.changeIsLoading(true);
          PetMartService petMartService = PetMartService();
          String deviceType="";
          String uniqueId="";
          Map<String, String> map = Map();
          map['id']=userId;
          map['name']= firstName+" "+lastName;
          map['email']=email;
          map['mobile']=phone;
          if(Platform.isAndroid){
            deviceType = "a";
            uniqueId = await UniqueIdentifier.serial;
          }else{
            deviceType = "i";
            final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
            var data = await deviceInfoPlugin.iosInfo;
            uniqueId = data.identifierForVendor;
          }
          UserModel userModel  =await petMartService.updateProfile(userId,firstName+" "+lastName,email,phone,path);
          modelHud.changeIsLoading(false);
          bool status = userModel.ok;
          if(status){
            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(userModel.status)));
            Navigator.pushReplacementNamed(context,MainScreen.id);
          }else{
            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(userModel.status)));

          }

        }
      }
    }

  }
  void getImageString(String filePath){

  }
  Future _buttonTapped() async {
    Map results =  await Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
      return new CreditScreen();
    }
    ));

    if (results != null && results.containsKey('selection')) {
      userModel = null;
      setState(() {

      });

      SharedPreferences _preferences = await SharedPreferences.getInstance();
      String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
      mLanguage = languageCode;
      String loginData = _preferences.getString(kUserModel);



      final body = json.decode(loginData);
      loginModel = LoginModel.fromJson(body);
      userId = loginModel.data.id;

      Map<String, String> map = Map();
      map['id']=userId;
      map['email']= email;




      PetMartService petMartService = PetMartService();
       userModel = await petMartService.user(map);
      imageUrl = userModel.data.logo;
      setState(() {

      });

    }
  }
}


