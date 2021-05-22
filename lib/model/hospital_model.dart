/// status : "success"
/// message : "Shop data retrived."
/// data : [{"shop_id":"1","shop_name":"Pet Zone","shop_image":"http://petmart.createkwservers.com/media/images/shop/8949flourish_pet_products-dribble.png"},{"shop_id":"2","shop_name":"Pet House","shop_image":"http://petmart.createkwservers.com/media/images/shop/17790picture13916020272337.jpg"},{"shop_id":"3","shop_name":"Wow Shop ","shop_image":"http://petmart.createkwservers.com/media/images/no-image.jpg"},{"shop_id":"4","shop_name":"Wow Shop","shop_image":"http://petmart.createkwservers.com/media/images/no-image.jpg"},{"shop_id":"5","shop_name":"Wow Shop","shop_image":"http://petmart.createkwservers.com/media/images/no-image.jpg"},{"shop_id":"6","shop_name":"jio shop ","shop_image":"http://petmart.createkwservers.com/media/images/no-image.jpg"}]

class HospitalModel {
  String _status;
  String _message;
  List<Data> _data;

  String get status => _status;
  String get message => _message;
  List<Data> get data => _data;

  HospitalModel({
      String status, 
      String message, 
      List<Data> data}){
    _status = status;
    _message = message;
    _data = data;
}

  HospitalModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// shop_id : "1"
/// shop_name : "Pet Zone"
/// shop_image : "http://petmart.createkwservers.com/media/images/shop/8949flourish_pet_products-dribble.png"

class Data {
  String _shopId;
  String _shopName;
  String _shopImage;

  String get shopId => _shopId;
  String get shopName => _shopName;
  String get shopImage => _shopImage;

  Data({
      String shopId, 
      String shopName, 
      String shopImage}){
    _shopId = shopId;
    _shopName = shopName;
    _shopImage = shopImage;
}

  Data.fromJson(dynamic json) {
    _shopId = json["shop_id"];
    _shopName = json["shop_name"];
    _shopImage = json["shop_image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["shop_id"] = _shopId;
    map["shop_name"] = _shopName;
    map["shop_image"] = _shopImage;
    return map;
  }

}