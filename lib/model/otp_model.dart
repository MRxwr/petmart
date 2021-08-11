/// status : "success"
/// message : "Your OTP has been sent to your mobile."
/// data : {"otp":749337}

class OtpModel {
  String _status;
  String _message;
  Data _data;

  String get status => _status;
  String get message => _message;
  Data get data => _data;

  OtpModel({
      String status, 
      String message, 
      Data data}){
    _status = status;
    _message = message;
    _data = data;
}

  OtpModel.fromJson(dynamic json) {
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

/// otp : 749337

class Data {
  int _otp;

  int get otp => _otp;

  Data({
      int otp}){
    _otp = otp;
}

  Data.fromJson(dynamic json) {
    _otp = json["otp"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["otp"] = _otp;
    return map;
  }

}