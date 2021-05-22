/// status : "success"
/// message : "Hospital list retrived."
/// data : [{"id":"1","name_english":"Test Hospital","name_arabic":"Test Hospital","most_view":"180","shared":"19","logo_image":"http://petmart.createkwservers.com/media/images/hospital/st_1.jpg"},{"id":"2","name_english":"Pet mart Test ","name_arabic":"بيت مارت تيست","most_view":"129","shared":"11","logo_image":"http://petmart.createkwservers.com/media/images/hospital/05.png"}]

class HospitalsModel {
  String _status;
  String _message;
  List<Data> _data;

  String get status => _status;
  String get message => _message;
  List<Data> get data => _data;

  HospitalsModel({
      String status, 
      String message, 
      List<Data> data}){
    _status = status;
    _message = message;
    _data = data;
}

  HospitalsModel.fromJson(dynamic json) {
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

/// id : "1"
/// name_english : "Test Hospital"
/// name_arabic : "Test Hospital"
/// most_view : "180"
/// shared : "19"
/// logo_image : "http://petmart.createkwservers.com/media/images/hospital/st_1.jpg"

class Data {
  String _id;
  String _nameEnglish;
  String _nameArabic;
  String _mostView;
  String _shared;
  String _logoImage;

  String get id => _id;
  String get nameEnglish => _nameEnglish;
  String get nameArabic => _nameArabic;
  String get mostView => _mostView;
  String get shared => _shared;
  String get logoImage => _logoImage;

  Data({
      String id, 
      String nameEnglish, 
      String nameArabic, 
      String mostView, 
      String shared, 
      String logoImage}){
    _id = id;
    _nameEnglish = nameEnglish;
    _nameArabic = nameArabic;
    _mostView = mostView;
    _shared = shared;
    _logoImage = logoImage;
}

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _nameEnglish = json["name_english"];
    _nameArabic = json["name_arabic"];
    _mostView = json["most_view"];
    _shared = json["shared"];
    _logoImage = json["logo_image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name_english"] = _nameEnglish;
    map["name_arabic"] = _nameArabic;
    map["most_view"] = _mostView;
    map["shared"] = _shared;
    map["logo_image"] = _logoImage;
    return map;
  }

}