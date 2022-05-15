/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"live":[{"id":"1","endDate":"2022-05-16 16:12:22","enTitle":"test auction","arTitle":"test auction","image":"","images":0}],"done":[{"id":"2","endDate":"2022-05-16 16:12:22","enTitle":"test auction","arTitle":"test auction","image":"","images":0}],"cancel":[{"id":"3","endDate":"2022-05-16 16:12:22","enTitle":"test auction","arTitle":"test auction","image":"9775ecb7e1d4d5df3c1b066a4979ab92.png","images":1}]}

class MyNewAuctionModel {
  MyNewAuctionModel({
      bool ok, 
      String error, 
      String status, 
      Data data,}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  MyNewAuctionModel.fromJson(dynamic json) {
    _ok = json['ok'];
    _error = json['error'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool _ok;
  String _error;
  String _status;
  Data _data;
MyNewAuctionModel copyWith({  bool ok,
  String error,
  String status,
  Data data,
}) => MyNewAuctionModel(  ok: ok ?? _ok,
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

/// live : [{"id":"1","endDate":"2022-05-16 16:12:22","enTitle":"test auction","arTitle":"test auction","image":"","images":0}]
/// done : [{"id":"2","endDate":"2022-05-16 16:12:22","enTitle":"test auction","arTitle":"test auction","image":"","images":0}]
/// cancel : [{"id":"3","endDate":"2022-05-16 16:12:22","enTitle":"test auction","arTitle":"test auction","image":"9775ecb7e1d4d5df3c1b066a4979ab92.png","images":1}]

class Data {
  Data({
      List<Live> live, 
      List<Live> done,
      List<Live> cancel,}){
    _live = live;
    _done = done;
    _cancel = cancel;
}

  Data.fromJson(dynamic json) {
    if (json['live'] != null) {
      _live = [];
      json['live'].forEach((v) {
        _live.add(Live.fromJson(v));
      });
    }
    if (json['done'] != null) {
      _done = [];
      json['done'].forEach((v) {
        _done.add(Live.fromJson(v));
      });
    }
    if (json['cancel'] != null) {
      _cancel = [];
      json['cancel'].forEach((v) {
        _cancel.add(Live.fromJson(v));
      });
    }
  }
  List<Live> _live;
  List<Live> _done;
  List<Live> _cancel;
Data copyWith({  List<Live> live,
  List<Live> done,
  List<Live> cancel,
}) => Data(  live: live ?? _live,
  done: done ?? _done,
  cancel: cancel ?? _cancel,
);
  List<Live> get live => _live;
  List<Live> get done => _done;
  List<Live> get cancel => _cancel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_live != null) {
      map['live'] = _live.map((v) => v.toJson()).toList();
    }
    if (_done != null) {
      map['done'] = _done.map((v) => v.toJson()).toList();
    }
    if (_cancel != null) {
      map['cancel'] = _cancel.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "3"
/// endDate : "2022-05-16 16:12:22"
/// enTitle : "test auction"
/// arTitle : "test auction"
/// image : "9775ecb7e1d4d5df3c1b066a4979ab92.png"
/// images : 1

class Cancel {
  Cancel({
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

  Cancel.fromJson(dynamic json) {
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
Cancel copyWith({  String id,
  String endDate,
  String enTitle,
  String arTitle,
  String image,
  int images,
}) => Cancel(  id: id ?? _id,
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

/// id : "2"
/// endDate : "2022-05-16 16:12:22"
/// enTitle : "test auction"
/// arTitle : "test auction"
/// image : ""
/// images : 0

class Done {
  Done({
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

  Done.fromJson(dynamic json) {
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
Done copyWith({  String id,
  String endDate,
  String enTitle,
  String arTitle,
  String image,
  int images,
}) => Done(  id: id ?? _id,
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

/// id : "1"
/// endDate : "2022-05-16 16:12:22"
/// enTitle : "test auction"
/// arTitle : "test auction"
/// image : ""
/// images : 0

class Live {
  Live({
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

  Live.fromJson(dynamic json) {
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
Live copyWith({  String id,
  String endDate,
  String enTitle,
  String arTitle,
  String image,
  int images,
}) => Live(  id: id ?? _id,
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