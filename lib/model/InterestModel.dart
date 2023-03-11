class InterestModel {
  bool? ok;
  String? error;
  String? status;
  List<Data>? data;

  InterestModel({this.ok, this.error, this.status, this.data});

  InterestModel.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    error = json['error'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    data['error'] = this.error;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? enTitle;
  String? arTitle;
  int? interest;

  Data({this.id, this.enTitle, this.arTitle, this.interest});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enTitle = json['enTitle'];
    arTitle = json['arTitle'];
    interest = json['interest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enTitle'] = this.enTitle;
    data['arTitle'] = this.arTitle;
    data['interest'] = this.interest;
    return data;
  }
}
