/// status : "success"
/// message : "Post retrived"
/// data : [{"post_id":"117","post_name":"","age":"0","age_label":"","age_id":"0","gender":"Not Applicable","post_date":"18 Apr at 3:40 AM","post_image":"http://petmart.createkwservers.com/media/images/no-image.jpg","min_price":"0.000","max_price":"0.000","search_keyword":"","post_price":" KWD","category":"","post_description":"","status":"","post_type":"","image_count":0,"gallery":[]}]

class SearchModel {
  String _status;
  String _message;
  List<Data> _data;

  String get status => _status;
  String get message => _message;
  List<Data> get data => _data;

  SearchModel({
      String status, 
      String message, 
      List<Data> data}){
    _status = status;
    _message = message;
    _data = data;
}

  SearchModel.fromJson(dynamic json) {
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

/// post_id : "117"
/// post_name : ""
/// age : "0"
/// age_label : ""
/// age_id : "0"
/// gender : "Not Applicable"
/// post_date : "18 Apr at 3:40 AM"
/// post_image : "http://petmart.createkwservers.com/media/images/no-image.jpg"
/// min_price : "0.000"
/// max_price : "0.000"
/// search_keyword : ""
/// post_price : " KWD"
/// category : ""
/// post_description : ""
/// status : ""
/// post_type : ""
/// image_count : 0
/// gallery : []

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
      List<dynamic> gallery}){
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

    return map;
  }

}