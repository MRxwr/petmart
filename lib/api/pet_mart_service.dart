import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:dio/dio.dart';
import 'package:pet_mart/localization/localization_methods.dart';
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
import 'package:pet_mart/model/init_model.dart';
import 'package:pet_mart/model/login_model.dart';
import 'package:pet_mart/model/message_model.dart';
import 'package:pet_mart/model/my_auction_details_model.dart';
import 'package:pet_mart/model/my_auctions_model.dart';
import 'package:pet_mart/model/my_message_model.dart';
import 'package:pet_mart/model/notification_model.dart';
import 'package:pet_mart/model/notify_model.dart';
import 'package:pet_mart/model/order_model.dart';
import 'package:pet_mart/model/package_model.dart';
import 'package:pet_mart/model/payment_model.dart';
import 'package:pet_mart/model/pets_model.dart';
import 'package:pet_mart/model/post_details_model.dart';
import 'package:pet_mart/model/post_model.dart';
import 'package:pet_mart/model/register_model.dart';
import 'package:pet_mart/model/reset_model.dart';
import 'package:pet_mart/model/search_model.dart';
import 'package:pet_mart/model/share_model.dart';
import 'package:pet_mart/model/shopdetails_model.dart';
import 'package:pet_mart/model/update_profile_model.dart';
import 'package:pet_mart/model/user_model.dart';
import 'package:pet_mart/model/verify_otp_model.dart';
import 'package:pet_mart/model/view_model.dart';
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
  Future<InitModel> init()async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String languageCode = _preferences.getString(LANG_CODE) ?? ENGLISH;

    InitModel initModel;

    var dio = Dio();


    var response = await dio.get(TAG_BASE_URL + "initialization/index");

    if (response.statusCode == 200) {




      initModel =
          InitModel.fromJson(Map<String, dynamic>.from(response.data));
    }

    return initModel;


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
  Future<SearchModel> search(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}post/list"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    SearchModel categoryModel;
    if(response.statusCode == 200){
      categoryModel = SearchModel.fromJson(jsonDecode(response.body));
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
  Future<ViewModel> viewPet(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}post/postviewcount"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    ViewModel postDetailsModel;
    if(response.statusCode == 200){
      postDetailsModel = ViewModel.fromJson(jsonDecode(response.body));
    }

    print(postDetailsModel.message);
    print(response.body);
    return postDetailsModel;
  }
  Future<ShareModel> sharePet(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}post/sharecount"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    ShareModel postDetailsModel;
    if(response.statusCode == 200){
      postDetailsModel = ShareModel.fromJson(jsonDecode(response.body));
    }

    print(postDetailsModel.message);
    print(response.body);
    return postDetailsModel;
  }
  Future<MessageModel> getMessages(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}message/detail"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    MessageModel postDetailsModel;
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
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}customer/fetch"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    UserModel userModel;
    if(response.statusCode == 200){
      userModel = UserModel.fromJson(jsonDecode(response.body));
    }

    print(userModel.message);
    print(response.body);
    return userModel;

  }
  Future<CreditModel> credit(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}credit/credit"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    CreditModel creditModel;
    if(response.statusCode == 200){
      creditModel = CreditModel.fromJson(jsonDecode(response.body));
    }

    print(creditModel.message);
    print(response.body);
    return creditModel;

  }
  Future<PackageModel> package(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}packages/list"),headers: {"Content-Type": "application/json"},body: body);
    print(' response ${response}');
    PackageModel packageModel;
    if(response.statusCode == 200){
      packageModel = PackageModel.fromJson(jsonDecode(response.body));
    }

    print(packageModel.message);
    print(response.body);
    return packageModel;

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
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}customer/changepassword"),headers: {"Content-Type": "application/json"},body: body);
    print(' response ${response}');
    ChangePasswordModel changePasswordModel;
    if(response.statusCode == 200){
      changePasswordModel = ChangePasswordModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
    return changePasswordModel;

  }
  Future<OrderModel> orders(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}credit/credit"),headers: {"Content-Type": "application/json"},body: body);
    print(' response ${response}');
    OrderModel changePasswordModel;
    if(response.statusCode == 200){
      changePasswordModel = OrderModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
    return changePasswordModel;

  }
  Future<PostModel> myPosts(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}post/mypost"),headers: {"Content-Type": "application/json"},body: body);
    print(' response ${response}');
    PostModel changePasswordModel;
    if(response.statusCode == 200){
      changePasswordModel = PostModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
    return changePasswordModel;

  }
  Future<DeleteModel> deleteModel(Map map)async{
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}post/delete"),headers: {"Content-Type": "application/json"},body: body);
    print(' response ${response}');
    DeleteModel deleteModel;
    if(response.statusCode == 200){
      deleteModel = DeleteModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
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
    MyAuctionsModel auctionModel;
    if(response.statusCode == 200){
      auctionModel = MyAuctionsModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
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




    final response = await http.post(Uri.parse("${TAG_BASE_URL}shop/list"),headers: {"Content-Type": "application/json"});
    print(' response ${response}');
    HospitalModel hospitalModel;
    if(response.statusCode == 200){
      hospitalModel = HospitalModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
    return hospitalModel;

  }
  Future<HospitalsModel> hospital()async{




    final response = await http.post(Uri.parse("${TAG_BASE_URL}hospitals/list"),headers: {"Content-Type": "application/json"});
    print(' response ${response}');
    HospitalsModel hospitalModel;
    if(response.statusCode == 200){
      hospitalModel = HospitalsModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
    return hospitalModel;

  }
  Future<HospitalDetailsModel> hospitalDetails(String id)async{




    final response = await http.post(Uri.parse("${TAG_BASE_URL}hospitals/details?id=${id}"),headers: {"Content-Type": "application/json"});
    print(' response ${response}');
    HospitalDetailsModel hospitalModel;
    if(response.statusCode == 200){
      hospitalModel = HospitalDetailsModel.fromJson(jsonDecode(response.body));
    }


    print(response.body);
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
  Future<ShopdetailsModel> shopDetails(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}shop/detail"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    ShopdetailsModel shopdetailsModel;
    if(response.statusCode == 200){
      shopdetailsModel = ShopdetailsModel.fromJson(jsonDecode(response.body));
    }

    print(shopdetailsModel.message);
    print(response.body);
    return shopdetailsModel;
  }
  Future<dynamic> updateProfile(String id,String firstName,String lastName,String email,String Phone,String date_of_birth, String country,String device_token, String imei_number,String device_type,
 String language, File image )async{
    SharedPref sharedPref = SharedPref();




    UpdateProfileModel updateProfileModel;
    dynamic resp;
    try {
      var dio = Dio();
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      String deviceToken =_preferences.getString("token")??"";


      String fileName = image.absolute.path
          .split('/')
          .last;
      FormData formData = FormData.fromMap({
        "profile_image":
        await MultipartFile.fromFile(image.absolute.path, filename: fileName),
        "id":id,
        "firstname":firstName,
        "lastname":lastName,
        "date_of_birth":date_of_birth,
        "country":country,
        "device_token":deviceToken,
        "imei_number":imei_number,
        "device_type":device_type,
        "language":language,




        "mobile": Phone,
        "email": email,

      });

      final  response = await dio.post(TAG_BASE_URL + "customer/update", data: formData);
      print(response.data);
      if (response.statusCode == 200) {
        resp = response.data;
      }

    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      resp =e.response.data;



    }
    return resp;


  }
  Future<dynamic> addPost(String english_name,String arabic_name,String post_type,String english_description,String arabic_description, String price,String category_id, String age,String age_id,
      String gender, String owner_id, String sub_category_id,
      String contact_no,String mLanguage,List<File> images ,File vedio)async{
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

      map['english_name'] = english_name;
      map['arabic_name'] = arabic_name;
      map['post_type'] = post_type;
      map['english_description'] = english_description;
      map['arabic_description'] = arabic_description;
      map['price'] = price;
      map['category_id'] = category_id;
      map['age'] = age;
      map['age_id'] = age_id;
      map['gender'] = gender;
      map['owner_id'] = owner_id;
      map['sub_category_id'] = sub_category_id;
      map['contact_no'] = contact_no;
      map['language'] = mLanguage;
      for(int i =0;i<images.length;i++){
        String path = images[i].absolute.path;
        print('path --> ${images[i].absolute.path}');

        String childFileName = path
            .split('/')
            .last;
        print ('childFileName ${childFileName}');
        map['images[${i}]']=  await MultipartFile.fromFile(path, filename: childFileName);
      }
  // File vedioFile =  File.fromRawPath(Uint8List.fromList([0]));
  //         String childFileName = vedioFile.path
  //             .split('/')
  //         .last;
      // map['videos[0]'] = await MultipartFile.fromFile(vedioFile.path, filename: childFileName);
      FormData formData = new FormData.fromMap(map);
      final  response = await dio.post("post/create", data: formData);

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
     String mLanguage,List<File> images ,List<File> vedio)async{
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

      map['english_name'] = english_name;
      map['arabic_name'] = arabic_name;

      map['english_description'] = english_description;
      map['arabic_description'] = arabic_description;
      map['start_date'] = start_date;
      map['end_date'] = end_date;
      map['category_id'] = category_id;
      map['bid_value'] = bid_value;
      map['auction_type'] = auction_type;

      map['owner_id'] = owner_id;
      map['sub_category_id'] = sub_category_id;

      map['language'] = mLanguage;
      for(int i =0;i<images.length;i++){
        print('path --> ${images[i].absolute.path}');

        String childFileName = images[i].absolute.path
            .split('/')
            .last;
        print ('childFileName ${childFileName}');
        map['images[${i}]']=  await MultipartFile.fromFile(images[i].absolute.path, filename: childFileName);
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
      final  response = await dio.post("auction/create", data: formData);

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
      String contact_no,String mLanguage,List<File> images ,File vedio)async{
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
      map['post_id'] = id;

      map['english_name'] = english_name;
      map['arabic_name'] = arabic_name;
      map['post_type'] = post_type;
      map['english_description'] = english_description;
      map['arabic_description'] = arabic_description;
      map['price'] = price;
      map['category_id'] = category_id;
      map['age'] = age;
      map['age_id'] = age_id;
      map['gender'] = gender;
      map['owner_id'] = owner_id;
      map['sub_category_id'] = sub_category_id;
      map['contact_no'] = contact_no;
      map['language'] = mLanguage;
      for(int i =0;i<images.length;i++){
        String path = images[i].absolute.path;
        print('path --> ${images[i].absolute.path}');

        String childFileName = path
            .split('/')
            .last;
        print ('childFileName ${childFileName}');
        map['images[${i}]']=  await MultipartFile.fromFile(path, filename: childFileName);
      }
      // File vedioFile =  File.fromRawPath(Uint8List.fromList([0]));
      //         String childFileName = vedioFile.path
      //             .split('/')
      //         .last;
      // map['videos[0]'] = await MultipartFile.fromFile(vedioFile.path, filename: childFileName);
      FormData formData = new FormData.fromMap(map);
      final  response = await dio.post("post/update", data: formData);

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
  Future<NotificationModel> notification(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}notification/list"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    NotificationModel notificationModel;
    if(response.statusCode == 200){
      notificationModel = NotificationModel.fromJson(jsonDecode(response.body));
    }

    print(notificationModel.message);
    print(response.body);
    return notificationModel;
  }
  Future<NotifyModel> notify(Map map) async {
    print(map);

    String body = json.encode(map);

    final response = await http.post(Uri.parse("${TAG_BASE_URL}customer/notify"),headers: {"Content-Type": "application/json"},body: body);
    print(' PostModel ${response}');
    NotifyModel notificationModel;
    if(response.statusCode == 200){
      notificationModel = NotifyModel.fromJson(jsonDecode(response.body));
    }

    print(notificationModel.message);
    print(response.body);
    return notificationModel;
  }
}