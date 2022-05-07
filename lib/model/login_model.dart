class LoginModel {
  bool ok;
  String error;
  String status;
  Data data;

  LoginModel({this.ok, this.error, this.status, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String id;
  String points;
  String validity;

  Data({this.id, this.points, this.validity});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    points = json['points'];
    validity = json['validity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['points'] = this.points;
    data['validity'] = this.validity;
    return data;
  }
}