/// status : "success"
/// message : "Post share count retrived."
/// data : {"post_id":"34","share_count":"40"}

class ShareModel {
  String _status;
  String _message;
  Data _data;

  String get status => _status;
  String get message => _message;
  Data get data => _data;

  ShareModel({
      String status, 
      String message, 
      Data data}){
    _status = status;
    _message = message;
    _data = data;
}

  ShareModel.fromJson(dynamic json) {
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

/// post_id : "34"
/// share_count : "40"

class Data {
  String _postId;
  String _shareCount;

  String get postId => _postId;
  String get shareCount => _shareCount;

  Data({
      String postId, 
      String shareCount}){
    _postId = postId;
    _shareCount = shareCount;
}

  Data.fromJson(dynamic json) {
    _postId = json["post_id"];
    _shareCount = json["share_count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["post_id"] = _postId;
    map["share_count"] = _shareCount;
    return map;
  }

}