/// status : "success"
/// message : "Post view count retrived."
/// data : {"post_id":"34","post_count":40}

class ViewModel {
  String? _status;
  String? _message;
  Data? _data;

  String get status => _status!;
  String get message => _message!;
  Data get data => _data!;

  ViewModel({
    String? status,
    String? message,
      Data? data}){
    _status = status;
    _message = message;
    _data = data;
}

  ViewModel.fromJson(dynamic json) {
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

/// post_id : "34"
/// post_count : 40

class Data {
  String? _postId;
  int? _postCount;

  String get postId => _postId!;
  int get postCount => _postCount!;

  Data({
    String? postId,
      int? postCount}){
    _postId = postId;
    _postCount = postCount;
}

  Data.fromJson(dynamic json) {
    _postId = json["post_id"];
    _postCount = json["post_count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["post_id"] = _postId;
    map["post_count"] = _postCount;
    return map;
  }

}