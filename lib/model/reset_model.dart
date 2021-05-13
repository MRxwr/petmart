/// status : "success"
/// message : "Reset password email has been sent to your registered email address."

class ResetModel {
  String _status;
  String _message;

  String get status => _status;
  String get message => _message;

  ResetModel({
      String status, 
      String message}){
    _status = status;
    _message = message;
}

  ResetModel.fromJson(dynamic json) {
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