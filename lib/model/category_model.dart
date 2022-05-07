class CategoryModel {
  bool ok;
  String error;
  String status;
  Data data;

  CategoryModel({this.ok, this.error, this.status, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
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
  List<Categories> categories;

  Data({this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String id;
  String arTitle;
  String  enTitle;
  String image;

  Categories({this.id, this.arTitle, this.enTitle, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arTitle = json['arTitle'];
    enTitle = json['enTitle'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arTitle'] = this.arTitle;
    data['enTitle'] = this.enTitle;
    data['image'] = this.image;
    return data;
  }
}
