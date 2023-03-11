/// status : "success"
/// message : "device token inserted."
/// data : 1

class TokenModel {
  String? _status;
  String? _message;
  int? _data;

  String get status => _status!;
  String get message => _message!;
  int get data => _data!;

  TokenModel({
    String? status,
    String? message,
      int? data}){
    _status = status;
    _message = message;
    _data = data;
}

  TokenModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _data = json["data"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    map["data"] = _data;
    return map;
  }

}