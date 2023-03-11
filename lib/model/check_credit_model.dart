/// status : "success"
/// message : "user credit retrived"
/// data : {"expiry_date":"28/05/2021 06:28:47","credit":"1998"}

class CheckCreditModel {
  String? _status;
  String? _message;
  Data? _data;

  String get status => _status!;
  String get message => _message!;
  Data get data => _data!;

  CheckCreditModel({
      String? status,
      String? message,
      Data? data}){
    _status = status;
    _message = message;
    _data = data;
}

  CheckCreditModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data!.toJson();
    }
    return map;
  }

}

/// expiry_date : "28/05/2021 06:28:47"
/// credit : "1998"

class Data {
  String? _expiryDate;
  String? _credit;

  String get expiryDate => _expiryDate!;
  String get credit => _credit!;

  Data({
      String? expiryDate,
      String? credit}){
    _expiryDate = expiryDate;
    _credit = credit;
}

  Data.fromJson(dynamic json) {
    _expiryDate = json["expiry_date"];
    _credit = json["credit"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["expiry_date"] = _expiryDate;
    map["credit"] = _credit;
    return map;
  }

}