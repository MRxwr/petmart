/// status : "success"
/// message : "Customer data retrived."
/// data : {"customer_id":"93","firstname":"mohammed","lastname":"elshwehy","email":"eng.melshwehy@gmail.com","mobile":"98921108","gender":"","profile_image":"http://petmart.createkwservers.com/media/images/no-image.jpg","date_of_birth":"","password":"25d55ad283aa400af464c76d713c07ad","confirm_password":"","country_name":"Kuwait","created_at":"2021-04-24 04:27:03","updated_at":"2021-04-24 04:27:03","last_login":"2021-05-14 21:31:35","status":"1","is_notify":"0","otp":"228691","available_credit":"0","random_token":"89e3e4602f3df82061a45cb78aa51363","device_token":"eUvCYfXBdfM:APA91bHKZtJp3HU8-v6IjRQBr5xYLsIa-uZxFH-1lOD1faqY8ZUutBTVWCYEmOzG0PxOqprGjpd8xSxoz-oyb1ABcPeugKKrh0QtGBg5s-ixZt5TSdQ0bFjKbJeRBcBWUSwNcw_NUbQf","imei_number":"","device_type":"a"}

class UserModel {
  String _status;
  String _message;
  Data _data;

  String get status => _status;
  String get message => _message;
  Data get data => _data;

  UserModel({
      String status, 
      String message, 
      Data data}){
    _status = status;
    _message = message;
    _data = data;
}

  UserModel.fromJson(dynamic json) {
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

/// customer_id : "93"
/// firstname : "mohammed"
/// lastname : "elshwehy"
/// email : "eng.melshwehy@gmail.com"
/// mobile : "98921108"
/// gender : ""
/// profile_image : "http://petmart.createkwservers.com/media/images/no-image.jpg"
/// date_of_birth : ""
/// password : "25d55ad283aa400af464c76d713c07ad"
/// confirm_password : ""
/// country_name : "Kuwait"
/// created_at : "2021-04-24 04:27:03"
/// updated_at : "2021-04-24 04:27:03"
/// last_login : "2021-05-14 21:31:35"
/// status : "1"
/// is_notify : "0"
/// otp : "228691"
/// available_credit : "0"
/// random_token : "89e3e4602f3df82061a45cb78aa51363"
/// device_token : "eUvCYfXBdfM:APA91bHKZtJp3HU8-v6IjRQBr5xYLsIa-uZxFH-1lOD1faqY8ZUutBTVWCYEmOzG0PxOqprGjpd8xSxoz-oyb1ABcPeugKKrh0QtGBg5s-ixZt5TSdQ0bFjKbJeRBcBWUSwNcw_NUbQf"
/// imei_number : ""
/// device_type : "a"

class Data {
  String _customerId;
  String _firstname;
  String _lastname;
  String _email;
  String _mobile;
  String _gender;
  String _profileImage;
  String _dateOfBirth;
  String _password;
  String _confirmPassword;
  String _countryName;
  String _createdAt;
  String _updatedAt;
  String _lastLogin;
  String _status;
  String _isNotify;
  String _otp;
  String _availableCredit;
  String _randomToken;
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
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get countryName => _countryName;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get lastLogin => _lastLogin;
  String get status => _status;
  String get isNotify => _isNotify;
  String get otp => _otp;
  String get availableCredit => _availableCredit;
  String get randomToken => _randomToken;
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
      String password, 
      String confirmPassword, 
      String countryName, 
      String createdAt, 
      String updatedAt, 
      String lastLogin, 
      String status, 
      String isNotify, 
      String otp, 
      String availableCredit, 
      String randomToken, 
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
    _password = password;
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
    _password = json["password"];
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
    map["password"] = _password;
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