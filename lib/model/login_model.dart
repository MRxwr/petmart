class LoginModel {
  String status;
  String message;
  Data data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String customerId;
  String firstname;
  String lastname;
  String email;
  String mobile;
  String gender;
  String profileImage;
  String dateOfBirth;
  String confirmPassword;
  String countryName;
  String createdAt;
  String updatedAt;
  String lastLogin;
  String status;
  String isNotify;
  int otp;
  String availableCredit;
   String randomToken;
  String deviceToken;
  String imeiNumber;
  String deviceType;
  String expiryDate;

  Data(
      {this.customerId,
        this.firstname,
        this.lastname,
        this.email,
        this.mobile,
        this.gender,
        this.profileImage,
        this.dateOfBirth,
        this.confirmPassword,
        this.countryName,
        this.createdAt,
        this.updatedAt,
        this.lastLogin,
        this.status,
        this.isNotify,
        this.otp,
        this.availableCredit,
        this.randomToken,
        this.deviceToken,
        this.imeiNumber,
        this.deviceType,
        this.expiryDate});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    dateOfBirth = json['date_of_birth'];
    confirmPassword = json['confirm_password'];
    countryName = json['country_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastLogin = json['last_login'];
    status = json['status'];
    isNotify = json['is_notify'];
    otp = json['otp'];
    availableCredit = json['available_credit'];
    randomToken = json['random_token'];
    deviceToken = json['device_token'];
    imeiNumber = json['imei_number'];
    deviceType = json['device_type'];
    expiryDate = json['expiry_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['date_of_birth'] = this.dateOfBirth;
    data['confirm_password'] = this.confirmPassword;
    data['country_name'] = this.countryName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['last_login'] = this.lastLogin;
    data['status'] = this.status;
    data['is_notify'] = this.isNotify;
    data['otp'] = this.otp;
    data['available_credit'] = this.availableCredit;
    data['random_token'] = this.randomToken;
    data['device_token'] = this.deviceToken;
    data['imei_number'] = this.imeiNumber;
    data['device_type'] = this.deviceType;
    data['expiry_date'] = this.expiryDate;
    return data;
  }
}