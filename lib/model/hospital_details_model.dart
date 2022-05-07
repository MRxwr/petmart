class HospitalDetailsModel {
  bool ok;
  String error;
  String status;
  Data data;

  HospitalDetailsModel({this.ok, this.error, this.status, this.data});

  HospitalDetailsModel.fromJson(Map<String, dynamic> json) {
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
  List<Hospital> hospital;

  Data({this.hospital});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['hospital'] != null) {
      hospital = <Hospital>[];
      json['hospital'].forEach((v) {
        hospital.add(new Hospital.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hospital != null) {
      data['hospital'] = this.hospital.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hospital {
  String id;
  String arTitle;
  String enTitle;
  String arDetails;
  String enDetails;
  String shares;
  String views;
  String mobile;
  String logo;

  Hospital(
      {this.id,
        this.arTitle,
        this.enTitle,
        this.arDetails,
        this.enDetails,
        this.shares,
        this.views,
        this.mobile,
        this.logo});

  Hospital.fromJson(Map<String, dynamic> json) {
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