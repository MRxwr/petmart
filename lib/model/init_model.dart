/// status : "success"
/// message : "Initialization detail found."
/// data : {"contact_id":"1","name":"Pet Mart","email":"info@petmart.com","mobile":"9856124578","gender_list":[{"id":"1","name":"Male"},{"id":"2","name":"Female"},{"id":"3","name":"Couple"},{"id":"4","name":"Not Applicable"}],"age":[{"id":"1","name":"Weeks"},{"id":"2","name":"Days"},{"id":"3","name":"Month"},{"id":"4","name":"Year"}],"shop_url":"http://petmart.createkwservers.com/media/shop/shop.png","adoption_url":"http://petmart.createkwservers.com/media/adoption/adoption.png"}

class InitModel {
  String _status;
  String _message;
  Data _data;

  String get status => _status;
  String get message => _message;
  Data get data => _data;

  InitModel({
      String status, 
      String message, 
      Data data}){
    _status = status;
    _message = message;
    _data = data;
}

  InitModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// contact_id : "1"
/// name : "Pet Mart"
/// email : "info@petmart.com"
/// mobile : "9856124578"
/// gender_list : [{"id":"1","name":"Male"},{"id":"2","name":"Female"},{"id":"3","name":"Couple"},{"id":"4","name":"Not Applicable"}]
/// age : [{"id":"1","name":"Weeks"},{"id":"2","name":"Days"},{"id":"3","name":"Month"},{"id":"4","name":"Year"}]
/// shop_url : "http://petmart.createkwservers.com/media/shop/shop.png"
/// adoption_url : "http://petmart.createkwservers.com/media/adoption/adoption.png"

class Data {
  String _contactId;
  String _name;
  String _email;
  String _mobile;
  List<Gender_list> _genderList;
  List<Age> _age;
  String _shopUrl;
  String _adoptionUrl;

  String get contactId => _contactId;
  String get name => _name;
  String get email => _email;
  String get mobile => _mobile;
  List<Gender_list> get genderList => _genderList;
  List<Age> get age => _age;
  String get shopUrl => _shopUrl;
  String get adoptionUrl => _adoptionUrl;

  Data({
      String contactId, 
      String name, 
      String email, 
      String mobile, 
      List<Gender_list> genderList, 
      List<Age> age, 
      String shopUrl, 
      String adoptionUrl}){
    _contactId = contactId;
    _name = name;
    _email = email;
    _mobile = mobile;
    _genderList = genderList;
    _age = age;
    _shopUrl = shopUrl;
    _adoptionUrl = adoptionUrl;
}

  Data.fromJson(dynamic json) {
    _contactId = json["contact_id"];
    _name = json["name"];
    _email = json["email"];
    _mobile = json["mobile"];
    if (json["gender_list"] != null) {
      _genderList = [];
      json["gender_list"].forEach((v) {
        _genderList.add(Gender_list.fromJson(v));
      });
    }
    if (json["age"] != null) {
      _age = [];
      json["age"].forEach((v) {
        _age.add(Age.fromJson(v));
      });
    }
    _shopUrl = json["shop_url"];
    _adoptionUrl = json["adoption_url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["contact_id"] = _contactId;
    map["name"] = _name;
    map["email"] = _email;
    map["mobile"] = _mobile;
    if (_genderList != null) {
      map["gender_list"] = _genderList.map((v) => v.toJson()).toList();
    }
    if (_age != null) {
      map["age"] = _age.map((v) => v.toJson()).toList();
    }
    map["shop_url"] = _shopUrl;
    map["adoption_url"] = _adoptionUrl;
    return map;
  }

}

/// id : "1"
/// name : "Weeks"

class Age {
  String _id;
  String _name;

  String get id => _id;
  String get name => _name;

  Age({
      String id, 
      String name}){
    _id = id;
    _name = name;
}

  Age.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}

/// id : "1"
/// name : "Male"

class Gender_list {
  String _id;
  String _name;

  String get id => _id;
  String get name => _name;

  Gender_list({
      String id, 
      String name}){
    _id = id;
    _name = name;
}

  Gender_list.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}