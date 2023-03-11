
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pet_mart/api/pet_mart_service.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/home_model.dart';
import 'package:pet_mart/model/search_model.dart';
import 'package:pet_mart/model/type_model.dart';
import 'package:pet_mart/providers/model_hud.dart';
import 'package:pet_mart/screens/pets_details_screen.dart';
import 'package:pet_mart/screens/search_result_screen.dart';
import 'package:pet_mart/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_mart/model/category_model.dart'as SubCategory;
import '../model/login_model.dart';
class SearcgScreen extends StatefulWidget {
  const SearcgScreen({Key? key}) : super(key: key);

  @override
  _SearcgScreenState createState() => _SearcgScreenState();
}

class _SearcgScreenState extends State<SearcgScreen> {
  ScreenUtil screenUtil = ScreenUtil();
  String mLanguage="";
  int _stackIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String subCategoryId ="";
  bool isLoading = false;
  String errorMessage = "";
  SearchModel? searchModel;


  String _singleValue = "Text alignment right";
  String _verticalGroupValue = "Pending";

  List<String> _statusEn = ["For Sale", "Adaption", "Lost"];
  List<String> _statusAr = ["للبيع", "تبني", "مفقود"];
  List<String> _statusKey =["sell","adoption","animal"];
  List<bool> selectedList = [];
  List<bool> selectedSubList = [];
  final TextEditingController _commentController = new TextEditingController();
  final TextEditingController _startPriceController = new TextEditingController();
  final TextEditingController _endPriceController = new TextEditingController();
  List<TypeModel> typesList = [];
  double? itemWidth;
  double? itemHeight;
  int _groupValue = -1;
  List<String> selectedSubCategoriesId = [];
  List<Categories> _categoryList = [];
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
    _commentController.addListener(() {
      if(_commentController.text.length>=3){
        search(_commentController.text);
      }else if(_commentController.text.length == 0){
        searchModel = null;
        setState(() {

        });

      }

    });
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
    itemWidth = width / 2;
    itemHeight = 200.h;
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
                getTranslated(context, 'advanced_search')!,
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
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              _bulidSearchComposer(),

              Container(
                child: !isLoading? Container():
                errorMessage != ""?
                    Container(
                      alignment: AlignmentDirectional.center,
                      child:  Text(

                        errorMessage,
                        style: TextStyle(
                            color: Color(0xFF000000),
                          fontSize: screenUtil.setSp(18),
                          fontWeight: FontWeight.bold


                        ),
                      ),
                    ):
                Container(
                  child: searchModel == null?
                      Container():
                  GridView.builder(scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                        childAspectRatio:itemWidth!/itemHeight!),
                    itemCount: searchModel!.data!.items!.length,

                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context,rootNavigator: true).push(new MaterialPageRoute(builder: (BuildContext context){
                            return new PetsDetailsScreen(postId:searchModel!.data!.items![index]!.id!,postName: mLanguage == "en"?searchModel!.data!.items![index].enTitle!:searchModel!.data!.items![index].arTitle!,);
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
                                child: buildItem(searchModel!.data!.items![index],context))),
                      );
                    },
                  ),
                ),

              ),
              SizedBox(height: 30.w,)



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
              height: 50.0,

              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(6.h),
                  color: Color(0xFFdcdcdc)
              ),
              child:

              SizedBox(
             
                child: Stack(
                  children: <Widget>[

                    SizedBox(
                      height: 50.w,

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
                        decoration: InputDecoration(hintText: getTranslated(context, 'type_text_here'),hintStyle: TextStyle(
                          color: Color(0xFFa3a3a3),



                        ),
                            border: InputBorder.none,
                           focusedBorder: InputBorder.none,
                          enabledBorder :InputBorder.none


                        ),
                      ),
                    ),

                    Positioned.directional(
                      textDirection: Directionality.of(context),
                        top: 0,
                        bottom: 0,
                        end: 10.w,
                        child: Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              String searchText=  _commentController.text;
                              if(searchText.trim() != ""){
                                search(searchText);


                              }else{
                                Fluttertoast.showToast(
                                    msg: getTranslated(context, "write_search_text")!,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: screenUtil.setSp(16)
                                );

                              }
                            },
                              child: Icon(Icons.search,size: 30.w,color: Colors.white,)),
                        ))



                  ],
                ),
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
    isLoading = true;

    dynamic response = await petMartService.search(searchText);
    modelHud.changeIsLoading(false);
    bool  isOk  = response['ok'];
    errorMessage ="";
    if(isOk){
       searchModel = SearchModel.fromJson(response);

    }else{
      errorMessage = response['data'];
      // _scaffoldKey.currentState.showSnackBar(
      //     SnackBar(content: Text(response['data'])));

    }
setState(() {

});


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


      },
      child: Text(text,style: TextStyle(
          color: Color(0xFF000000),
          fontSize: screenUtil.setSp(16),
          fontWeight: FontWeight.w500
      ),),
    );
  }
  Widget buildItem(Items data, BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: itemWidth,
                  imageUrl:KImageUrl+data.image!,
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
                    data.date!.split(" ").first,
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
                    data.enTitle!:data.arTitle!,
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
}
