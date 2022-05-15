/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"services":[{"id":"1","arTitle":"ماركة","enTitle":"MARKA","arDetails":"قد لمعت عيناه بالعزم انتفضت يمناه في هدوؤ الليل","enDetails":"Hunter is always online dont touch him","shares":"14","views":"66","mobile":"90949089","logo":"a8c0ac1d01097da379f7574ee3200bda.png"}]}

class ServicesModel {
  ServicesModel({
      bool ok, 
      String error, 
      String status, 
      Data data,}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  ServicesModel.fromJson(dynamic json) {
    _ok = json['ok'];
    _error = json['error'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool _ok;
  String _error;
  String _status;
  Data _data;
ServicesModel copyWith({  bool ok,
  String error,
  String status,
  Data data,
}) => ServicesModel(  ok: ok ?? _ok,
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

/// services : [{"id":"1","arTitle":"ماركة","enTitle":"MARKA","arDetails":"قد لمعت عيناه بالعزم انتفضت يمناه في هدوؤ الليل","enDetails":"Hunter is always online dont touch him","shares":"14","views":"66","mobile":"90949089","logo":"a8c0ac1d01097da379f7574ee3200bda.png"}]

class Data {
  Data({
      List<Services> services,}){
    _services = services;
}

  Data.fromJson(dynamic json) {
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services.add(Services.fromJson(v));
      });
    }
  }
  List<Services> _services;
Data copyWith({  List<Services> services,
}) => Data(  services: services ?? _services,
);
  List<Services> get services => _services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_services != null) {
      map['services'] = _services.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// arTitle : "ماركة"
/// enTitle : "MARKA"
/// arDetails : "قد لمعت عيناه بالعزم انتفضت يمناه في هدوؤ الليل"
/// enDetails : "Hunter is always online dont touch him"
/// shares : "14"
/// views : "66"
/// mobile : "90949089"
/// logo : "a8c0ac1d01097da379f7574ee3200bda.png"

class Services {
  Services({
      String id, 
      String arTitle, 
      String enTitle, 
      String arDetails, 
      String enDetails, 
      String shares, 
      String views, 
      String mobile, 
      String logo,}){
    _id = id;
    _arTitle = arTitle;
    _enTitle = enTitle;
    _arDetails = arDetails;
    _enDetails = enDetails;
    _shares = shares;
    _views = views;
    _mobile = mobile;
    _logo = logo;
}

  Services.fromJson(dynamic json) {
    _id = json['id'];
    _arTitle = json['arTitle'];
    _enTitle = json['enTitle'];
    _arDetails = json['arDetails'];
    _enDetails = json['enDetails'];
    _shares = json['shares'];
    _views = json['views'];
    _mobile = json['mobile'];
    _logo = json['logo'];
  }
  String _id;
  String _arTitle;
  String _enTitle;
  String _arDetails;
  String _enDetails;
  String _shares;
  String _views;
  String _mobile;
  String _logo;
Services copyWith({  String id,
  String arTitle,
  String enTitle,
  String arDetails,
  String enDetails,
  String shares,
  String views,
  String mobile,
  String logo,
}) => Services(  id: id ?? _id,
  arTitle: arTitle ?? _arTitle,
  enTitle: enTitle ?? _enTitle,
  arDetails: arDetails ?? _arDetails,
  enDetails: enDetails ?? _enDetails,
  shares: shares ?? _shares,
  views: views ?? _views,
  mobile: mobile ?? _mobile,
  logo: logo ?? _logo,
);
  String get id => _id;
  String get arTitle => _arTitle;
  String get enTitle => _enTitle;
  String get arDetails => _arDetails;
  String get enDetails => _enDetails;
  String get shares => _shares;
  String get views => _views;
  String get mobile => _mobile;
  String get logo => _logo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['arTitle'] = _arTitle;
    map['enTitle'] = _enTitle;
    map['arDetails'] = _arDetails;
    map['enDetails'] = _enDetails;
    map['shares'] = _shares;
    map['views'] = _views;
    map['mobile'] = _mobile;
    map['logo'] = _logo;
    return map;
  }

}