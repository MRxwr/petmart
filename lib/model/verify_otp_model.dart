/// status : "success"
/// message : "Your OTP verification passed."
/// data : []

class VerifyOtpModel {
  String _status;
  String _message;


  String get status => _status;
  String get message => _message;


  VerifyOtpModel({
      String status, 
      String message}){
    _status = status;
    _message = message;

}

  VerifyOtpModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    
    return map;
  }

}