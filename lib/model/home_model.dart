class HomeModel {
  bool ok;
  String error;
  String status;
  Data data;

  HomeModel({this.ok, this.error, this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  List<Banners> banners;
  List<Categories> categories;

  Data({this.banners, this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String id;
  String enTitle;
  String arTitle;
  String image;
  String url;
  String type;

  Banners(
      {this.id, this.enTitle, this.arTitle, this.image, this.url, this.type});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enTitle = json['enTitle'];
    arTitle = json['arTitle'];
    image = json['image'];
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enTitle'] = this.enTitle;
    data['arTitle'] = this.arTitle;
    data['image'] = this.image;
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}

class Categories {
  String id;
  String enTitle;
  String arTitle;
  String logo;

  Categories({this.id, this.enTitle, this.arTitle, this.logo});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enTitle = json['enTitle'];
    arTitle = json['arTitle'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enTitle'] = this.enTitle;
    data['arTitle'] = this.arTitle;
    data['logo'] = this.logo;
    return data;
  }
}