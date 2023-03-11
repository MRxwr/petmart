class PostDetailsModel {
  bool? ok;
  String? error;
  String? status;
  Data? data;

  PostDetailsModel({this.ok, this.error, this.status, this.data});

  PostDetailsModel.fromJson(Map<String, dynamic> json) {
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
  List<Items>? items;

  Data({this.items});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? categoryId;
  String? date;
  String? arTitle;
  String? enTitle;
  String? arDetails;
  String? enDetails;
  String? video;
  String? age;
  String? price;
  String? gender;
  String? genderAr;
  String? ageType;
  String? ageTypeAr;
  String? shares;
  String? views;
  String? mobile;
  List<String>? image;
  List<Similar>? similar;
  Customer? customer;

  Items(
      {this.id,
        this.categoryId,
        this.date,
        this.arTitle,
        this.enTitle,
        this.arDetails,
        this.enDetails,
        this.video,
        this.age,
        this.price,
        this.gender,
        this.genderAr,
        this.ageType,
        this.ageTypeAr,
        this.shares,
        this.views,
        this.mobile,
        this.image,
        this.similar,
        this.customer});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    date = json['date'];
    arTitle = json['arTitle'];
    enTitle = json['enTitle'];
    arDetails = json['arDetails'];
    enDetails = json['enDetails'];
    video = json['video'];
    age = json['age'];
    price = json['price'];
    gender = json['gender'];
    genderAr = json['genderAr'];
    ageType = json['ageType'];
    ageTypeAr = json['ageTypeAr'];
    shares = json['shares'];
    views = json['views'];
    mobile = json['mobile'];
    image = json['image'].cast<String>();
    if (json['similar'] != null) {
      similar = <Similar>[];
      json['similar'].forEach((v) {
        similar!.add(new Similar.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['date'] = this.date;
    data['arTitle'] = this.arTitle;
    data['enTitle'] = this.enTitle;
    data['arDetails'] = this.arDetails;
    data['enDetails'] = this.enDetails;
    data['video'] = this.video;
    data['age'] = this.age;
    data['price'] = this.price;
    data['gender'] = this.gender;
    data['genderAr'] = this.genderAr;
    data['ageType'] = this.ageType;
    data['ageTypeAr'] = this.ageTypeAr;
    data['shares'] = this.shares;
    data['views'] = this.views;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    if (this.similar != null) {
      data['similar'] = this.similar!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Similar {
  String? id;
  String? enTitle;
  String? arTitle;
  String? date;
  String? price;
  String? image;
  int? images;

  Similar(
      {this.id,
        this.enTitle,
        this.arTitle,
        this.date,
        this.price,
        this.image,
        this.images});

  Similar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enTitle = json['enTitle'];
    arTitle = json['arTitle'];
    date = json['date'];
    price = json['price'];
    image = json['image'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enTitle'] = this.enTitle;
    data['arTitle'] = this.arTitle;
    data['date'] = this.date;
    data['price'] = this.price;
    data['image'] = this.image;
    data['images'] = this.images;
    return data;
  }
}

class Customer {
  String? id;
  String? name;
  String? phone;
  String? logo;

  Customer({this.id, this.name, this.phone, this.logo});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['logo'] = this.logo;
    return data;
  }
}
