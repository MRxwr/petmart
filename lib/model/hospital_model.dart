class HospitalModel {
  bool? ok;
  String? error;
  String? status;
  Data? data;

  HospitalModel({this.ok, this.error, this.status, this.data});

  HospitalModel.fromJson(Map<String, dynamic> json) {
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
  List<Shop>? shop;

  Data({this.shop});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['shop'] != null) {
      shop = <Shop>[];
      json['shop'].forEach((v) {
        shop!.add(new Shop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shop != null) {
      data['shop'] = this.shop!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shop {
  String? id;
  String? arTitle;
  String? enTitle;
  String? arDetails;
  String? enDetails;
  String? shares;
  String? views;
  String? mobile;
  String? logo;

  Shop(
      {this.id,
        this.arTitle,
        this.enTitle,
        this.arDetails,
        this.enDetails,
        this.shares,
        this.views,
        this.mobile,
        this.logo});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arTitle = json['arTitle'];
    enTitle = json['enTitle'];
    arDetails = json['arDetails'];
    enDetails = json['enDetails'];
    shares = json['shares'];
    views = json['views'];
    mobile = json['mobile'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arTitle'] = this.arTitle;
    data['enTitle'] = this.enTitle;
    data['arDetails'] = this.arDetails;
    data['enDetails'] = this.enDetails;
    data['shares'] = this.shares;
    data['views'] = this.views;
    data['mobile'] = this.mobile;
    data['logo'] = this.logo;
    return data;
  }
}
