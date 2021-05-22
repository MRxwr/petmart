/// status : "success"
/// message : "Hospital details retrived."
/// data : {"hospital_id":"1","name_english":"Test Hospital","name_arabic":"Test Hospital","details_english":" Test HospitalTest HospitalTest HospitalTest HospitalTest HospitalTest Hospital","details_arabic":"Test HospitalTest HospitalTest HospitalTest HospitalTest HospitalTest HospitalTest Hospital","phone_number":"9475359786","logo_image":"st_1.jpg","most_view":"181","shared":"19","status":"enable","owner_id":"0","created_at":"2021-03-24 06:23:06","updated_at":"2021-03-24 07:05:17"}

class HospitalDetailsModel {
  String _status;
  String _message;
  Data _data;

  String get status => _status;
  String get message => _message;
  Data get data => _data;

  HospitalDetailsModel({
      String status, 
      String message, 
      Data data}){
    _status = status;
    _message = message;
    _data = data;
}

  HospitalDetailsModel.fromJson(dynamic json) {
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

/// hospital_id : "1"
/// name_english : "Test Hospital"
/// name_arabic : "Test Hospital"
/// details_english : " Test HospitalTest HospitalTest HospitalTest HospitalTest HospitalTest Hospital"
/// details_arabic : "Test HospitalTest HospitalTest HospitalTest HospitalTest HospitalTest HospitalTest Hospital"
/// phone_number : "9475359786"
/// logo_image : "st_1.jpg"
/// most_view : "181"
/// shared : "19"
/// status : "enable"
/// owner_id : "0"
/// created_at : "2021-03-24 06:23:06"
/// updated_at : "2021-03-24 07:05:17"

class Data {
  String _hospitalId;
  String _nameEnglish;
  String _nameArabic;
  String _detailsEnglish;
  String _detailsArabic;
  String _phoneNumber;
  String _logoImage;
  String _mostView;
  String _shared;
  String _status;
  String _ownerId;
  String _createdAt;
  String _updatedAt;

  String get hospitalId => _hospitalId;
  String get nameEnglish => _nameEnglish;
  String get nameArabic => _nameArabic;
  String get detailsEnglish => _detailsEnglish;
  String get detailsArabic => _detailsArabic;
  String get phoneNumber => _phoneNumber;
  String get logoImage => _logoImage;
  String get mostView => _mostView;
  String get shared => _shared;
  String get status => _status;
  String get ownerId => _ownerId;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Data({
      String hospitalId, 
      String nameEnglish, 
      String nameArabic, 
      String detailsEnglish, 
      String detailsArabic, 
      String phoneNumber, 
      String logoImage, 
      String mostView, 
      String shared, 
      String status, 
      String ownerId, 
      String createdAt, 
      String updatedAt}){
    _hospitalId = hospitalId;
    _nameEnglish = nameEnglish;
    _nameArabic = nameArabic;
    _detailsEnglish = detailsEnglish;
    _detailsArabic = detailsArabic;
    _phoneNumber = phoneNumber;
    _logoImage = logoImage;
    _mostView = mostView;
    _shared = shared;
    _status = status;
    _ownerId = ownerId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _hospitalId = json["hospital_id"];
    _nameEnglish = json["name_english"];
    _nameArabic = json["name_arabic"];
    _detailsEnglish = json["details_english"];
    _detailsArabic = json["details_arabic"];
    _phoneNumber = json["phone_number"];
    _logoImage = json["logo_image"];
    _mostView = json["most_view"];
    _shared = json["shared"];
    _status = json["status"];
    _ownerId = json["owner_id"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["hospital_id"] = _hospitalId;
    map["name_english"] = _nameEnglish;
    map["name_arabic"] = _nameArabic;
    map["details_english"] = _detailsEnglish;
    map["details_arabic"] = _detailsArabic;
    map["phone_number"] = _phoneNumber;
    map["logo_image"] = _logoImage;
    map["most_view"] = _mostView;
    map["shared"] = _shared;
    map["status"] = _status;
    map["owner_id"] = _ownerId;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }

}