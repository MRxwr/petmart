/// status : "success"
/// message : "Pacakges Data Retrived"
/// data : [{"package_id":"1","package_name":"Daily package","package_description":"This package will include one Auctions credit. ","price":"20 KWD","credit":"20","image":"http://petmart.createkwservers.com/media/images/no-image.jpg","duration":"2 Days"},{"package_id":"2","package_name":"Silver","package_description":"Silver package having 5 Auctions credit for 10 days only","price":"3 KWD","credit":"5","image":"http://petmart.createkwservers.com/media/images/no-image.jpg","duration":"10 days"},{"package_id":"3","package_name":"Gold","package_description":"Gold package gives you 10 credits and valid for 20 days","price":"5 KWD","credit":"10","image":"http://petmart.createkwservers.com/media/images/no-image.jpg","duration":"20 days"},{"package_id":"44","package_name":"Basic","package_description":"BasicBasicBasicBasicBasicBasic","price":"55 KWD","credit":"125","image":"http://petmart.createkwservers.com/media/images/no-image.jpg","duration":"1"}]

class PackageModel {
  String _status;
  String _message;
  List<Data> _data;

  String get status => _status;
  String get message => _message;
  List<Data> get data => _data;

  PackageModel({
      String status, 
      String message, 
      List<Data> data}){
    _status = status;
    _message = message;
    _data = data;
}

  PackageModel.fromJson(dynamic json) {
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

/// package_id : "1"
/// package_name : "Daily package"
/// package_description : "This package will include one Auctions credit. "
/// price : "20 KWD"
/// credit : "20"
/// image : "http://petmart.createkwservers.com/media/images/no-image.jpg"
/// duration : "2 Days"

class Data {
  String _packageId;
  String _packageName;
  String _packageDescription;
  String _price;
  String _credit;
  String _image;
  String _duration;

  String get packageId => _packageId;
  String get packageName => _packageName;
  String get packageDescription => _packageDescription;
  String get price => _price;
  String get credit => _credit;
  String get image => _image;
  String get duration => _duration;

  Data({
      String packageId, 
      String packageName, 
      String packageDescription, 
      String price, 
      String credit, 
      String image, 
      String duration}){
    _packageId = packageId;
    _packageName = packageName;
    _packageDescription = packageDescription;
    _price = price;
    _credit = credit;
    _image = image;
    _duration = duration;
}

  Data.fromJson(dynamic json) {
    _packageId = json["package_id"];
    _packageName = json["package_name"];
    _packageDescription = json["package_description"];
    _price = json["price"];
    _credit = json["credit"];
    _image = json["image"];
    _duration = json["duration"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["package_id"] = _packageId;
    map["package_name"] = _packageName;
    map["package_description"] = _packageDescription;
    map["price"] = _price;
    map["credit"] = _credit;
    map["image"] = _image;
    map["duration"] = _duration;
    return map;
  }

}