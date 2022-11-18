class OtpModel {
  bool ok;
  String error;
  String status;
  Data data;

  OtpModel({this.ok, this.error, this.status, this.data});

  OtpModel.fromJson(Map<String, dynamic> json) {
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
  int code;
  String response;

  Data({this.code, this.response});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['response'] = this.response;
    return data;
  }
}
