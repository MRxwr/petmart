/// status : "success"
/// message : "Registration successfully"
/// data : {"mobile":"98765432","status":0,"firstname":"mm","lastname":"nnnn","email":"mm@m.com","password":"25d55ad283aa400af464c76d713c07ad","date_of_birth":"17-121-1990","device_token":"sjfosjfoskf","imei_number":"sksokfos","device_type":"a","created_at":"2021-04-24 07:54:49","updated_at":"2021-04-24 07:54:49","country_name":"Kuwait","otp":647692,"customer_id":"94","gender":null,"profile_image":null,"confirm_password":null,"last_login":null,"is_notify":null,"available_credit":null,"random_token":null}

class RegisterModel {
  String _status;
  String _message;
  Data _data;

  String get status => _status;
  String get message => _message;
  Data get data => _data;

  RegisterModel({
      String status, 
      String message, 
      Data data}){
    _status = status;
    _message = message;
    _data = data;
}

  RegisterModel.fromJson(dynamic json) {
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

/// mobile : "98765432"
/// status : 0
/// firstname : "mm"
/// lastname : "nnnn"
/// email : "mm@m.com"
/// password : "25d55ad283aa400af464c76d713c07ad"
/// date_of_birth : "17-121-1990"
/// device_token : "sjfosjfoskf"
/// imei_number : "sksokfos"
/// device_type : "a"
/// created_at : "2021-04-24 07:54:49"
/// updated_at : "2021-04-24 07:54:49"
/// country_name : "Kuwait"
/// otp : 647692
/// customer_id : "94"
/// gender : null
/// profile_image : null
/// confirm_password : null
/// last_login : null
/// is_notify : null
/// available_credit : null
/// random_token : null

class Data {
  String _mobile;
  int _status;
  String _firstname;
  String _lastname;
  String _email;
  String _password;
  String _dateOfBirth;
  String _deviceToken;
  String _imeiNumber;
  String _deviceType;
  String _createdAt;
  String _updatedAt;
  String _countryName;
  int _otp;
  String _customerId;
  dynamic _gender;
  dynamic _profileImage;
  dynamic _confirmPassword;
  dynamic _lastLogin;
  dynamic _isNotify;
  dynamic _availableCredit;
  dynamic _randomToken;

  String get mobile => _mobile;
  int get status => _status;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get email => _email;
  String get password => _password;
  String get dateOfBirth => _dateOfBirth;
  String get deviceToken => _deviceToken;
  String get imeiNumber => _imeiNumber;
  String get deviceType => _deviceType;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get countryName => _countryName;
  int get otp => _otp;
  String get customerId => _customerId;
  dynamic get gender => _gender;
  dynamic get profileImage => _profileImage;
  dynamic get confirmPassword => _confirmPassword;
  dynamic get lastLogin => _lastLogin;
  dynamic get isNotify => _isNotify;
  dynamic get availableCredit => _availableCredit;
  dynamic get randomToken => _randomToken;

  Data({
      String mobile, 
      int status, 
      String firstname, 
      String lastname, 
      String email, 
      String password, 
      String dateOfBirth, 
      String deviceToken, 
      String imeiNumber, 
      String deviceType, 
      String createdAt, 
      String updatedAt, 
      String countryName, 
      int otp, 
      String customerId, 
      dynamic gender, 
      dynamic profileImage, 
      dynamic confirmPassword, 
      dynamic lastLogin, 
      dynamic isNotify, 
      dynamic availableCredit, 
      dynamic randomToken}){
    _mobile = mobile;
    _status = status;
    _firstname = firstname;
    _lastname = lastname;
    _email = email;
    _password = password;
    _dateOfBirth = dateOfBirth;
    _deviceToken = deviceToken;
    _imeiNumber = imeiNumber;
    _deviceType = deviceType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _countryName = countryName;
    _otp = otp;
    _customerId = customerId;
    _gender = gender;
    _profileImage = profileImage;
    _confirmPassword = confirmPassword;
    _lastLogin = lastLogin;
    _isNotify = isNotify;
    _availableCredit = availableCredit;
    _randomToken = randomToken;
}

  Data.fromJson(dynamic json) {
    _mobile = json["mobile"];
    _status = json["status"];
    _firstname = json["firstname"];
    _lastname = json["lastname"];
    _email = json["email"];
    _password = json["password"];
    _dateOfBirth = json["date_of_birth"];
    _deviceToken = json["device_token"];
    _imeiNumber = json["imei_number"];
    _deviceType = json["device_type"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _countryName = json["country_name"];
    _otp = json["otp"];
    _customerId = json["customer_id"];
    _gender = json["gender"];
    _profileImage = json["profile_image"];
    _confirmPassword = json["confirm_password"];
    _lastLogin = json["last_login"];
    _isNotify = json["is_notify"];
    _availableCredit = json["available_credit"];
    _randomToken = json["random_token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["mobile"] = _mobile;
    map["status"] = _status;
    map["firstname"] = _firstname;
    map["lastname"] = _lastname;
    map["email"] = _email;
    map["password"] = _password;
    map["date_of_birth"] = _dateOfBirth;
    map["device_token"] = _deviceToken;
    map["imei_number"] = _imeiNumber;
    map["device_type"] = _deviceType;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["country_name"] = _countryName;
    map["otp"] = _otp;
    map["customer_id"] = _customerId;
    map["gender"] = _gender;
    map["profile_image"] = _profileImage;
    map["confirm_password"] = _confirmPassword;
    map["last_login"] = _lastLogin;
    map["is_notify"] = _isNotify;
    map["available_credit"] = _availableCredit;
    map["random_token"] = _randomToken;
    return map;
  }

}