class PackageModel {
  bool? ok;
  String? error;
  String? status;
  Data? data;

  PackageModel({this.ok, this.error, this.status, this.data});

  PackageModel.fromJson(Map<String, dynamic> json) {
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
  List<Package>? package;

  Data({this.package});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['package'] != null) {
      package = <Package>[];
      json['package'].forEach((v) {
        package!.add(new Package.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.package != null) {
      data['package'] = this.package!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Package {
  String? id;
  String? arTitle;
  String? enTitle;
  String? arDetails;
  String? enDetails;
  String? points;
  String? validity;
  String? price;
  String? image;

  Package(
      {this.id,
        this.arTitle,
        this.enTitle,
        this.arDetails,
        this.enDetails,
        this.points,
        this.validity,
        this.price,
        this.image});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arTitle = json['arTitle'];
    enTitle = json['enTitle'];
    arDetails = json['arDetails'];
    enDetails = json['enDetails'];
    points = json['points'];
    validity = json['validity'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arTitle'] = this.arTitle;
    data['enTitle'] = this.enTitle;
    data['arDetails'] = this.arDetails;
    data['enDetails'] = this.enDetails;
    data['points'] = this.points;
    data['validity'] = this.validity;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}
