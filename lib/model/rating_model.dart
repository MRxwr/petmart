/// status : "success"
/// message : "User rating has been saved."
/// data : {"rating":3.3333333333333335}

class RatingModel {
  String _status;
  String _message;
  Data _data;

  String get status => _status;
  String get message => _message;
  Data get data => _data;

  RatingModel({
      String status, 
      String message, 
      Data data}){
    _status = status;
    _message = message;
    _data = data;
}

  RatingModel.fromJson(dynamic json) {
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

/// rating : 3.3333333333333335

class Data {
  dynamic _rating;

  dynamic get rating => _rating;

  Data({
    dynamic rating}){
    _rating = rating;
}

  Data.fromJson(dynamic json) {
    _rating = json["rating"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["rating"] = _rating;
    return map;
  }

}