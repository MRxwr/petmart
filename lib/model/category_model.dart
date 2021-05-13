/// status : "success"
/// message : "Data retrived."
/// data : {"category":[{"category_id":"1","category_name":"Bird","post":[{"post_id":"121","post_name":"bird 1","description":"Description ","post_image":"http://petmart.createkwservers.com/media/images/post/3568905.png","post_date":"20 Apr at 9:11 AM","price":"10.000 KWD","category_id":"1","gallery":[{"image":"http://petmart.createkwservers.com/media/images/post/3568905.png"}]},{"post_id":"120","post_name":"Sonjoy's test Post","description":"Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post ","post_image":"http://petmart.createkwservers.com/media/images/post/22445find_best_img4.jpg","post_date":"18 Apr at 8:14 AM","price":"50.000 KWD","category_id":"1","gallery":[{"image":"http://petmart.createkwservers.com/media/images/post/22445find_best_img4.jpg"}]},{"post_id":"112","post_name":"Test image","description":"Test image","post_image":"http://petmart.createkwservers.com/media/images/post/Picture_1611051174.jpg","post_date":"19 Jan at 1:13 AM","price":"212.000 KWD","category_id":"1","gallery":[{"image":"http://petmart.createkwservers.com/media/images/post/Picture_1611051174.jpg"}]}],"childcategory":[{"category_id":"21","category_name":"Talking bird ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/19764CDA0EB59-F0C3-4703-A175-41AE2A778EFB.jpeg"},{"category_id":"11","category_name":"Chicken ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/71143B5781325-0DA3-4E48-B1A1-F5D8D5C8CB8F.jpeg"},{"category_id":"103","category_name":"Falcon ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/673807ADEDEE1-E18C-4155-B3B9-F16D1FAB5E5B.jpeg"},{"category_id":"10","category_name":"Birds of conservation","category_image":"http://petmart.createkwservers.com/media/images/postcategory/3019164290E9B-B020-4685-9475-DBFB130FC738.jpeg"},{"category_id":"102","category_name":"Small bird ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/5766A102855E-59BF-4F81-B8F6-FDDD1DE9921A.jpeg"},{"category_id":"104","category_name":"Others ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/25227F7D0CD91-146B-4278-ACE8-94057BA200BB.png"},{"category_id":"14","category_name":"Pigeons","category_image":"http://petmart.createkwservers.com/media/images/postcategory/91953D4A3DEB8-CF4E-4E85-98E1-C5852E241846.png"},{"category_id":"106","category_name":"Food and accessories ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/51459A53E966E-D8A8-4837-A784-6C40F879DF83.jpeg"},{"category_id":"107","category_name":"falcons","category_image":"http://petmart.createkwservers.com/media/images/postcategory/8790205.png"},{"category_id":"108","category_name":"some kind of a bird","category_image":"http://petmart.createkwservers.com/media/images/postcategory/1306805.png"}]}]}

class CategoryModel {
  String _status;
  String _message;
  Data _data;

  String get status => _status;
  String get message => _message;
  Data get data => _data;

  CategoryModel({
      String status, 
      String message, 
      Data data}){
    _status = status;
    _message = message;
    _data = data;
}

  CategoryModel.fromJson(dynamic json) {
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

/// category : [{"category_id":"1","category_name":"Bird","post":[{"post_id":"121","post_name":"bird 1","description":"Description ","post_image":"http://petmart.createkwservers.com/media/images/post/3568905.png","post_date":"20 Apr at 9:11 AM","price":"10.000 KWD","category_id":"1","gallery":[{"image":"http://petmart.createkwservers.com/media/images/post/3568905.png"}]},{"post_id":"120","post_name":"Sonjoy's test Post","description":"Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post ","post_image":"http://petmart.createkwservers.com/media/images/post/22445find_best_img4.jpg","post_date":"18 Apr at 8:14 AM","price":"50.000 KWD","category_id":"1","gallery":[{"image":"http://petmart.createkwservers.com/media/images/post/22445find_best_img4.jpg"}]},{"post_id":"112","post_name":"Test image","description":"Test image","post_image":"http://petmart.createkwservers.com/media/images/post/Picture_1611051174.jpg","post_date":"19 Jan at 1:13 AM","price":"212.000 KWD","category_id":"1","gallery":[{"image":"http://petmart.createkwservers.com/media/images/post/Picture_1611051174.jpg"}]}],"childcategory":[{"category_id":"21","category_name":"Talking bird ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/19764CDA0EB59-F0C3-4703-A175-41AE2A778EFB.jpeg"},{"category_id":"11","category_name":"Chicken ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/71143B5781325-0DA3-4E48-B1A1-F5D8D5C8CB8F.jpeg"},{"category_id":"103","category_name":"Falcon ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/673807ADEDEE1-E18C-4155-B3B9-F16D1FAB5E5B.jpeg"},{"category_id":"10","category_name":"Birds of conservation","category_image":"http://petmart.createkwservers.com/media/images/postcategory/3019164290E9B-B020-4685-9475-DBFB130FC738.jpeg"},{"category_id":"102","category_name":"Small bird ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/5766A102855E-59BF-4F81-B8F6-FDDD1DE9921A.jpeg"},{"category_id":"104","category_name":"Others ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/25227F7D0CD91-146B-4278-ACE8-94057BA200BB.png"},{"category_id":"14","category_name":"Pigeons","category_image":"http://petmart.createkwservers.com/media/images/postcategory/91953D4A3DEB8-CF4E-4E85-98E1-C5852E241846.png"},{"category_id":"106","category_name":"Food and accessories ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/51459A53E966E-D8A8-4837-A784-6C40F879DF83.jpeg"},{"category_id":"107","category_name":"falcons","category_image":"http://petmart.createkwservers.com/media/images/postcategory/8790205.png"},{"category_id":"108","category_name":"some kind of a bird","category_image":"http://petmart.createkwservers.com/media/images/postcategory/1306805.png"}]}]

class Data {
  List<Category> _category;

  List<Category> get category => _category;

  Data({
      List<Category> category}){
    _category = category;
}

  Data.fromJson(dynamic json) {
    if (json["category"] != null) {
      _category = [];
      json["category"].forEach((v) {
        _category.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_category != null) {
      map["category"] = _category.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// category_id : "1"
/// category_name : "Bird"
/// post : [{"post_id":"121","post_name":"bird 1","description":"Description ","post_image":"http://petmart.createkwservers.com/media/images/post/3568905.png","post_date":"20 Apr at 9:11 AM","price":"10.000 KWD","category_id":"1","gallery":[{"image":"http://petmart.createkwservers.com/media/images/post/3568905.png"}]},{"post_id":"120","post_name":"Sonjoy's test Post","description":"Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post Sonjoy's test Post ","post_image":"http://petmart.createkwservers.com/media/images/post/22445find_best_img4.jpg","post_date":"18 Apr at 8:14 AM","price":"50.000 KWD","category_id":"1","gallery":[{"image":"http://petmart.createkwservers.com/media/images/post/22445find_best_img4.jpg"}]},{"post_id":"112","post_name":"Test image","description":"Test image","post_image":"http://petmart.createkwservers.com/media/images/post/Picture_1611051174.jpg","post_date":"19 Jan at 1:13 AM","price":"212.000 KWD","category_id":"1","gallery":[{"image":"http://petmart.createkwservers.com/media/images/post/Picture_1611051174.jpg"}]}]
/// childcategory : [{"category_id":"21","category_name":"Talking bird ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/19764CDA0EB59-F0C3-4703-A175-41AE2A778EFB.jpeg"},{"category_id":"11","category_name":"Chicken ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/71143B5781325-0DA3-4E48-B1A1-F5D8D5C8CB8F.jpeg"},{"category_id":"103","category_name":"Falcon ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/673807ADEDEE1-E18C-4155-B3B9-F16D1FAB5E5B.jpeg"},{"category_id":"10","category_name":"Birds of conservation","category_image":"http://petmart.createkwservers.com/media/images/postcategory/3019164290E9B-B020-4685-9475-DBFB130FC738.jpeg"},{"category_id":"102","category_name":"Small bird ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/5766A102855E-59BF-4F81-B8F6-FDDD1DE9921A.jpeg"},{"category_id":"104","category_name":"Others ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/25227F7D0CD91-146B-4278-ACE8-94057BA200BB.png"},{"category_id":"14","category_name":"Pigeons","category_image":"http://petmart.createkwservers.com/media/images/postcategory/91953D4A3DEB8-CF4E-4E85-98E1-C5852E241846.png"},{"category_id":"106","category_name":"Food and accessories ","category_image":"http://petmart.createkwservers.com/media/images/postcategory/51459A53E966E-D8A8-4837-A784-6C40F879DF83.jpeg"},{"category_id":"107","category_name":"falcons","category_image":"http://petmart.createkwservers.com/media/images/postcategory/8790205.png"},{"category_id":"108","category_name":"some kind of a bird","category_image":"http://petmart.createkwservers.com/media/images/postcategory/1306805.png"}]

class Category {
  String _categoryId;
  String _categoryName;
  List<Post> _post;
  List<Childcategory> _childcategory;

  String get categoryId => _categoryId;
  String get categoryName => _categoryName;
  List<Post> get post => _post;
  List<Childcategory> get childcategory => _childcategory;

  Category({
      String categoryId, 
      String categoryName, 
      List<Post> post, 
      List<Childcategory> childcategory}){
    _categoryId = categoryId;
    _categoryName = categoryName;
    _post = post;
    _childcategory = childcategory;
}

  Category.fromJson(dynamic json) {
    _categoryId = json["category_id"];
    _categoryName = json["category_name"];
    if (json["post"] != null) {
      _post = [];
      json["post"].forEach((v) {
        _post.add(Post.fromJson(v));
      });
    }
    if (json["childcategory"] != null) {
      _childcategory = [];
      json["childcategory"].forEach((v) {
        _childcategory.add(Childcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["category_id"] = _categoryId;
    map["category_name"] = _categoryName;
    if (_post != null) {
      map["post"] = _post.map((v) => v.toJson()).toList();
    }
    if (_childcategory != null) {
      map["childcategory"] = _childcategory.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// category_id : "21"
/// category_name : "Talking bird "
/// category_image : "http://petmart.createkwservers.com/media/images/postcategory/19764CDA0EB59-F0C3-4703-A175-41AE2A778EFB.jpeg"

class Childcategory {
  String _categoryId;
  String _categoryName;
  String _categoryImage;

  String get categoryId => _categoryId;
  String get categoryName => _categoryName;
  String get categoryImage => _categoryImage;

  Childcategory({
      String categoryId, 
      String categoryName, 
      String categoryImage}){
    _categoryId = categoryId;
    _categoryName = categoryName;
    _categoryImage = categoryImage;
}

  Childcategory.fromJson(dynamic json) {
    _categoryId = json["category_id"];
    _categoryName = json["category_name"];
    _categoryImage = json["category_image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["category_id"] = _categoryId;
    map["category_name"] = _categoryName;
    map["category_image"] = _categoryImage;
    return map;
  }

}

/// post_id : "121"
/// post_name : "bird 1"
/// description : "Description "
/// post_image : "http://petmart.createkwservers.com/media/images/post/3568905.png"
/// post_date : "20 Apr at 9:11 AM"
/// price : "10.000 KWD"
/// category_id : "1"
/// gallery : [{"image":"http://petmart.createkwservers.com/media/images/post/3568905.png"}]

class Post {
  String _postId;
  String _postName;
  String _description;
  String _postImage;
  String _postDate;
  String _price;
  String _categoryId;
  List<Gallery> _gallery;

  String get postId => _postId;
  String get postName => _postName;
  String get description => _description;
  String get postImage => _postImage;
  String get postDate => _postDate;
  String get price => _price;
  String get categoryId => _categoryId;
  List<Gallery> get gallery => _gallery;

  Post({
      String postId, 
      String postName, 
      String description, 
      String postImage, 
      String postDate, 
      String price, 
      String categoryId, 
      List<Gallery> gallery}){
    _postId = postId;
    _postName = postName;
    _description = description;
    _postImage = postImage;
    _postDate = postDate;
    _price = price;
    _categoryId = categoryId;
    _gallery = gallery;
}

  Post.fromJson(dynamic json) {
    _postId = json["post_id"];
    _postName = json["post_name"];
    _description = json["description"];
    _postImage = json["post_image"];
    _postDate = json["post_date"];
    _price = json["price"];
    _categoryId = json["category_id"];
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
    map["description"] = _description;
    map["post_image"] = _postImage;
    map["post_date"] = _postDate;
    map["price"] = _price;
    map["category_id"] = _categoryId;
    if (_gallery != null) {
      map["gallery"] = _gallery.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// image : "http://petmart.createkwservers.com/media/images/post/3568905.png"

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