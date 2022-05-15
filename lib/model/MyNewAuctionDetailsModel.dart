/// ok : true
/// error : "0"
/// status : "successful"
/// data : [{"id":"3","endDate":"2022-05-16 16:12:22","enTitle":"test auction","arTitle":"test details","price":"3","reach":"6","video":"","status":"2","bids":["1","2","3"],"image":["9775ecb7e1d4d5df3c1b066a4979ab92.png"],"customer":{"name":"Medo Medo","mobile":"45678923","email":"Medo@gmail.com","logo":"","rating":"2"},"bidders":[{"name":"hatab","logo":"d8b87f4e8c3a704a971fd331b68946c8.png","bid":"3","date":"2022-05-14 23:53:09"}]}]

class MyNewAuctionDetailsModel {
  MyNewAuctionDetailsModel({
      bool ok, 
      String error, 
      String status, 
      List<Data> data,}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  MyNewAuctionDetailsModel.fromJson(dynamic json) {
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
MyNewAuctionDetailsModel copyWith({  bool ok,
  String error,
  String status,
  List<Data> data,
}) => MyNewAuctionDetailsModel(  ok: ok ?? _ok,
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

/// id : "3"
/// endDate : "2022-05-16 16:12:22"
/// enTitle : "test auction"
/// arTitle : "test details"
/// price : "3"
/// reach : "6"
/// video : ""
/// status : "2"
/// bids : ["1","2","3"]
/// image : ["9775ecb7e1d4d5df3c1b066a4979ab92.png"]
/// customer : {"name":"Medo Medo","mobile":"45678923","email":"Medo@gmail.com","logo":"","rating":"2"}
/// bidders : [{"name":"hatab","logo":"d8b87f4e8c3a704a971fd331b68946c8.png","bid":"3","date":"2022-05-14 23:53:09"}]

class Data {
  Data({
      String id, 
      String endDate, 
      String enTitle, 
      String arTitle, 
      String price, 
      String reach, 
      String video, 
      String status, 
      List<String> bids, 
      List<String> image, 
      Customer customer, 
      List<Bidders> bidders,}){
    _id = id;
    _endDate = endDate;
    _enTitle = enTitle;
    _arTitle = arTitle;
    _price = price;
    _reach = reach;
    _video = video;
    _status = status;
    _bids = bids;
    _image = image;
    _customer = customer;
    _bidders = bidders;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _endDate = json['endDate'];
    _enTitle = json['enTitle'];
    _arTitle = json['arTitle'];
    _price = json['price'];
    _reach = json['reach'];
    _video = json['video'];
    _status = json['status'];
    _bids = json['bids'] != null ? json['bids'].cast<String>() : [];
    _image = json['image'] != null ? json['image'].cast<String>() : [];
    _customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    if (json['bidders'] != null) {
      _bidders = [];
      json['bidders'].forEach((v) {
        _bidders.add(Bidders.fromJson(v));
      });
    }
  }
  String _id;
  String _endDate;
  String _enTitle;
  String _arTitle;
  String _price;
  String _reach;
  String _video;
  String _status;
  List<String> _bids;
  List<String> _image;
  Customer _customer;
  List<Bidders> _bidders;
Data copyWith({  String id,
  String endDate,
  String enTitle,
  String arTitle,
  String price,
  String reach,
  String video,
  String status,
  List<String> bids,
  List<String> image,
  Customer customer,
  List<Bidders> bidders,
}) => Data(  id: id ?? _id,
  endDate: endDate ?? _endDate,
  enTitle: enTitle ?? _enTitle,
  arTitle: arTitle ?? _arTitle,
  price: price ?? _price,
  reach: reach ?? _reach,
  video: video ?? _video,
  status: status ?? _status,
  bids: bids ?? _bids,
  image: image ?? _image,
  customer: customer ?? _customer,
  bidders: bidders ?? _bidders,
);
  String get id => _id;
  String get endDate => _endDate;
  String get enTitle => _enTitle;
  String get arTitle => _arTitle;
  String get price => _price;
  String get reach => _reach;
  String get video => _video;
  String get status => _status;
  List<String> get bids => _bids;
  List<String> get image => _image;
  Customer get customer => _customer;
  List<Bidders> get bidders => _bidders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['endDate'] = _endDate;
    map['enTitle'] = _enTitle;
    map['arTitle'] = _arTitle;
    map['price'] = _price;
    map['reach'] = _reach;
    map['video'] = _video;
    map['status'] = _status;
    map['bids'] = _bids;
    map['image'] = _image;
    if (_customer != null) {
      map['customer'] = _customer.toJson();
    }
    if (_bidders != null) {
      map['bidders'] = _bidders.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "hatab"
/// logo : "d8b87f4e8c3a704a971fd331b68946c8.png"
/// bid : "3"
/// date : "2022-05-14 23:53:09"

class Bidders {
  Bidders({
      String name, 
      String logo, 
      String bid, 
      String date,}){
    _name = name;
    _logo = logo;
    _bid = bid;
    _date = date;
}

  Bidders.fromJson(dynamic json) {
    _name = json['name'];
    _logo = json['logo'];
    _bid = json['bid'];
    _date = json['date'];
  }
  String _name;
  String _logo;
  String _bid;
  String _date;
Bidders copyWith({  String name,
  String logo,
  String bid,
  String date,
}) => Bidders(  name: name ?? _name,
  logo: logo ?? _logo,
  bid: bid ?? _bid,
  date: date ?? _date,
);
  String get name => _name;
  String get logo => _logo;
  String get bid => _bid;
  String get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['logo'] = _logo;
    map['bid'] = _bid;
    map['date'] = _date;
    return map;
  }

}

/// name : "Medo Medo"
/// mobile : "45678923"
/// email : "Medo@gmail.com"
/// logo : ""
/// rating : "2"

class Customer {
  Customer({
      String name, 
      String mobile, 
      String email, 
      String logo, 
      String rating,}){
    _name = name;
    _mobile = mobile;
    _email = email;
    _logo = logo;
    _rating = rating;
}

  Customer.fromJson(dynamic json) {
    _name = json['name'];
    _mobile = json['mobile'];
    _email = json['email'];
    _logo = json['logo'];
    _rating = json['rating'];
  }
  String _name;
  String _mobile;
  String _email;
  String _logo;
  String _rating;
Customer copyWith({  String name,
  String mobile,
  String email,
  String logo,
  String rating,
}) => Customer(  name: name ?? _name,
  mobile: mobile ?? _mobile,
  email: email ?? _email,
  logo: logo ?? _logo,
  rating: rating ?? _rating,
);
  String get name => _name;
  String get mobile => _mobile;
  String get email => _email;
  String get logo => _logo;
  String get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['logo'] = _logo;
    map['rating'] = _rating;
    return map;
  }

}