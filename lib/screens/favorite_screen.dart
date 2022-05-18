import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pet_mart/model/AddInterestModel.dart';
import 'package:pet_mart/model/InterestModel.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/pet_mart_service.dart';
import '../localization/localization_methods.dart';
import '../providers/model_hud.dart';
import '../utilities/constants.dart';
import 'main_sceen.dart';
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  ScreenUtil screenUtil = ScreenUtil();
  String mLanguage;
  LoginModel loginModel;
  InterestModel interestModel;
  String userId ="";
  List<bool> selectedList =[];

  Future<InterestModel> interest() async{

    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    mLanguage = languageCode;
    String loginData = _preferences.getString(kUserModel);



    final body = json.decode(loginData);
    loginModel = LoginModel.fromJson(body);
    userId = loginModel.data.id;

    Map<String, String> map = Map();
    map['id']=userId;

    PetMartService petMartService = PetMartService();
    InterestModel interestModel = await petMartService.interests(userId);







    return interestModel;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    interest().then((value){
      setState(() {
        interestModel = value;
        for(int i =0;i<interestModel.data.length;i++){
          int isInterested = interestModel.data[i].interest;
          if(isInterested == 1){
            selectedList.add(true);
          }else{
            selectedList.add(false);
          }


        }
      });

    });
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                getTranslated(context, 'intersts'),
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


            SizedBox(width: 30.w,),

          ],

        ),
        backgroundColor: Color(0xFFFFFFFF),
        body: Container(
          child: interestModel == null?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          ):
          Container(

            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,



              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      bool isSelected = selectedList[index];
                      selectedList[index] = !isSelected;
                      setState(() {

                      });
                    },
                    child: Container(
                      width: screenUtil.screenWidth,
                      height: 60.w,
                      child: Row(
                        children: [
                          Expanded(flex:3,child: Container(
                            alignment: AlignmentDirectional.centerStart,
                            margin: EdgeInsetsDirectional.only(start: 10.w),
                            child: Text(
                             mLanguage == "en"? interestModel.data[index].enTitle:
                                 interestModel.data[index].arTitle,
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.w500,
                                fontSize: screenUtil.setSp(16),
                              ),
                            ),
                          )),
                          Expanded(flex:1,child: GestureDetector(
                            onTap: (){
                              bool isSelected = selectedList[index];
                              selectedList[index] = !isSelected;
                              setState(() {

                              });
                            },
                            child: Container(
                              child:!selectedList[index]?Container(
                                alignment: AlignmentDirectional.center,
                                child:  Icon(Icons.radio_button_unchecked_outlined,color: kMainColor,size: 40.w,),
                              ):
                              Container(
                                alignment: AlignmentDirectional.center,
                                child:  Icon(Icons.check_circle_outline_sharp,color: kMainColor,size: 40.w,),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                  );
                }, separatorBuilder: (context,index){
                  return Container(width: screenUtil.screenWidth,
                  height: 1.w,
                  color: Color(0xFF000000),);
                }, itemCount: interestModel.data.length),
                SizedBox(height: 20.h,width: screenUtil.screenWidth,),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    height: 50.w,
                    child: isView()?confirmButton(getTranslated(context, 'add_to_interests'),context):Container()),

                SizedBox(height: 100.h,width: screenUtil.screenWidth,),
              ],
            ),
          ),

        ),
      ),
    );
  }
  bool isView(){
    bool isView = false;
    for(int i =0;i<selectedList.length;i++){
      if(selectedList[i]){
        isView = true;
        break;
      }

    }
    return isView;
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

  void validate(BuildContext context) async{
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.changeIsLoading(true);
    Map<String,String> map = Map();
    map['customerId'] = userId;
    for(int i =0;i<selectedList.length;i++){
      if(selectedList[i]){
        map['category[$i]'] = interestModel.data[i].id;
      }

    }
    PetMartService petMartService = PetMartService();
    AddInterestModel addInterestModel  =await petMartService.addInterest(map);
    bool isOk = addInterestModel.ok;
    modelHud.changeIsLoading(false);
    if(isOk){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(getTranslated(context, 'interested_added_successfully'))));
      Navigator.pushReplacementNamed(context,MainScreen.id);
    }
  }
}
