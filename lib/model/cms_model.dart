class CmsModel {
  bool ok;
  String error;
  String status;
  Data data;

  CmsModel({this.ok, this.error, this.status, this.data});

  CmsModel.fromJson(Map<String, dynamic> json) {
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
  String version;
  String enTerms;
  String arTerms;
  String enPolicy;
  String arPolicy;

  Data(
      {this.version, this.enTerms, this.arTerms, this.enPolicy, this.arPolicy});

  Data.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    enTerms = json['enTerms'];
    arTerms = json['arTerms'];
    enPolicy = json['enPolicy'];
    arPolicy = json['arPolicy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['enTerms'] = this.enTerms;
    data['arTerms'] = this.arTerms;
    data['enPolicy'] = this.enPolicy;
    data['arPolicy'] = this.arPolicy;
    return data;
  }
}