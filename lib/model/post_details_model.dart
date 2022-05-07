class PostDetailsModel {
  bool ok;
  String error;
  String status;
  Data data;

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
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<Items> items;

  Data({this.items});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String id;
  String arTitle;
  String enTitle;
  String arDetails;
  String enDetails;
  String video;
  String age;
  String price;
  String gender;
  String ageType;
  String shares;
  String views;
  String mobile;
  List<String> image;

  Items(
      {this.id,
        this.arTitle,
        this.enTitle,
        this.arDetails,
        this.enDetails,
        this.video,
        this.age,
        this.price,
        this.gender,
        this.ageType,
        this.shares,
        this.views,
        this.mobile,
        this.image});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arTitle = json['arTitle'];
    enTitle = json['enTitle'];
    arDetails = json['arDetails'];
    enDetails = json['enDetails'];
    video = json['video'];
    age = json['age'];
    price = json['price'];
    gender = json['gender'];
    ageType = json['ageType'];
    shares = json['shares'];
    views = json['views'];
    mobile = json['mobile'];
    image = json['image'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arTitle'] = this.arTitle;
    data['enTitle'] = this.enTitle;
    data['arDetails'] = this.arDetails;
    data['enDetails'] = this.enDetails;
    data['video'] = this.video;
    data['age'] = this.age;
    data['price'] = this.price;
    data['gender'] = this.gender;
    data['ageType'] = this.ageType;
    data['shares'] = this.shares;
    data['views'] = this.views;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    return data;
  }
}
