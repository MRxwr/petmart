/// ok : true
/// error : "0"
/// status : "successful"
/// data : "Added successfully"

class AddInterestModel {
  AddInterestModel({
      bool? ok,
      String? error,
      String? status,
      String? data,}){
    _ok = ok!;
    _error = error!;
    _status = status!;
    _data = data!;
}

  AddInterestModel.fromJson(dynamic json) {
    _ok = json['ok'];
    _error = json['error'];
    _status = json['status'];
    _data = json['data'];
  }
  bool? _ok;
  String? _error;
  String? _status;
  String? _data;
AddInterestModel copyWith({  bool? ok,
  String? error,
  String? status,
  String? data,
}) => AddInterestModel(  ok: ok ?? _ok,
  error: error ?? _error,
  status: status ?? _status,
  data: data ?? _data,
);
  bool get ok => _ok!;
  String get error => _error!;
  String get status => _status!;
  String get data => _data!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ok'] = _ok;
    map['error'] = _error;
    map['status'] = _status;
    map['data'] = _data;
    return map;
  }

}