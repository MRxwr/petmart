/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"items":{"sale":[{"id":"36","arTitle":"تجربة","enTitle":"Test","price":"Test","date":"Test","image":"1ee3117795125e0eb2e3abc0111bde1d.jpg","images":2}],"lost":[{"id":"15","arTitle":"تجربة","enTitle":"Test","price":"Test","date":"Test","image":"6c27cb204ef59d6bf6f043cf17d8b686.png","images":1}],"adoption":[{"id":"36","arTitle":"تجربة","enTitle":"Test","price":"Test","date":"Test","image":"1ee3117795125e0eb2e3abc0111bde1d.jpg","images":2}]}}

class MyPostsModel {
  MyPostsModel({
      bool ok, 
      String error, 
      String status, 
      Data data,}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  MyPostsModel.fromJson(dynamic json) {
    _ok = json['ok'];
    _error = json['error'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool _ok;
  String _error;
  String _status;
  Data _data;
MyPostsModel copyWith({  bool ok,
  String error,
  String status,
  Data data,
}) => MyPostsModel(  ok: ok ?? _ok,
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

/// items : {"sale":[{"id":"36","arTitle":"تجربة","enTitle":"Test","price":"Test","date":"Test","image":"1ee3117795125e0eb2e3abc0111bde1d.jpg","images":2}],"lost":[{"id":"15","arTitle":"تجربة","enTitle":"Test","price":"Test","date":"Test","image":"6c27cb204ef59d6bf6f043cf17d8b686.png","images":1}],"adoption":[{"id":"36","arTitle":"تجربة","enTitle":"Test","price":"Test","date":"Test","image":"1ee3117795125e0eb2e3abc0111bde1d.jpg","images":2}]}

class Data {
  Data({
      Items items,}){
    _items = items;
}

  Data.fromJson(dynamic json) {
    _items = json['items'] != null ? Items.fromJson(json['items']) : null;
  }
  Items _items;
Data copyWith({  Items items,
}) => Data(  items: items ?? _items,
);
  Items get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_items != null) {
      map['items'] = _items.toJson();
    }
    return map;
  }

}

/// sale : [{"id":"36","arTitle":"تجربة","enTitle":"Test","price":"Test","date":"Test","image":"1ee3117795125e0eb2e3abc0111bde1d.jpg","images":2}]
/// lost : [{"id":"15","arTitle":"تجربة","enTitle":"Test","price":"Test","date":"Test","image":"6c27cb204ef59d6bf6f043cf17d8b686.png","images":1}]
/// adoption : [{"id":"36","arTitle":"تجربة","enTitle":"Test","price":"Test","date":"Test","image":"1ee3117795125e0eb2e3abc0111bde1d.jpg","images":2}]

class Items {
  Items({
      List<Sale> sale, 
      List<Sale> lost,
      List<Sale> adoption,}){
    _sale = sale;
    _lost = lost;
    _adoption = adoption;
}

  Items.fromJson(dynamic json) {
    if (json['sale'] != null) {
      _sale = [];
      json['sale'].forEach((v) {
        _sale.add(Sale.fromJson(v));
      });
    }
    if (json['lost'] != null) {
      _lost = [];
      json['lost'].forEach((v) {
        _lost.add(Sale.fromJson(v));
      });
    }
    if (json['adoption'] != null) {
      _adoption = [];
      json['adoption'].forEach((v) {
        _adoption.add(Sale.fromJson(v));
      });
    }
  }
  List<Sale> _sale;
  List<Sale> _lost;
  List<Sale> _adoption;
Items copyWith({  List<Sale> sale,
  List<Sale> lost,
  List<Sale> adoption,
}) => Items(  sale: sale ?? _sale,
  lost: lost ?? _lost,
  adoption: adoption ?? _adoption,
);
  List<Sale> get sale => _sale;
  List<Sale> get lost => _lost;
  List<Sale> get adoption => _adoption;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_sale != null) {
      map['sale'] = _sale.map((v) => v.toJson()).toList();
    }
    if (_lost != null) {
      map['lost'] = _lost.map((v) => v.toJson()).toList();
    }
    if (_adoption != null) {
      map['adoption'] = _adoption.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "36"
/// arTitle : "تجربة"
/// enTitle : "Test"
/// price : "Test"
/// date : "Test"
/// image : "1ee3117795125e0eb2e3abc0111bde1d.jpg"
/// images : 2



/// id : "36"
/// arTitle : "تجربة"
/// enTitle : "Test"
/// price : "Test"
/// date : "Test"
/// image : "1ee3117795125e0eb2e3abc0111bde1d.jpg"
/// images : 2

class Sale {
  Sale({
      String id, 
      String arTitle, 
      String enTitle, 
      String price, 
      String date, 
      String image, 
      int images,}){
    _id = id;
    _arTitle = arTitle;
    _enTitle = enTitle;
    _price = price;
    _date = date;
    _image = image;
    _images = images;
}

  Sale.fromJson(dynamic json) {
    _id = json['id'];
    _arTitle = json['arTitle'];
    _enTitle = json['enTitle'];
    _price = json['price'];
    _date = json['date'];
    _image = json['image'];
    _images = json['images'];
  }
  String _id;
  String _arTitle;
  String _enTitle;
  String _price;
  String _date;
  String _image;
  int _images;
Sale copyWith({  String id,
  String arTitle,
  String enTitle,
  String price,
  String date,
  String image,
  int images,
}) => Sale(  id: id ?? _id,
  arTitle: arTitle ?? _arTitle,
  enTitle: enTitle ?? _enTitle,
  price: price ?? _price,
  date: date ?? _date,
  image: image ?? _image,
  images: images ?? _images,
);
  String get id => _id;
  String get arTitle => _arTitle;
  String get enTitle => _enTitle;
  String get price => _price;
  String get date => _date;
  String get image => _image;
  int get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['arTitle'] = _arTitle;
    map['enTitle'] = _enTitle;
    map['price'] = _price;
    map['date'] = _date;
    map['image'] = _image;
    map['images'] = _images;
    return map;
  }

}