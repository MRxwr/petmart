/// ok : false
/// error : "1"
/// status : "Error"
/// data : {"msg":"A user with this email is already registred."}

class ErrorModel {
  ErrorModel({
      bool ok, 
      String error, 
      String status, 
      Data data,}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  ErrorModel.fromJson(dynamic json) {
    _ok = json['ok'];
    _error = json['error'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool _ok;
  String _error;
  String _status;
  Data _data;
ErrorModel copyWith({  bool ok,
  String error,
  String status,
  Data data,
}) => ErrorModel(  ok: ok ?? _ok,
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

/// msg : "A user with this email is already registred."

class Data {
  Data({
      String msg,}){
    _msg = msg;
}

  Data.fromJson(dynamic json) {
    _msg = json['msg'];
  }
  String _msg;
Data copyWith({  String msg,
}) => Data(  msg: msg ?? _msg,
);
  String get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    return map;
  }

}