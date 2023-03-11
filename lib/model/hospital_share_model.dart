/// status : "success"
/// message : "Hospital details retrived."
/// data : {"hospital_id":"1","shared":20,"most_view":"183"}

class HospitalShareModel {
  String? _status;
  String? _message;
  Data? _data;

  String get status => _status!;
  String get message => _message!;
  Data get data => _data!;

  HospitalShareModel({
    String? status,
    String? message,
      Data? data}){
    _status = status;
    _message = message;
    _data = data;
}

  HospitalShareModel.fromJson(dynamic json) {
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

/// hospital_id : "1"
/// shared : 20
/// most_view : "183"

class Data {
  String? _hospitalId;
  int? _shared;
  String? _mostView;

  String get hospitalId => _hospitalId!;
  int get shared => _shared!;
  String get mostView => _mostView!;

  Data({
    String? hospitalId,
      int? shared,
      String? mostView}){
    _hospitalId = hospitalId;
    _shared = shared;
    _mostView = mostView;
}

  Data.fromJson(dynamic json) {
    _hospitalId = json["hospital_id"];
    _shared = json["shared"];
    _mostView = json["most_view"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["hospital_id"] = _hospitalId;
    map["shared"] = _shared;
    map["most_view"] = _mostView;
    return map;
  }

}