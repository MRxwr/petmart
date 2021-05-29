/// status : "success"
/// message : "Post has been created."
/// data : [{"post_id":"124","post_name":"test","post_date":"28 May at 3:52 AM","post_image":"http://petmart.createkwservers.com/media/images/no-image.jpg","post_price":"200 KWD","category":"Bird","sub_category":"Talking bird ","post_description":"test","status":"disable","post_type":"sell","image_count":0}]

class AddPostModel {
  String _status;
  String _message;
  List<Data> _data;

  String get status => _status;
  String get message => _message;
  List<Data> get data => _data;

  AddPostModel({
      String status, 
      String message, 
      List<Data> data}){
    _status = status;
    _message = message;
    _data = data;
}

  AddPostModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// post_id : "124"
/// post_name : "test"
/// post_date : "28 May at 3:52 AM"
/// post_image : "http://petmart.createkwservers.com/media/images/no-image.jpg"
/// post_price : "200 KWD"
/// category : "Bird"
/// sub_category : "Talking bird "
/// post_description : "test"
/// status : "disable"
/// post_type : "sell"
/// image_count : 0

class Data {
  String _postId;
  String _postName;
  String _postDate;
  String _postImage;
  String _postPrice;
  String _category;
  String _subCategory;
  String _postDescription;
  String _status;
  String _postType;
  int _imageCount;

  String get postId => _postId;
  String get postName => _postName;
  String get postDate => _postDate;
  String get postImage => _postImage;
  String get postPrice => _postPrice;
  String get category => _category;
  String get subCategory => _subCategory;
  String get postDescription => _postDescription;
  String get status => _status;
  String get postType => _postType;
  int get imageCount => _imageCount;

  Data({
      String postId, 
      String postName, 
      String postDate, 
      String postImage, 
      String postPrice, 
      String category, 
      String subCategory, 
      String postDescription, 
      String status, 
      String postType, 
      int imageCount}){
    _postId = postId;
    _postName = postName;
    _postDate = postDate;
    _postImage = postImage;
    _postPrice = postPrice;
    _category = category;
    _subCategory = subCategory;
    _postDescription = postDescription;
    _status = status;
    _postType = postType;
    _imageCount = imageCount;
}

  Data.fromJson(dynamic json) {
    _postId = json["post_id"];
    _postName = json["post_name"];
    _postDate = json["post_date"];
    _postImage = json["post_image"];
    _postPrice = json["post_price"];
    _category = json["category"];
    _subCategory = json["sub_category"];
    _postDescription = json["post_description"];
    _status = json["status"];
    _postType = json["post_type"];
    _imageCount = json["image_count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["post_id"] = _postId;
    map["post_name"] = _postName;
    map["post_date"] = _postDate;
    map["post_image"] = _postImage;
    map["post_price"] = _postPrice;
    map["category"] = _category;
    map["sub_category"] = _subCategory;
    map["post_description"] = _postDescription;
    map["status"] = _status;
    map["post_type"] = _postType;
    map["image_count"] = _imageCount;
    return map;
  }

}