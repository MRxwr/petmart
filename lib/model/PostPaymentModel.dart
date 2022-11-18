import 'Data.dart';

class PostPaymentModel {
  PostPaymentModel({
      this.ok, 
      this.error, 
      this.status, 
      this.data,});

  PostPaymentModel.fromJson(dynamic json) {
    ok = json['ok'];
    error = json['error'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool ok;
  String error;
  String status;
  Data data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ok'] = ok;
    map['error'] = error;
    map['status'] = status;
    if (data != null) {
      map['data'] = data.toJson();
    }
    return map;
  }

}