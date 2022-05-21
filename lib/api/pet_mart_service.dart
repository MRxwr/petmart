import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pet_mart/localization/localization_methods.dart';
import 'package:pet_mart/model/AddInterestModel.dart';
import 'package:pet_mart/model/AuctionBidModel.dart';
import 'package:pet_mart/model/BidNewModel.dart';
import 'package:pet_mart/model/DeletePostImageModel.dart';
import 'package:pet_mart/model/InitModel.dart';
import 'package:pet_mart/model/InterestModel.dart';
import 'package:pet_mart/model/MyNewAuctionDetailsModel.dart';
import 'package:pet_mart/model/PaymentUrlModel.dart';
import 'package:pet_mart/model/RatingAuctionModel.dart';
import 'package:pet_mart/model/ServiceDetailsModel.dart';
import 'package:pet_mart/model/ServicesModel.dart';
import 'package:pet_mart/model/ShopProductDetailsModel.dart';
import 'package:pet_mart/model/StopAuctionModel.dart';
import 'package:pet_mart/model/add_post_model.dart';
import 'package:pet_mart/model/auction_details_model.dart';
import 'package:pet_mart/model/auction_model.dart';
import 'package:pet_mart/model/bid_model.dart';
import 'package:pet_mart/model/category_model.dart';
import 'package:pet_mart/model/change_password_model.dart';
import 'package:pet_mart/model/check_credit_model.dart';
import 'package:pet_mart/model/cms_model.dart';
import 'package:pet_mart/model/credit_model.dart';
import 'package:pet_mart/model/delete_model.dart';
import 'package:pet_mart/model/home_model.dart';
import 'package:pet_mart/model/hospital_details_model.dart';
import 'package:pet_mart/model/hospital_model.dart';
import 'package:pet_mart/model/hospital_share_model.dart';
import 'package:pet_mart/model/hospitals_model.dart';

import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/message_model.dart';
import 'package:pet_mart/model/my_auction_details_model.dart';
import 'package:pet_mart/model/my_auctions_model.dart';
import 'package:pet_mart/model/my_message_model.dart';
import 'package:pet_mart/model/notification_model.dart';
import 'package:pet_mart/model/notify_model.dart';
import 'package:pet_mart/model/order_model.dart';
import 'package:pet_mart/model/otp_model.dart';
import 'package:pet_mart/model/package_model.dart';
import 'package:pet_mart/model/payment_model.dart';
import 'package:pet_mart/model/pets_model.dart';
import 'package:pet_mart/model/post_details_model.dart';
import 'package:pet_mart/model/post_model.dart';
import 'package:pet_mart/model/rating_model.dart';
import 'package:pet_mart/model/register_model.dart';
import 'package:pet_mart/model/reset_model.dart';
import 'package:pet_mart/model/search_model.dart';
import 'package:pet_mart/model/share_model.dart';
import 'package:pet_mart/model/shopdetails_model.dart';
import 'package:pet_mart/model/token_model.dart';
import 'package:pet_mart/model/update_profile_model.dart';
import 'package:pet_mart/model/user_model.dart';
import 'package:pet_mart/model/verify_otp_model.dart';
import 'package:pet_mart/model/view_model.dart';
import 'package:pet_mart/utilities/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/InitEditModel.dart';
import '../model/MyPostsModel.dart';
import '../model/SuccessModel.dart';

class PetMartService{
  static String TAG_BASE_URL= "https://createkwservers.com/petmart2/request/";

  Future<CmsModel> cms()async{
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";

    var response = await dio.post(
      TAG_BASE_URL + "?action=settings",
    );

    print(response);
    CmsModel cmsModel;
    if(response.statusCode == 200){
      cmsModel = CmsModel.fromJson(Map<String, dynamic>.from(response.data));
    }
    SharedPref sharedPref = SharedPref();



    print(response.data);
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
  Future<OtpModel> resentOtp(Map map) async {

    String body = json.encode(map);
    final response = await http.post(Uri.parse("${TAG_BASE_URL}customer/resentotp"),headers: {"Content-Type": "application/json"},body: body);
    print(response);
    OtpModel otpModel;
    if(response.statusCode == 200){
      otpModel = OtpModel.fromJson(jsonDecode(response.body));
    }

    print(response.body);
    print(response.body);
    return otpModel;
  }
  Future<dynamic> loginModel(Map map) async {

    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";


    FormData formData = FormData.fromMap(map);
    String body = json.encode(map);
    var response = await dio.post(
        TAG_BASE_URL + "?action=user&type=login&lang=${language}",
        data: formData);

    if (response.statusCode == 200) {
      resp =
          response.data;
      print(resp);
    }

    return resp;

  }
  Future<TokenModel> registerToken(Map map) async {

    String body = json.encode(map);
    final response = await http.post(Uri.parse("https://petmart.createkwservers.com/apis/guests/save"),headers: {"Content-Type": "application/json"},body: body);
    print('token response ${response.body}');
    TokenModel loginModel;
    if(response.statusCode == 200){
      loginModel = TokenModel.fromJson(jsonDecode(response.body));
    }

    print(loginModel.message);
    print(response.body);
    return loginModel;
  }
  Future<dynamic> register(Map map) async {
    try {
      var resp;
      var dio = Dio();
      dio.options.headers['content-Type'] = 'multipart/form-data';
      dio.options.headers['petmartcreate'] = "PetMartCreateCo";
      // dio.options.headers["ezyocreate"] = "CreateEZYo";
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      String language = sharedPreferences.getString(LANG_CODE) ?? "en";


      FormData formData = FormData.fromMap(map);
      String body = json.encode(map);
      var response = await dio.post(
          TAG_BASE_URL + "?action=user&type=register&lang=${language}",
          data: formData);

      if (response.statusCode == 200) {
        resp =
            response.data;
        print(resp);
      }

      return resp;
    }catch(e){
      print(e.toString());
      return null;
    }
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
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();




    String body = json.encode(map);
    var response = await dio.post(
        TAG_BASE_URL + "?action=home",
       );

     print(response);
    HomeModel homeModel;
    if(response.statusCode == 200){
      homeModel = HomeModel.fromJson(Map<String, dynamic>.from(response.data));
    }
    SharedPref sharedPref = SharedPref();
    await sharedPref.save("home", homeModel);


    print(response.data);
    return homeModel;
  }
  Future<ResetModel> resetPassword(String email )async{
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();





    var response = await dio.post(
      TAG_BASE_URL + "?action=user&type=forgetPassword&email=${email}",
    );

    print(response);
    ResetModel resetModel;
    if(response.statusCode == 200){
      resetModel = ResetModel.fromJson(Map<String, dynamic>.from(response.data));
    }



    print(response.data);
    return resetModel;


  }
  Future<InitModel> initModel( )async{
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();





    var response = await dio.post(
      TAG_BASE_URL + "?action=addPost&add=0",
    );

    print(response);
    InitModel resetModel;
    if(response.statusCode == 200){
      resetModel = InitModel.fromJson(Map<String, dynamic>.from(response.data));
    }



    print(response.data);
    return resetModel;


  }
  Future<InitEditModel> initEdit( String id)async{
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();




print(TAG_BASE_URL + "?action=editPost&edit=0&id=${id}");
    var response = await dio.post(
      TAG_BASE_URL + "?action=editPost&edit=0&id=${id}",
    );

    print(response);
    InitEditModel resetModel;
    if(response.statusCode == 200){
      resetModel = InitEditModel.fromJson(Map<String, dynamic>.from(response.data));
    }



    print(response.data);
    return resetModel;


  }
  Future<DeletePostImageModel> deleteImage( String id)async{
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();





    var response = await dio.post(
      TAG_BASE_URL + "?action=removeImage&remove=1&id=${id}",
    );

    print(response);
    DeletePostImageModel resetModel;
    if(response.statusCode == 200){
      resetModel = DeletePostImageModel.fromJson(Map<String, dynamic>.from(response.data));
    }



    print(response.data);
    return resetModel;


  }
  Future<PostModel> post(String action,String id) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";

    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();





    var response = await dio.post(
      TAG_BASE_URL + "?action=${action}&id=${id}",
    );

    print(response);

    PostModel postModel;
    if(response.statusCode == 200){
      postModel = PostModel.fromJson(Map<String, dynamic>.from(response.data));
    }




    print(response.data);

    return postModel;
  }
  Future<AuctionModel> auction(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}auction/auctionrunning"),headers: {"Content-Type": "application/json"},body: body);
    print('Running AuctionModel ---> ${response.body}');
    // Map  mapResponse = jsonDecode(response.body);
    // print('mapResponse --> ${mapResponse}');

    AuctionModel auctionModel;
    if(response.statusCode == 200){
      auctionModel = AuctionModel.fromJson(jsonDecode(response.body));
    }

    print(auctionModel.message);
    print(response.body);
    return auctionModel;
  }
  Future<AuctionDetailsModel> auctionDetails(Map map) async {
    print('map ---> ${map}');

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}auction/view"),headers: {"Content-Type": "application/json"},body: body);
    print(response.body);
    AuctionDetailsModel auctionDetailsModel;
    if(response.statusCode == 200){
      auctionDetailsModel = AuctionDetailsModel.fromJson(jsonDecode(response.body));
    }

    print(auctionDetailsModel.message);
    print('response.body ---> ${response.body}');
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
  Future<BidModel> translationModel(Map map) async {
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
  Future<CategoryModel> category(String catId) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";

    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();





    var response = await dio.post(
      TAG_BASE_URL + "?action=categories&id=${catId}",
    );

    print(response);

    CategoryModel categoryModel;
    if(response.statusCode == 200){
      categoryModel = CategoryModel.fromJson(Map<String, dynamic>.from(response.data));
    }


    return categoryModel;
  }
  Future<dynamic> search(String searchText) async {


    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";

    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();





    var response = await dio.post(
      TAG_BASE_URL + "?action=search&search=${searchText}",
    );

    print(response);
    dynamic resp;

    SearchModel searchModel;
    if(response.statusCode == 200){
      resp = response.data;

    }


    return resp;
  }
  Future<PetsModel> pets(String catId) async {

    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";

    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();





    var response = await dio.post(
      TAG_BASE_URL + "?action=categoryItems&id=${catId}",
    );

    print(response);

    PetsModel categoryModel;
    if(response.statusCode == 200){
      categoryModel = PetsModel.fromJson(Map<String, dynamic>.from(response.data));
    }


    return categoryModel;

  }
  Future<PostDetailsModel> petDetails(String petId) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";

    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();



print(TAG_BASE_URL + "?action=item&id=${petId}");

    var response = await dio.get(
      TAG_BASE_URL + "?action=item&id=${petId}",
    );



    PostDetailsModel postDetailsModel;
    if(response.statusCode == 200){
      postDetailsModel = PostDetailsModel.fromJson(Map<String, dynamic>.from(response.data));
    }

    return postDetailsModel;
  }
  Future<ShopProductDetailsModel> shopDetailsProduct(String petId) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";

    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();



    print(TAG_BASE_URL + "?action=shopItemDetails&id=${petId}");

    var response = await dio.get(
      TAG_BASE_URL + "?action=shopItemDetails&id=${petId}",
    );



    ShopProductDetailsModel postDetailsModel;
    if(response.statusCode == 200){
      postDetailsModel = ShopProductDetailsModel.fromJson(Map<String, dynamic>.from(response.data));
    }

    return postDetailsModel;
  }
  Future<PostDetailsModel> shopProductDetails(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}product/view"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    PostDetailsModel postDetailsModel;
    if(response.statusCode == 200){
      postDetailsModel = PostDetailsModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
    return postDetailsModel;
  }
  Future<ShareModel> viewPet(String update,String type,String id) async {
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";

    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();





    var response = await dio.get(
      TAG_BASE_URL + "action=shareView&update=${update}&type=${type}&id=${id}",
    );

    print(response);

    ShareModel shareModel;
    if(response.statusCode == 200){
      shareModel = ShareModel.fromJson(Map<String, dynamic>.from(response.data));
    }




    print(response.data);

    return shareModel;
  }

  Future<ShareModel> sharePet(String update,String type,String id) async {

    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";

    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();



print(TAG_BASE_URL + "?action=shareView&update=${update}&type=${type}&id=${id}");
    ShareModel shareModel;
    try {
      var response = await dio.get(
        TAG_BASE_URL +
            "?action=shareView&update=${update}&type=${type}&id=${id}",
      );

      print(response);


      if (response.statusCode == 200) {
        shareModel =
            ShareModel.fromJson(Map<String, dynamic>.from(response.data));
      }
    }on Exception catch (_) {
     shareModel = null;
    }




    return shareModel;;
  }
  Future<MessageModel> getMessages(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}message/detail"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    MessageModel postDetailsModel;
    print(response.statusCode);
    if(response.statusCode == 200){
      postDetailsModel = MessageModel.fromJson(jsonDecode(response.body));
    }

    print(postDetailsModel.message);
    print(response.body);
    return postDetailsModel;

  }
  Future<MessageModel> postMessages(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}message/sendmessage"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    MessageModel postDetailsModel;
    if(response.statusCode == 200){
      postDetailsModel = MessageModel.fromJson(jsonDecode(response.body));
    }

    print(postDetailsModel.message);
    print(response.body);
    return postDetailsModel;

  }
  Future<UserModel> user(Map map)async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";


    FormData formData = FormData.fromMap(map);
    String body = json.encode(map);
    var response = await dio.post(
        TAG_BASE_URL + "?action=user&type=profile&update=0",
        data: formData);
    UserModel userModel;
    if (response.statusCode == 200) {
      userModel = UserModel.fromJson(Map<String, dynamic>.from(response.data));
      print(resp);
    }
    return userModel;

  }
  Future<CreditModel> credit(Map map)async{
    print('credit ---> ${map}');

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}credit/credit"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    CreditModel creditModel;
    try{
      if(response.statusCode == 200){
        creditModel = CreditModel.fromJson(jsonDecode(response.body));
      }
    }catch(e){
      creditModel = null;
    }




    print(response.body);
    return creditModel;

  }
  Future<PackageModel> package()async{
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";

    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();



    print(TAG_BASE_URL + "?action=packages&buy=0");
    PackageModel packageModel;
    try {
      var response = await dio.get(
        TAG_BASE_URL +
            "?action=packages&buy=0",
      );

      print(response);


      if (response.statusCode == 200) {
        packageModel =
            PackageModel.fromJson(Map<String, dynamic>.from(response.data));
      }
    }on Exception catch (_) {
      packageModel = null;
    }




    return packageModel;;

  }
  Future<InterestModel> interests(String id)async{
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";

    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();



    print(TAG_BASE_URL + "?action=interest&type=get");
    InterestModel packageModel;
    try {
      Map<String,String> map = Map();
      map['customerId']= id;


      print("userID---> ${id}");
      FormData formData = FormData.fromMap(map);
      var response = await dio.post(
          TAG_BASE_URL + "?action=interest&type=get",
          data: formData
      );


      print(response);


      if (response.statusCode == 200) {
        packageModel =
            InterestModel.fromJson(Map<String, dynamic>.from(response.data));
      }
    }on Exception catch (_) {
      packageModel = null;
    }




    return packageModel;;

  }
  Future<PaymentUrlModel> paymentUrl(Map<String,String> map)async{
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";

    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();


    print(map);

    print(TAG_BASE_URL + "?action=packages&buy=1");
    PaymentUrlModel packageModel;
    FormData formData = FormData.fromMap(map);

    try {
      var response = await dio.post(
        TAG_BASE_URL +
            "?action=packages&buy=1",
          data: formData
      );

      print(response);


      if (response.statusCode == 200) {
        packageModel =
            PaymentUrlModel.fromJson(Map<String, dynamic>.from(response.data));
      }
    }on Exception catch (_) {
      packageModel = null;
    }




    return packageModel;;

  }
  Future<AddInterestModel> addInterest(Map<String,String> map)async{
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";

    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();


    print(map);


    AddInterestModel packageModel;
    FormData formData = FormData.fromMap(map);

    try {
      var response = await dio.post(
          TAG_BASE_URL +
              "?action=interest&type=add",
          data: formData
      );

      print(response.data);


      if (response.statusCode == 200) {
        packageModel =
            AddInterestModel.fromJson(Map<String, dynamic>.from(response.data));
      }
    }on Exception catch (_) {
      packageModel = null;
    }




    return packageModel;;

  }

  Future<PaymentModel> payment(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}packages/order"),headers: {"Content-Type": "application/json"},body: body);
    print(' response ${response}');
    PaymentModel paymentModel;
    if(response.statusCode == 200){
      paymentModel = PaymentModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
    return paymentModel;

  }
  Future<ChangePasswordModel> changePassword(Map map)async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";


    FormData formData = FormData.fromMap(map);
    String body = json.encode(map);
    var response = await dio.post(
        TAG_BASE_URL + "?action=user&type=changePassword",
        data: formData);
ChangePasswordModel changePasswordModel;
    if (response.statusCode == 200) {
      changePasswordModel = ChangePasswordModel.fromJson(Map<String, dynamic>.from(response.data));
      print(resp);
    }
    return changePasswordModel;

  }
  Future<OrderModel> orders(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}credit/credit"),headers: {"Content-Type": "application/json"},body: body);
    print(' response ${response.body}');
    OrderModel changePasswordModel;
    if(response.statusCode == 200){
      changePasswordModel = OrderModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
    return changePasswordModel;

  }
  Future<dynamic> myPosts(String id)async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";


print("userID---> ${id}");
    var response = await dio.get(
        TAG_BASE_URL + "?action=myPosts&id=${id}",
        );
    print(response.data);
    MyPostsModel postModel;
    if (response.statusCode == 200) {
      resp =
          response.data;
    }
    return resp;

  }
  Future<dynamic> myNewAuctions(String id)async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";
    Map<String,String> map = Map();
    map['customerId']= id;


    print("userID---> ${id}");
    FormData formData = FormData.fromMap(map);
    var response = await dio.post(
      TAG_BASE_URL + "?action=auctions&type=my",
      data: formData
    );
    print(response.data);
    MyPostsModel postModel;
    if (response.statusCode == 200) {
      resp =
          response.data;
    }
    return resp;

  }
  Future<StopAuctionModel> stopAuction(Map<String,String> map)async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";


    FormData formData = FormData.fromMap(map);
    String body = json.encode(map);
    var response = await dio.post(
        TAG_BASE_URL + "?action=auctions&type=stop",
        data: formData);
    StopAuctionModel changePasswordModel;
    if (response.statusCode == 200) {
      changePasswordModel = StopAuctionModel.fromJson(Map<String, dynamic>.from(response.data));
      print(resp);
    }
    return changePasswordModel;

  }
  Future<BidNewModel> bid(Map<String,String> map)async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";


    FormData formData = FormData.fromMap(map);
    String body = json.encode(map);
    var response = await dio.post(
        TAG_BASE_URL + "?action=auctions&type=submitBid",
        data: formData);
    BidNewModel changePasswordModel;
    if (response.statusCode == 200) {
      changePasswordModel = BidNewModel.fromJson(Map<String, dynamic>.from(response.data));
      print(resp);
    }
    return changePasswordModel;

  }

  Future<MyNewAuctionDetailsModel> myNewAuctionDetails(Map<String,String> map)async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";


    FormData formData = FormData.fromMap(map);
    String body = json.encode(map);
    var response = await dio.post(
        TAG_BASE_URL + "?action=auctions&type=details",
        data: formData);
    MyNewAuctionDetailsModel changePasswordModel;
    if (response.statusCode == 200) {
      changePasswordModel = MyNewAuctionDetailsModel.fromJson(Map<String, dynamic>.from(response.data));
      print(resp);
    }
    return changePasswordModel;

  }
  Future<AuctionBidModel> auctionBidDetails(Map<String,String> map)async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";


    FormData formData = FormData.fromMap(map);
    String body = json.encode(map);
    var response = await dio.post(
        TAG_BASE_URL + "?action=rating&type=get",
        data: formData);
    AuctionBidModel changePasswordModel;
    if (response.statusCode == 200) {
      changePasswordModel = AuctionBidModel.fromJson(Map<String, dynamic>.from(response.data));
      print(resp);
    }
    return changePasswordModel;

  }
  Future<RatingAuctionModel> ratingAuction(Map<String,String> map)async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";


    FormData formData = FormData.fromMap(map);
    String body = json.encode(map);
    var response = await dio.post(
        TAG_BASE_URL + "?action=rating&type=send",
        data: formData);
    RatingAuctionModel changePasswordModel;
    if (response.statusCode == 200) {
      changePasswordModel = RatingAuctionModel.fromJson(Map<String, dynamic>.from(response.data));
      print(resp);
    }
    return changePasswordModel;

  }
  Future<dynamic> NewAuctionList(String id,String filterId)async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";

    Map<String,String> map = Map();
    map['customerId']= id;
    map['filterId']= filterId;

    print("userID---> ${id}");
    FormData formData = FormData.fromMap(map);

    var response = await dio.post(
        TAG_BASE_URL + "?action=auctions&type=list",
        data: formData
    );
    print(response.data);
    MyPostsModel postModel;
    if (response.statusCode == 200) {
      resp =
          response.data;
    }
    return resp;

  }
  Future<DeleteModel> deleteModel(String postId)async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";


    print("userID---> ${postId}");
    var response = await dio.get(
      TAG_BASE_URL + "?action=removePost&remove=1&id=${postId}",
    );
    print(response.data);
    DeleteModel deleteModel;
    if (response.statusCode == 200) {
      deleteModel = DeleteModel.fromJson(Map<String, dynamic>.from(response.data));
    }
    return deleteModel;

  }
  Future<SuccessModel> successPayment(String orderId)async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";



    var response = await dio.get(
      TAG_BASE_URL + "?action=success&orderId=${orderId}",
    );
    print(response.data);
    SuccessModel deleteModel;
    if (response.statusCode == 200) {
      deleteModel = SuccessModel.fromJson(Map<String, dynamic>.from(response.data));
    }
    return deleteModel;

  }
  Future<DeleteModel> deleteAuction(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}auction/delete"),headers: {"Content-Type": "application/json"},body: body);
    print(' response ${response}');
    DeleteModel deleteModel;
    if(response.statusCode == 200){
      deleteModel = DeleteModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
    return deleteModel;

  }
  Future<MyAuctionsModel> myAuctions(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}auction/fetch"),headers: {"Content-Type": "application/json"},body: body);
    print(' response ${response}');
    MyAuctionsModel auctionModel ;
    print(' my Auctions ${response.body}');
    try{
      if(response.statusCode == 200){
        auctionModel = MyAuctionsModel.fromJson(jsonDecode(response.body));
        print(' my Auctions ${response.body}');
      }
    }catch(e){
      auctionModel = null;
      print('auctionModel ${auctionModel}');
    }




    return auctionModel;

  }
  Future<MyAuctionDetailsModel> myAuctionDetails(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}auction/view"),headers: {"Content-Type": "application/json"},body: body);
    print(' response ${response}');
    MyAuctionDetailsModel auctionModel;
    if(response.statusCode == 200){
      auctionModel = MyAuctionDetailsModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
    return auctionModel;

  }
  Future<MyMessageModel> myMessages(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}message/list"),headers: {"Content-Type": "application/json"},body: body);
    print(' response ${response}');
    MyMessageModel auctionModel;

    if(response.statusCode == 200){
      auctionModel = MyMessageModel.fromJson(jsonDecode(response.body));
      print(auctionModel.status);
    }


    print(response.body);
    return auctionModel;

  }
  Future<CheckCreditModel> checkCredit(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}credit/check"),headers: {"Content-Type": "application/json"},body: body);
    print(' response ${response}');
    CheckCreditModel checkCreditModel;
    if(response.statusCode == 200){
      checkCreditModel = CheckCreditModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
    return checkCreditModel;

  }
  Future<HospitalModel> hospitals()async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";



    var response = await dio.post(
        TAG_BASE_URL + "?action=shops",
        );
    HospitalModel hospitalModel;
    if (response.statusCode == 200) {
      hospitalModel = HospitalModel.fromJson(Map<String, dynamic>.from(response.data));
      print(resp);
    }
    return hospitalModel;

  }
  Future<ServicesModel> services()async{
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";



    var response = await dio.post(
      TAG_BASE_URL + "?action=services",
    );
    ServicesModel servicesModel;
    if (response.statusCode == 200) {
      servicesModel = ServicesModel.fromJson(Map<String, dynamic>.from(response.data));
      print(resp);
    }
    return servicesModel;

  }

  Future<HospitalsModel> hospital()async{


    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";


    var response = await dio.post(
      TAG_BASE_URL + "?action=hospitals",
    );



    print(' response ${response}');
    HospitalsModel hospitalModel;
    if(response.statusCode == 200){
      hospitalModel = HospitalsModel.fromJson(Map<String, dynamic>.from(response.data));
    }



    return hospitalModel;

  }
  Future<HospitalDetailsModel> hospitalDetails(String id)async{

    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();





    var response = await dio.post(
      TAG_BASE_URL + "?action=hospitalsDetails&id=${id}",
    );

    print(response);
    HospitalDetailsModel hospitalModel;
    if(response.statusCode == 200){
      hospitalModel = HospitalDetailsModel.fromJson(Map<String, dynamic>.from(response.data));
    }



    return hospitalModel;

  }
  Future<ServiceDetailsModel> serviceDetails(String id)async{

    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();





    var response = await dio.post(
      TAG_BASE_URL + "?action=serviceDetails&id=${id}",
    );

    print(response);
    ServiceDetailsModel hospitalModel;
    if(response.statusCode == 200){
      hospitalModel = ServiceDetailsModel.fromJson(Map<String, dynamic>.from(response.data));
    }



    return hospitalModel;

  }
  Future<HospitalShareModel> hospitalShare(String id)async{




    final response = await http.post(Uri.parse("${TAG_BASE_URL}hospitals/shared?id=${id}"),headers: {"Content-Type": "application/json"});
    print(' response ${response}');
    HospitalShareModel hospitalModel;
    if(response.statusCode == 200){
      hospitalModel = HospitalShareModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
    return hospitalModel;

  }
  Future<ShopdetailsModel> shopDetails(String id) async {

    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();





    var response = await dio.post(
      TAG_BASE_URL + "?action=shopDetails&id=${id}",
    );

    print(response.data);
    ShopdetailsModel shopdetailsModel;
    if(response.statusCode == 200){
      shopdetailsModel = ShopdetailsModel.fromJson(Map<String, dynamic>.from(response.data));
    }



    return shopdetailsModel;

  }
  Future<UserModel> updateProfile(String userId,String fullName,String email,String phone,String path)async{
    var resp;
    Dio dio;
    BaseOptions options = new BaseOptions(
        baseUrl: TAG_BASE_URL,
        receiveDataWhenStatusError: true,
        connectTimeout: 600*1000, // 60 seconds
        receiveTimeout: 600*1000 // 60 seconds
    );

    dio = new Dio(options);
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    String language = sharedPreferences.getString(LANG_CODE) ?? "en";
    Map<String, dynamic> map = Map();
if(path == null){


  map['id']=userId;
  map['name']= fullName;
  map['email']=email;
  map['mobile']=phone;


}else{
  map['id']=userId;
  map['name']= fullName;
  map['email']=email;
  map['mobile']=phone;



  String childFileName = path
      .split('/')
      .last;
  print ('childFileName ${childFileName}');
  map['image']=  await MultipartFile.fromFile(path, filename: childFileName);
}

    FormData formData = FormData.fromMap(map);

    var response = await dio.post(
        "?action=user&type=profile&update=1",
        data: formData);
    UserModel userModel;
    if (response.statusCode == 200) {
      userModel = UserModel.fromJson(Map<String, dynamic>.from(response.data));
      print(resp);
    }
    return userModel;


  }
  Future<dynamic> addVedio(File vedio) async{
    dynamic resp;
    var dio ;
    try {
    BaseOptions options = new BaseOptions(
        baseUrl: TAG_BASE_URL,
        receiveDataWhenStatusError: true,
        connectTimeout: 600*1000, // 60 seconds
        receiveTimeout: 600*1000 // 60 seconds
    );

    dio = new Dio(options);
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    Map<String, dynamic> map = Map();



        print('path --> ${vedio.absolute.path}');

        String childFileName = vedio.absolute.path
            .split('/')
            .last;
        print ('childFileName ${childFileName}');
        map['video']=  await MultipartFile.fromFile(vedio.path, filename: childFileName);
    FormData formData = new FormData.fromMap(map);
    final  response = await dio.post("?action=uploadVideo", data: formData);

    if (response.statusCode == 200) {
      resp = response.data;
      print(resp);
    }

  } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      resp = e.response.data;
      print(resp);
    }
  return resp;


  }
  Future<dynamic> addPost(String english_name,String arabic_name,String post_type,String english_description,String arabic_description, String price,String category_id, String age,String age_id,
      String gender, String owner_id, String sub_category_id,
      String contact_no,String mLanguage,List<File> images ,File vedio,String vedioUrl)async{
    SharedPref sharedPref = SharedPref();




    AddPostModel addPostModel;
    dynamic resp;
    try {
      var dio ;
      BaseOptions options = new BaseOptions(
          baseUrl: TAG_BASE_URL,
          receiveDataWhenStatusError: true,
          connectTimeout: 600*1000, // 60 seconds
          receiveTimeout: 600*1000 // 60 seconds
      );

      dio = new Dio(options);
      dio.options.headers['content-Type'] = 'multipart/form-data';
      dio.options.headers['petmartcreate'] = "PetMartCreateCo";



      Map<String, dynamic> map = Map();

      map['enTitle'] = english_name;
      map['arTitle'] = arabic_name;

      map['enDetails'] = english_description;
      map['arDetails'] = arabic_description;
      map['price'] = price;

      map['age'] = age;
      map['ageType'] = age_id;
      map['gender'] = gender;
      map['customerId'] = owner_id;

      map['categoryId'] = category_id;
      map['video'] = vedioUrl;



      for(int i =0;i<images.length;i++){
        String path = images[i].absolute.path;
        print('path --> ${images[i].absolute.path}');

        String childFileName = path
            .split('/')
            .last;
        print ('childFileName ${childFileName}');
        map['image[${i}]']=  await MultipartFile.fromFile(path, filename: childFileName);
      }

      print(map);
  // File vedioFile =  File.fromRawPath(Uint8List.fromList([0]));
  //         String childFileName = vedioFile.path
  //             .split('/')
  //         .last;
      // map['videos[0]'] = await MultipartFile.fromFile(vedioFile.path, filename: childFileName);
      FormData formData = new FormData.fromMap(map);
      final  response = await dio.post("?action=addPost&add=1", data: formData);

      if (response.statusCode == 200) {
        resp = response.data;
        print(resp);
      }

    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      resp =e.response.data;
      print(resp);



    }
    return resp;


  }
  Future<dynamic> addAuction(String english_name,String arabic_name,String english_description,String arabic_description, String start_date,String end_date, String bid_value,String auction_type,
      String category_id, String owner_id, String sub_category_id,
     String mLanguage,List<File> images ,List<File> vedio,String vedioUrl)async{
    SharedPref sharedPref = SharedPref();




    AddPostModel addPostModel;
    dynamic resp;
    try {
      var dio ;


      BaseOptions options = new BaseOptions(
          baseUrl: TAG_BASE_URL,
          receiveDataWhenStatusError: true,
          connectTimeout: 600*1000, // 60 seconds
          receiveTimeout: 600*1000 // 60 seconds
      );

      dio = new Dio(options);
      dio.options.contentType = 'application/json';
      Map<String, dynamic> map = Map();

      map['title'] = english_name;

      map['filterId'] = category_id;
      map['details'] = english_description;


      map['endDate'] = end_date;

      map['price'] = bid_value;


      map['customerId'] = owner_id;


      map['video'] = vedioUrl;
      for(int i =0;i<images.length;i++){
        print('path --> ${images[i].absolute.path}');

        String childFileName = images[i].absolute.path
            .split('/')
            .last;
        print ('childFileName ${childFileName}');
        map['image[${i}]']=  await MultipartFile.fromFile(images[i].absolute.path, filename: childFileName);
      }
      if(vedio.isNotEmpty){
        for(int i =0;i<vedio.length;i++){
          print('path --> ${vedio[i].absolute.path}');

          String childFileName = vedio[i].absolute.path
              .split('/')
              .last;
          print ('childFileName ${childFileName}');
          map['videos[${i}]']=  await MultipartFile.fromFile(vedio[i].path, filename: childFileName);
        }
      }

      print('map --> ${map}');
         FormData formData = new FormData.fromMap(map);
      final  response = await dio.post("?action=auctions&type=add", data: formData);

      if (response.statusCode == 200) {
        resp = response.data;
        print(resp);
      }

    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      resp =e.response.data;
      print(resp);



    }
    return resp;


  }
  Future<dynamic> editPost(String id,String english_name,String arabic_name,String post_type,String english_description,String arabic_description, String price,String category_id, String age,String age_id,
      String gender, String owner_id, String sub_category_id,
      String contact_no,String mLanguage,List<File> images ,File vedio,String vedioUrl)async{
    SharedPref sharedPref = SharedPref();









    AddPostModel addPostModel;
    dynamic resp;
    try {
      var dio ;
      BaseOptions options = new BaseOptions(
          baseUrl: TAG_BASE_URL,
          receiveDataWhenStatusError: true,
          connectTimeout: 600*1000, // 60 seconds
          receiveTimeout: 600*1000 // 60 seconds
      );

      dio = new Dio(options);
      dio.options.headers['content-Type'] = 'multipart/form-data';
      dio.options.headers['petmartcreate'] = "PetMartCreateCo";



      Map<String, dynamic> map = Map();

      map['enTitle'] = english_name;
      map['arTitle'] = arabic_name;

      map['enDetails'] = english_description;
      map['arDetails'] = arabic_description;
      map['price'] = price;

      map['age'] = age;
      map['ageType'] = age_id;
      map['gender'] = gender;
      map['customerId'] = owner_id;
      map['categoryId'] = category_id;
      map['video'] = vedioUrl;
      print(map);


      for(int i =0;i<images.length;i++){
        String path = images[i].absolute.path;
        print('path --> ${images[i].absolute.path}');

        String childFileName = path
            .split('/')
            .last;
        print ('childFileName ${childFileName}');
        map['image[${i}]']=  await MultipartFile.fromFile(path, filename: childFileName);
      }
      // File vedioFile =  File.fromRawPath(Uint8List.fromList([0]));
      //         String childFileName = vedioFile.path
      //             .split('/')
      //         .last;
      // map['videos[0]'] = await MultipartFile.fromFile(vedioFile.path, filename: childFileName);
      FormData formData = new FormData.fromMap(map);
      final  response = await dio.post("?action=editPost&edit=1&id=${id}", data: formData);

      if (response.statusCode == 200) {
        resp = response.data;
        print(resp);
      }

    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      resp =e.response.data;
      print(resp);



    }
    return resp;


  }
  Future<dynamic> notification(String id) async {
    var resp;
    var dio = Dio();
    dio.options.headers['content-Type'] = 'multipart/form-data';
    dio.options.headers['petmartcreate'] = "PetMartCreateCo";
    // dio.options.headers["ezyocreate"] = "CreateEZYo";
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();





    var response = await dio.get(
      TAG_BASE_URL + "?action=notifications&id=${id}",
    );

    print(response);
    NotificationModel notificationModel;
    if(response.statusCode == 200){
      resp = response.data;
    }



    return resp;
  }

  Future<RatingModel> rating(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}auction/rating"),headers: {"Content-Type": "application/json"},body: body);
    print(response.body);
    RatingModel ratingModel;
    if(response.statusCode == 200){
      ratingModel = RatingModel.fromJson(jsonDecode(response.body));
    }

    print(ratingModel.message);
    print(response.body);
    return ratingModel;
  }
}