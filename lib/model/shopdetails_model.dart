/// status : "success"
/// message : "Shop Data Retrived"
/// data : [{"shop_id":"2","shop_name":"Pet House","shop_image":"http://petmart.createkwservers.com/media/images/shop/17790picture13916020272337.jpg"}]

class ShopdetailsModel {
  String _status;
  String _message;
  List<Data> _data;

  String get status => _status;
  String get message => _message;
  List<Data> get data => _data;

  ShopdetailsModel({
      String status, 
      String message, 
      List<Data> data}){
    _status = status;
    _message = message;
    _data = data;
}

  ShopdetailsModel.fromJson(dynamic json) {
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

/// shop_id : "2"
/// shop_name : "Pet House"
/// shop_image : "http://petmart.createkwservers.com/media/images/shop/17790picture13916020272337.jpg"

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