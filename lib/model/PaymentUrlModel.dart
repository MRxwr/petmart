/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"url":"https://demo.MyFatoorah.com/En/KWT/PayInvoice/Checkout?invoiceKey=01072141545541&paymentGatewayId=20","id":1415455}

class PaymentUrlModel {
  PaymentUrlModel({
      bool ok, 
      String error, 
      String status, 
      Data data,}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  PaymentUrlModel.fromJson(dynamic json) {
    _ok = json['ok'];
    _error = json['error'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool _ok;
  String _error;
  String _status;
  Data _data;
PaymentUrlModel copyWith({  bool ok,
  String error,
  String status,
  Data data,
}) => PaymentUrlModel(  ok: ok ?? _ok,
  error: error ?? _error,
  status: status ?? _status,
  data: data ?? _data,
);
  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ok'] = _ok;
    map['error'] = _error;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// url : "https://demo.MyFatoorah.com/En/KWT/PayInvoice/Checkout?invoiceKey=01072141545541&paymentGatewayId=20"
/// id : 1415455

class Data {
  Data({
      String url, 
      int id,}){
    _url = url;
    _id = id;
}

  Data.fromJson(dynamic json) {
    _url = json['url'];
    _id = json['id'];
  }
  String _url;
  int _id;
Data copyWith({  String url,
  int id,
}) => Data(  url: url ?? _url,
  id: id ?? _id,
);
  String get url => _url;
  int get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['id'] = _id;
    return map;
  }

}