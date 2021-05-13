/// status : "success"
/// message : "Post retrived"
/// data : [{"post_id":"106","post_name":"Camel very nice condition ","age":"2","age_label":"4 Year","age_id":"4","gender":"Male","post_date":"30 Dec at 2:30 AM","post_image":"http://petmart.createkwservers.com/media/images/post/Picture_1609327775.jpg","min_price":"0.000","max_price":"0.000","search_keyword":"","post_price":"0.000 KWD","category":"Animals","post_description":"Very nice health condition","status":"disable","post_type":"adoption","image_count":1,"gallery":[{"image":"http://petmart.createkwservers.com/media/images/post/Picture_1609327775.jpg"}]}]

class PostModel {
  String _status;
  String _message;
  List<Data> _data;

  String get status => _status;
  String get message => _message;
  List<Data> get data => _data;

  PostModel({
      String status,
      String message,
      List<Data> data}){
    _status = status;
    _message = message;
    _data = data;
}

  PostModel.fromJson(dynamic json) {
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

/// post_id : "106"
/// post_name : "Camel very nice condition "
/// age : "2"
/// age_label : "4 Year"
/// age_id : "4"
/// gender : "Male"
/// post_date : "30 Dec at 2:30 AM"
/// post_image : "http://petmart.createkwservers.com/media/images/post/Picture_1609327775.jpg"
/// min_price : "0.000"
/// max_price : "0.000"
/// search_keyword : ""
/// post_price : "0.000 KWD"
/// category : "Animals"
/// post_description : "Very nice health condition"
/// status : "disable"
/// post_type : "adoption"
/// image_count : 1
/// gallery : [{"image":"http://petmart.createkwservers.com/media/images/post/Picture_1609327775.jpg"}]

class Data {
  String _postId;
  String _postName;
  String _age;
  String _ageLabel;
  String _ageId;
  String _gender;
  String _postDate;
  String _postImage;
  String _minPrice;
  String _maxPrice;
  String _searchKeyword;
  String _postPrice;
  String _category;
  String _postDescription;
  String _status;
  String _postType;
  int _imageCount;
  List<Gallery> _gallery;

  String get postId => _postId;
  String get postName => _postName;
  String get age => _age;
  String get ageLabel => _ageLabel;
  String get ageId => _ageId;
  String get gender => _gender;
  String get postDate => _postDate;
  String get postImage => _postImage;
  String get minPrice => _minPrice;
  String get maxPrice => _maxPrice;
  String get searchKeyword => _searchKeyword;
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
      String age,
      String ageLabel,
      String ageId,
      String gender,
      String postDate,
      String postImage,
      String minPrice,
      String maxPrice,
      String searchKeyword,
      String postPrice,
      String category,
      String postDescription,
      String status,
      String postType,
      int imageCount,
      List<Gallery> gallery}){
    _postId = postId;
    _postName = postName;
    _age = age;
    _ageLabel = ageLabel;
    _ageId = ageId;
    _gender = gender;
    _postDate = postDate;
    _postImage = postImage;
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    _searchKeyword = searchKeyword;
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
    _age = json["age"];
    _ageLabel = json["age_label"];
    _ageId = json["age_id"];
    _gender = json["gender"];
    _postDate = json["post_date"];
    _postImage = json["post_image"];
    _minPrice = json["min_price"];
    _maxPrice = json["max_price"];
    _searchKeyword = json["search_keyword"];
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
    map["age"] = _age;
    map["age_label"] = _ageLabel;
    map["age_id"] = _ageId;
    map["gender"] = _gender;
    map["post_date"] = _postDate;
    map["post_image"] = _postImage;
    map["min_price"] = _minPrice;
    map["max_price"] = _maxPrice;
    map["search_keyword"] = _searchKeyword;
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

/// image : "http://petmart.createkwservers.com/media/images/post/Picture_1609327775.jpg"

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