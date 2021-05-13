/// status : "success"
/// message : "Login successully."
/// data : {"customer_id":"92","firstname":"naser","lastname":"hatab","email":"nasserhatab@gmail.com","mobile":"90949089","gender":"","profile_image":"no-image.jpg","date_of_birth":"","confirm_password":"","country_name":"Kuwait","created_at":"2021-04-06 10:22:59","updated_at":"2021-04-06 22:26:32","last_login":"2021-04-24 00:42:33","status":"1","is_notify":"1","otp":963725,"available_credit":"0","random_token":null,"device_token":"wfwfewfwfwfwer","imei_number":"","device_type":"i"}

class LoginModel {
  String _status;
  String _message;
  Data _data;

  String get status => _status;
  String get message => _message;
  Data get data => _data;

  LoginModel({
      String status, 
      String message, 
      Data data}){
    _status = status;
    _message = message;
    _data = data;
}

  LoginModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// customer_id : "92"
/// firstname : "naser"
/// lastname : "hatab"
/// email : "nasserhatab@gmail.com"
/// mobile : "90949089"
/// gender : ""
/// profile_image : "no-image.jpg"
/// date_of_birth : ""
/// confirm_password : ""
/// country_name : "Kuwait"
/// created_at : "2021-04-06 10:22:59"
/// updated_at : "2021-04-06 22:26:32"
/// last_login : "2021-04-24 00:42:33"
/// status : "1"
/// is_notify : "1"
/// otp : 963725
/// available_credit : "0"
/// random_token : null
/// device_token : "wfwfewfwfwfwer"
/// imei_number : ""
/// device_type : "i"

class Data {
  String _customerId;
  String _firstname;
  String _lastname;
  String _email;
  String _mobile;
  String _gender;
  String _profileImage;
  String _dateOfBirth;
  String _confirmPassword;
  String _countryName;
  String _createdAt;
  String _updatedAt;
  String _lastLogin;
  String _status;
  String _isNotify;
  int _otp;
  String _availableCredit;
  dynamic _randomToken;
  String _deviceToken;
  String _imeiNumber;
  String _deviceType;

  String get customerId => _customerId;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get email => _email;
  String get mobile => _mobile;
  String get gender => _gender;
  String get profileImage => _profileImage;
  String get dateOfBirth => _dateOfBirth;
  String get confirmPassword => _confirmPassword;
  String get countryName => _countryName;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get lastLogin => _lastLogin;
  String get status => _status;
  String get isNotify => _isNotify;
  int get otp => _otp;
  String get availableCredit => _availableCredit;
  dynamic get randomToken => _randomToken;
  String get deviceToken => _deviceToken;
  String get imeiNumber => _imeiNumber;
  String get deviceType => _deviceType;

  Data({
      String customerId, 
      String firstname, 
      String lastname, 
      String email, 
      String mobile, 
      String gender, 
      String profileImage, 
      String dateOfBirth, 
      String confirmPassword, 
      String countryName, 
      String createdAt, 
      String updatedAt, 
      String lastLogin, 
      String status, 
      String isNotify, 
      int otp, 
      String availableCredit, 
      dynamic randomToken, 
      String deviceToken, 
      String imeiNumber, 
      String deviceType}){
    _customerId = customerId;
    _firstname = firstname;
    _lastname = lastname;
    _email = email;
    _mobile = mobile;
    _gender = gender;
    _profileImage = profileImage;
    _dateOfBirth = dateOfBirth;
    _confirmPassword = confirmPassword;
    _countryName = countryName;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _lastLogin = lastLogin;
    _status = status;
    _isNotify = isNotify;
    _otp = otp;
    _availableCredit = availableCredit;
    _randomToken = randomToken;
    _deviceToken = deviceToken;
    _imeiNumber = imeiNumber;
    _deviceType = deviceType;
}

  Data.fromJson(dynamic json) {
    _customerId = json["customer_id"];
    _firstname = json["firstname"];
    _lastname = json["lastname"];
    _email = json["email"];
    _mobile = json["mobile"];
    _gender = json["gender"];
    _profileImage = json["profile_image"];
    _dateOfBirth = json["date_of_birth"];
    _confirmPassword = json["confirm_password"];
    _countryName = json["country_name"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _lastLogin = json["last_login"];
    _status = json["status"];
    _isNotify = json["is_notify"];
    _otp = json["otp"];
    _availableCredit = json["available_credit"];
    _randomToken = json["random_token"];
    _deviceToken = json["device_token"];
    _imeiNumber = json["imei_number"];
    _deviceType = json["device_type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["customer_id"] = _customerId;
    map["firstname"] = _firstname;
    map["lastname"] = _lastname;
    map["email"] = _email;
    map["mobile"] = _mobile;
    map["gender"] = _gender;
    map["profile_image"] = _profileImage;
    map["date_of_birth"] = _dateOfBirth;
    map["confirm_password"] = _confirmPassword;
    map["country_name"] = _countryName;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["last_login"] = _lastLogin;
    map["status"] = _status;
    map["is_notify"] = _isNotify;
    map["otp"] = _otp;
    map["available_credit"] = _availableCredit;
    map["random_token"] = _randomToken;
    map["device_token"] = _deviceToken;
    map["imei_number"] = _imeiNumber;
    map["device_type"] = _deviceType;
    return map;
  }

}