class InitEditModel {
  bool? ok;
  String? error;
  String? status;
  Data? data;

  InitEditModel({this.ok, this.error, this.status, this.data});

  InitEditModel.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    error = json['error'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    data['error'] = this.error;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Category>? category;
  List<Category>? lost;
  List<Category>? adoption;
  Gender? gender;
  Gender? ageType;
  List<Post>? post;

  Data(
      {this.category,
        this.lost,
        this.adoption,
        this.gender,
        this.ageType,
        this.post});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['lost'] != null) {
      lost = <Category>[];
      json['lost'].forEach((v) {
        lost!.add(new Category.fromJson(v));
      });
    }
    if (json['adoption'] != null) {
      adoption = <Category>[];
      json['adoption'].forEach((v) {
        adoption!.add(new Category.fromJson(v));
      });
    }
    gender =
    json['gender'] != null ? new Gender.fromJson(json['gender']) : null;
    ageType =
    json['ageType'] != null ? new Gender.fromJson(json['ageType']) : null;
    if (json['post'] != null) {
      post = <Post>[];
      json['post'].forEach((v) {
        post!.add(new Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.lost != null) {
      data['lost'] = this.lost!.map((v) => v.toJson()).toList();
    }
    if (this.adoption != null) {
      data['adoption'] = this.adoption!.map((v) => v.toJson()).toList();
    }
    if (this.gender != null) {
      data['gender'] = this.gender!.toJson();
    }
    if (this.ageType != null) {
      data['ageType'] = this.ageType!.toJson();
    }
    if (this.post != null) {
      data['post'] = this.post!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? id;
  String? parentId;
  String? arTitle;
  String? enTitle;
  List<Sub>? sub;

  Category({this.id, this.parentId, this.arTitle, this.enTitle, this.sub});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parentId'];
    arTitle = json['arTitle'];
    enTitle = json['enTitle'];
    if (json['sub'] != null) {
      sub = <Sub>[];
      json['sub'].forEach((v) {
        sub!.add(new Sub.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    data['arTitle'] = this.arTitle;
    data['enTitle'] = this.enTitle;
    if (this.sub != null) {
      data['sub'] = this.sub!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sub {
  String? id;
  String? parentId;
  String? arTitle;
  String? enTitle;

  Sub({this.id, this.parentId, this.arTitle, this.enTitle});

  Sub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parentId'];
    arTitle = json['arTitle'];
    enTitle = json['enTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    data['arTitle'] = this.arTitle;
    data['enTitle'] = this.enTitle;
    return data;
  }
}

class Gender {
  List<String>? arabic;
  List<String>? english;

  Gender({this.arabic, this.english});

  Gender.fromJson(Map<String, dynamic> json) {
    arabic = json['arabic'].cast<String>();
    english = json['English'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arabic'] = this.arabic;
    data['English'] = this.english;
    return data;
  }
}

class Post {
  String? categoryId;
  String? customerId;
  String? enTitle;
  String? arTitle;
  String? enDetails;
  String? arDetails;
  String? price;
  String? date;
  String? age;
  String? ageType;
  String? gender;
  String? video;
  List<String>? image;
  List<String>? imageId;

  Post(
      {this.categoryId,
        this.customerId,
        this.enTitle,
        this.arTitle,
        this.enDetails,
        this.arDetails,
        this.price,
        this.date,
        this.age,
        this.ageType,
        this.gender,
        this.video,
        this.image,
        this.imageId});

  Post.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    customerId = json['customerId'];
    enTitle = json['enTitle'];
    arTitle = json['arTitle'];
    enDetails = json['enDetails'];
    arDetails = json['arDetails'];
    price = json['price'];
    date = json['date'];
    age = json['age'];
    ageType = json['ageType'];
    gender = json['gender'];
    video = json['video'];
    image = json['image'].cast<String>();
    imageId = json['imageId'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['customerId'] = this.customerId;
    data['enTitle'] = this.enTitle;
    data['arTitle'] = this.arTitle;
    data['enDetails'] = this.enDetails;
    data['arDetails'] = this.arDetails;
    data['price'] = this.price;
    data['date'] = this.date;
    data['age'] = this.age;
    data['ageType'] = this.ageType;
    data['gender'] = this.gender;
    data['video'] = this.video;
    data['image'] = this.image;
    data['imageId'] = this.imageId;
    return data;
  }
}
