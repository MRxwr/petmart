class UserModel {
  bool ok;
  String error;
  String status;
  Data data;

  UserModel({this.ok, this.error, this.status, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String name;
  String email;
  String mobile;
  String points;
  String validity;

  Data(
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.points,
        this.validity});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    points = json['points'];
    validity = json['validity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['points'] = this.points;
    data['validity'] = this.validity;
    return data;
  }
}
