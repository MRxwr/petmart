/// status : "success"
/// message : "Post retrived"
/// data : [{"post_id":"122","post_name":"test","post_date":"20 May at 8:36 AM","post_image":"http://petmart.createkwservers.com/media/images/post/2021_05_20_08_35_33.png","post_price":"0.000 KWD","category":"Bird","post_description":"fghgcdr","status":"disable","post_type":"adoption","image_count":1,"gallery":[{"image":"http://petmart.createkwservers.com/media/images/post/2021_05_20_08_35_33.png"}]}]

class PostsModel {
  String _status;
  String _message;
  List<Data> _data;

  String get status => _status;
  String get message => _message;
  List<Data> get data => _data;

  PostsModel({
      String status, 
      String message, 
      List<Data> data}){
    _status = status;
    _message = message;
    _data = data;
}

  PostsModel.fromJson(dynamic json) {
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

/// post_id : "122"
/// post_name : "test"
/// post_date : "20 May at 8:36 AM"
/// post_image : "http://petmart.createkwservers.com/media/images/post/2021_05_20_08_35_33.png"
/// post_price : "0.000 KWD"
/// category : "Bird"
/// post_description : "fghgcdr"
/// status : "disable"
/// post_type : "adoption"
/// image_count : 1
/// gallery : [{"image":"http://petmart.createkwservers.com/media/images/post/2021_05_20_08_35_33.png"}]

class Data {
  String _postId;
  String _postName;
  String _postDate;
  String _postImage;
  String _postPrice;
  String _category;
  String _postDescription;
  String _status;
  String _postType;
  int _imageCount;
  List<Gallery> _gallery;

  String get postId => _postId;
  String get postName => _postName;
  String get postDate => _postDate;
  String get postImage => _postImage;
  String get postPrice => _postPrice;
  String get category => _category;
  String get postDescription => _postDescription;
  String get status => _status;
  String get postType => _postType;
  int get imageCount => _imageCount;
  List<Gallery> get gallery => _gallery;

  Data({
      String postId, 
      String postName, 
      String postDate, 
      String postImage, 
      String postPrice, 
      String category, 
      String postDescription, 
      String status, 
      String postType, 
      int imageCount, 
      List<Gallery> gallery}){
    _postId = postId;
    _postName = postName;
    _postDate = postDate;
    _postImage = postImage;
    _postPrice = postPrice;
    _category = category;
    _postDescription = postDescription;
    _status = status;
    _postType = postType;
    _imageCount = imageCount;
    _gallery = gallery;
}

  Data.fromJson(dynamic json) {
    _postId = json["post_id"];
    _postName = json["post_name"];
    _postDate = json["post_date"];
    _postImage = json["post_image"];
    _postPrice = json["post_price"];
    _category = json["category"];
    _postDescription = json["post_description"];
    _status = json["status"];
    _postType = json["post_type"];
    _imageCount = json["image_count"];
    if (json["gallery"] != null) {
      _gallery = [];
      json["gallery"].forEach((v) {
        _gallery.add(Gallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["post_id"] = _postId;
    map["post_name"] = _postName;
    map["post_date"] = _postDate;
    map["post_image"] = _postImage;
    map["post_price"] = _postPrice;
    map["category"] = _category;
    map["post_description"] = _postDescription;
    map["status"] = _status;
    map["post_type"] = _postType;
    map["image_count"] = _imageCount;
    if (_gallery != null) {
      map["gallery"] = _gallery.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// image : "http://petmart.createkwservers.com/media/images/post/2021_05_20_08_35_33.png"

class Gallery {
  String _image;

  String get image => _image;

  Gallery({
      String image}){
    _image = image;
}

  Gallery.fromJson(dynamic json) {
    _image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image"] = _image;
    return map;
  }

}