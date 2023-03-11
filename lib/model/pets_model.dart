class PetsModel {
  bool? ok;
  String? error;
  String? status;
  Data? data;

  PetsModel({this.ok, this.error, this.status, this.data});

  PetsModel.fromJson(Map<String, dynamic> json) {
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
  String? arTitle;
  String? enTitle;
  String? price;
  String? date;
  String? image;
  int? images;

  Items(
      {this.id,
        this.arTitle,
        this.enTitle,
        this.price,
        this.date,
        this.image,
        this.images});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arTitle = json['arTitle'];
    enTitle = json['enTitle'];
    price = json['price'];
    date = json['date'];
    image = json['image'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arTitle'] = this.arTitle;
    data['enTitle'] = this.enTitle;
    data['price'] = this.price;
    data['date'] = this.date;
    data['image'] = this.image;
    data['images'] = this.images;
    return data;
  }
}
