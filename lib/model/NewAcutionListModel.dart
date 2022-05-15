/// ok : true
/// error : "0"
/// status : "successful"
/// data : [{"id":"1","endDate":"2022-05-16 16:12:22","enTitle":"test auction","arTitle":"test auction","image":"","images":0}]

class NewAcutionListModel {
  NewAcutionListModel({
      bool ok, 
      String error, 
      String status, 
      List<Data> data,}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  NewAcutionListModel.fromJson(dynamic json) {
    _ok = json['ok'];
    _error = json['error'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }
  bool _ok;
  String _error;
  String _status;
  List<Data> _data;
NewAcutionListModel copyWith({  bool ok,
  String error,
  String status,
  List<Data> data,
}) => NewAcutionListModel(  ok: ok ?? _ok,
  error: error ?? _error,
  status: status ?? _status,
  data: data ?? _data,
);
  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  List<Data> get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ok'] = _ok;
    map['error'] = _error;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// endDate : "2022-05-16 16:12:22"
/// enTitle : "test auction"
/// arTitle : "test auction"
/// image : ""
/// images : 0

class Data {
  Data({
      String id, 
      String endDate, 
      String enTitle, 
      String arTitle, 
      String image, 
      int images,}){
    _id = id;
    _endDate = endDate;
    _enTitle = enTitle;
    _arTitle = arTitle;
    _image = image;
    _images = images;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _endDate = json['endDate'];
    _enTitle = json['enTitle'];
    _arTitle = json['arTitle'];
    _image = json['image'];
    _images = json['images'];
  }
  String _id;
  String _endDate;
  String _enTitle;
  String _arTitle;
  String _image;
  int _images;
Data copyWith({  String id,
  String endDate,
  String enTitle,
  String arTitle,
  String image,
  int images,
}) => Data(  id: id ?? _id,
  endDate: endDate ?? _endDate,
  enTitle: enTitle ?? _enTitle,
  arTitle: arTitle ?? _arTitle,
  image: image ?? _image,
  images: images ?? _images,
);
  String get id => _id;
  String get endDate => _endDate;
  String get enTitle => _enTitle;
  String get arTitle => _arTitle;
  String get image => _image;
  int get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['endDate'] = _endDate;
    map['enTitle'] = _enTitle;
    map['arTitle'] = _arTitle;
    map['image'] = _image;
    map['images'] = _images;
    return map;
  }

}