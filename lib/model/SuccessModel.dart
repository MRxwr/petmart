/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"orderId":"1415460","status":"success"}

class SuccessModel {
  SuccessModel({
      bool? ok,
    String? error,
    String? status,
      Data? data,}){
    _ok = ok!;
    _error = error!;
    _status = status!;
    _data = data!;
}

  SuccessModel.fromJson(dynamic json) {
    _ok = json['ok'];
    _error = json['error'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _ok;
  String? _error;
  String? _status;
  Data? _data;
SuccessModel copyWith({  bool? ok,
  String? error,
  String? status,
  Data? data,
}) => SuccessModel(  ok: ok ?? _ok,
  error: error ?? _error,
  status: status ?? _status,
  data: data ?? _data,
);
  bool get ok => _ok!;
  String get error => _error!;
  String get status => _status!;
  Data get data => _data!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ok'] = _ok;
    map['error'] = _error;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data!.toJson();
    }
    return map;
  }

}

/// orderId : "1415460"
/// status : "success"

class Data {
  Data({
    String? orderId,
    String? status,}){
    _orderId = orderId!;
    _status = status!;
}

  Data.fromJson(dynamic json) {
    _orderId = json['orderId'];
    _status = json['status'];
  }
  String? _orderId;
  String? _status;
Data copyWith({  String? orderId,
  String? status,
}) => Data(  orderId: orderId ?? _orderId,
  status: status ?? _status,
);
  String get orderId => _orderId!;
  String get status => _status!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = _orderId;
    map['status'] = _status;
    return map;
  }

}