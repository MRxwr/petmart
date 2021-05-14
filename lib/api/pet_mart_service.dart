import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/auction_details_model.dart';
import 'package:pet_mart/model/auction_model.dart';
import 'package:pet_mart/model/bid_model.dart';
import 'package:pet_mart/model/category_model.dart';
import 'package:pet_mart/model/cms_model.dart';
import 'package:pet_mart/model/home_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/pets_model.dart';
import 'package:pet_mart/model/post_details_model.dart';
import 'package:pet_mart/model/post_model.dart';
import 'package:pet_mart/model/register_model.dart';
import 'package:pet_mart/model/reset_model.dart';
import 'package:pet_mart/model/verify_otp_model.dart';
import 'package:pet_mart/utilities/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PetMartService{
  static String TAG_BASE_URL= "https://petmart.createkwservers.com/apis/";

  Future<CmsModel> cms(String type)async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    CmsModel cmsModel;

    var dio = Dio();


    var response = await dio.get(TAG_BASE_URL + "cms/view?url_key=${type}&language=${languageCode}");

    if (response.statusCode == 200) {




      cmsModel =
          CmsModel.fromJson(Map<String, dynamic>.from(response.data));
    }

    return cmsModel;


  }
  Future<String> resendOtp(String url)async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    String  resp;

    var dio = Dio();


    var response = await dio.get(url);

    if (response.statusCode == 200) {
      print(response.data);




      resp =
         response.data;
    }

    return resp;


  }
  Future<LoginModel> loginModel(Map map) async {

    String body = json.encode(map);
    final response = await http.post(Uri.parse("${TAG_BASE_URL}customer/login"),headers: {"Content-Type": "application/json"},body: body);
    print(response);
    LoginModel loginModel;
    if(response.statusCode == 200){
      loginModel = LoginModel.fromJson(jsonDecode(response.body));
    }

    print(loginModel.message);
    print(response.body);
    return loginModel;
  }
  Future<RegisterModel> register(Map map) async {

    String body = json.encode(map);
    final response = await http.post(Uri.parse("${TAG_BASE_URL}customer/register"),headers: {"Content-Type": "application/json"},body: body);
    print(response);
    RegisterModel registerModel;
    if(response.statusCode == 200){
      registerModel = RegisterModel.fromJson(jsonDecode(response.body));
    }

    print(registerModel.message);
    print(response.body);
    return registerModel;
  }
  Future<VerifyOtpModel> verifyOtp(Map map) async {

    String body = json.encode(map);
    final response = await http.post(Uri.parse("${TAG_BASE_URL}customer/verify"),headers: {"Content-Type": "application/json"},body: body);
    print(response);
    VerifyOtpModel verifyOtpModel;
    if(response.statusCode == 200){
      verifyOtpModel = VerifyOtpModel.fromJson(jsonDecode(response.body));
    }

    print(verifyOtpModel.message);
    print(response.body);
    return verifyOtpModel;
  }
  Future<HomeModel> home(Map map) async {

    String body = json.encode(map);
    final response = await http.post(Uri.parse("${TAG_BASE_URL}home/index"),headers: {"Content-Type": "application/json"},body: body);
    print(response);
    HomeModel homeModel;
    if(response.statusCode == 200){
      homeModel = HomeModel.fromJson(jsonDecode(response.body));
    }
    SharedPref sharedPref = SharedPref();
    await sharedPref.save("home", homeModel);

    print(homeModel.message);
    print(response.body);
    return homeModel;
  }
  Future<ResetModel> resetPassword(String email )async{
    Map<String, dynamic> map = {
     'email':email
   };
    var dio = null;
    ResetModel resetModel;

    FormData formData = new FormData.fromMap(map);
    print(formData.fields);

    try {
      BaseOptions options = new BaseOptions(
          baseUrl: TAG_BASE_URL,
          receiveDataWhenStatusError: true,
          connectTimeout: 60*1000, // 60 seconds
          receiveTimeout: 60*1000 // 60 seconds
      );

      dio = new Dio(options);
      var response = await dio.post("customer/resetpassword",
          options: Options(contentType: 'multipart/form-data',
              receiveDataWhenStatusError: true,


              receiveTimeout: 60*1000 // 6

          ),

          data: formData);
      print(response.data);

      if (response.statusCode == 200) {
        resetModel =  ResetModel.fromJson(Map<String, dynamic>.from(response.data));
      }
    }on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.




    }
    return resetModel;


  }
  Future<PostModel> post(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}post/list"),headers: {"Content-Type": "application/json"},body: body);
    print(response);
    PostModel postModel;
    if(response.statusCode == 200){
      postModel = PostModel.fromJson(jsonDecode(response.body));
    }

    print(postModel.message);
    print(response.body);
    return postModel;
  }
  Future<AuctionModel> auction(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}auction/auctionrunning"),headers: {"Content-Type": "application/json"},body: body);
    print(response);
    AuctionModel auctionModel;
    if(response.statusCode == 200){
      auctionModel = AuctionModel.fromJson(jsonDecode(response.body));
    }

    print(auctionModel.message);
    print(response.body);
    return auctionModel;
  }
  Future<AuctionDetailsModel> auctionDetails(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}auction/view"),headers: {"Content-Type": "application/json"},body: body);
    print(response);
    AuctionDetailsModel auctionDetailsModel;
    if(response.statusCode == 200){
      auctionDetailsModel = AuctionDetailsModel.fromJson(jsonDecode(response.body));
    }

    print(auctionDetailsModel.message);
    print(response.body);
    return auctionDetailsModel;
  }
  Future<BidModel> postAuctionModel(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}auction/submitbid"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    BidModel postModel;
    if(response.statusCode == 200){
      postModel = BidModel.fromJson(jsonDecode(response.body));
    }

    print(postModel.message);
    print(response.body);
    return postModel;
  }
  Future<CategoryModel> category(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}category/list"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    CategoryModel categoryModel;
    if(response.statusCode == 200){
      categoryModel = CategoryModel.fromJson(jsonDecode(response.body));
    }

    print(categoryModel.message);
    print(response.body);
    return categoryModel;
  }
  Future<PetsModel> pets(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}post/list"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    PetsModel petsModel;
    if(response.statusCode == 200){
      petsModel = PetsModel.fromJson(jsonDecode(response.body));
    }

    print(petsModel.message);
    print(response.body);
    return petsModel;
  }
  Future<PostDetailsModel> petDetails(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}post/view"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    PostDetailsModel postDetailsModel;
    if(response.statusCode == 200){
      postDetailsModel = PostDetailsModel.fromJson(jsonDecode(response.body));
    }

    print(postDetailsModel.message);
    print(response.body);
    return postDetailsModel;
  }
}