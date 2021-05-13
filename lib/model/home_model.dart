/// status : "success"
/// message : "Home page data retrived."
/// data : {"banner":[{"banner_id":"8","image":"http://petmart.createkwservers.com/media/images/banner/banner-1.jpg"}],"category":[{"category_id":"1","category_name":"Bird","images":[{"image":"http://petmart.createkwservers.com/media/images/postcategory/116125A907EBE-5855-4B49-AF62-D611F52BC806.png"}]},{"category_id":"2","category_name":"Animals","images":[{"image":"http://petmart.createkwservers.com/media/images/postcategory/709923C381BCA-B951-4910-A302-F18061157AA8.png"}]},{"category_id":"3","category_name":"Dog & Cat","images":[{"image":"http://petmart.createkwservers.com/media/images/postcategory/38303AA318301-7CE9-40D9-8909-F5C5355D0C3A.png"}]},{"category_id":"4","category_name":"Small Animal & Reptiles","images":[{"image":"http://petmart.createkwservers.com/media/images/postcategory/70153C8006549-0300-4E23-8AE1-47D7FEBA5782.png"}]},{"category_id":"51","category_name":"Fish","images":[{"image":"http://petmart.createkwservers.com/media/images/postcategory/11249A5E8CA56-1252-4EB4-A6CA-E00F82BC8A06.png"}]}],"total_unread":0}

class HomeModel {
  String _status;
  String _message;
  Data _data;

  String get status => _status;
  String get message => _message;
  Data get data => _data;

  HomeModel({
      String status, 
      String message, 
      Data data}){
    _status = status;
    _message = message;
    _data = data;
}

  HomeModel.fromJson(dynamic json) {
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

/// banner : [{"banner_id":"8","image":"http://petmart.createkwservers.com/media/images/banner/banner-1.jpg"}]
/// category : [{"category_id":"1","category_name":"Bird","images":[{"image":"http://petmart.createkwservers.com/media/images/postcategory/116125A907EBE-5855-4B49-AF62-D611F52BC806.png"}]},{"category_id":"2","category_name":"Animals","images":[{"image":"http://petmart.createkwservers.com/media/images/postcategory/709923C381BCA-B951-4910-A302-F18061157AA8.png"}]},{"category_id":"3","category_name":"Dog & Cat","images":[{"image":"http://petmart.createkwservers.com/media/images/postcategory/38303AA318301-7CE9-40D9-8909-F5C5355D0C3A.png"}]},{"category_id":"4","category_name":"Small Animal & Reptiles","images":[{"image":"http://petmart.createkwservers.com/media/images/postcategory/70153C8006549-0300-4E23-8AE1-47D7FEBA5782.png"}]},{"category_id":"51","category_name":"Fish","images":[{"image":"http://petmart.createkwservers.com/media/images/postcategory/11249A5E8CA56-1252-4EB4-A6CA-E00F82BC8A06.png"}]}]
/// total_unread : 0

class Data {
  List<Banner> _banner;
  List<Category> _category;
  int _totalUnread;

  List<Banner> get banner => _banner;
  List<Category> get category => _category;
  int get totalUnread => _totalUnread;

  Data({
      List<Banner> banner, 
      List<Category> category, 
      int totalUnread}){
    _banner = banner;
    _category = category;
    _totalUnread = totalUnread;
}

  Data.fromJson(dynamic json) {
    if (json["banner"] != null) {
      _banner = [];
      json["banner"].forEach((v) {
        _banner.add(Banner.fromJson(v));
      });
    }
    if (json["category"] != null) {
      _category = [];
      json["category"].forEach((v) {
        _category.add(Category.fromJson(v));
      });
    }
    _totalUnread = json["total_unread"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_banner != null) {
      map["banner"] = _banner.map((v) => v.toJson()).toList();
    }
    if (_category != null) {
      map["category"] = _category.map((v) => v.toJson()).toList();
    }
    map["total_unread"] = _totalUnread;
    return map;
  }

}

/// category_id : "1"
/// category_name : "Bird"
/// images : [{"image":"http://petmart.createkwservers.com/media/images/postcategory/116125A907EBE-5855-4B49-AF62-D611F52BC806.png"}]

class Category {
  String _categoryId;
  String _categoryName;
  List<Images> _images;

  String get categoryId => _categoryId;
  String get categoryName => _categoryName;
  List<Images> get images => _images;

  Category({
      String categoryId, 
      String categoryName, 
      List<Images> images}){
    _categoryId = categoryId;
    _categoryName = categoryName;
    _images = images;
}

  Category.fromJson(dynamic json) {
    _categoryId = json["category_id"];
    _categoryName = json["category_name"];
    if (json["images"] != null) {
      _images = [];
      json["images"].forEach((v) {
        _images.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["category_id"] = _categoryId;
    map["category_name"] = _categoryName;
    if (_images != null) {
      map["images"] = _images.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// image : "http://petmart.createkwservers.com/media/images/postcategory/116125A907EBE-5855-4B49-AF62-D611F52BC806.png"

class Images {
  String _image;

  String get image => _image;

  Images({
      String image}){
    _image = image;
}

  Images.fromJson(dynamic json) {
    _image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image"] = _image;
    return map;
  }

}

/// banner_id : "8"
/// image : "http://petmart.createkwservers.com/media/images/banner/banner-1.jpg"

class Banner {
  String _bannerId;
  String _image;

  String get bannerId => _bannerId;
  String get image => _image;

  Banner({
      String bannerId, 
      String image}){
    _bannerId = bannerId;
    _image = image;
}

  Banner.fromJson(dynamic json) {
    _bannerId = json["banner_id"];
    _image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["banner_id"] = _bannerId;
    map["image"] = _image;
    return map;
  }

}