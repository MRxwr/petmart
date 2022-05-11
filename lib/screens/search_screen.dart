
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



        setState(() {
          mLanguage = value;
        });

    });

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
            Container(
              height: 30.w,
              width: 30.w,
            )
          ],

        ),
        backgroundColor: Color(0xFFFFFFFF),
        body: Container(
          child:mLanguage ==""?
          Container(
            child: CircularProgressIndicator(


            ),
            alignment: AlignmentDirectional.center,
          ): ListView(
            children: [
              _bulidSearchComposer(),
              SizedBox(height: 30.h,),
              Container(child: confirmButton(getTranslated(context, 'search'),context),
              margin: EdgeInsets.symmetric(horizontal: 10.w),),
              SizedBox(height: 30.h,),



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

  void search(String searchText) async{

    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeIsLoading(true);
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;
    PetMartService petMartService = PetMartService();


    dynamic response = await petMartService.search(searchText);
    modelHud.changeIsLoading(false);
    bool  isOk  = response['ok'];
    if(isOk){
      SearchModel searchModel = SearchModel.fromJson(response);
      Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
        return new SearchResultScreen(searchModel:searchModel,mLanguage: mLanguage,);
      }));
    }else{
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(response['data'])));
    }



  }
  TextButton confirmButton(String text,BuildContext context){
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Color(0xFF000000),
      minimumSize: Size(screenUtil.screenWidth, 35.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0.w)),
      ),
      backgroundColor: Color(0xFFFFC300),
    );

    return TextButton(
      style: flatButtonStyle,
      onPressed: () {

        String searchText=  _commentController.text;
        if(searchText.trim() != ""){
          search(searchText);


        }else{
          _scaffoldKey.currentState.showSnackBar(
              SnackBar(content: Text(getTranslated(context, "write_search_text"))));
        }
      },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(16),
          fontWeight: FontWeight.w500
      ),),
    );
  }

}
