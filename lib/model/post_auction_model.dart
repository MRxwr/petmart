/// status : "success"
/// message : "Auction has been created."
/// data : [{"auction_id":"347","auction_name":"test","auction_created_date":"29 May at 12:41 PM","bid_start_date":"2021-05-29 00:41:04","bid_end_date":"2021-05-30 00:41","bid_value":"25 KWD","category":"Bird","sub_category":"طيور ناطقة","auction_description":"test","status":"enable","auction_type":"running","image_count":1,"gallery":[{"image":"http://petmart.createkwservers.com/media/images/auction/513619-Screen Shot 2021-05-28 at 6.10.22 PM.png","thumbnail":"http://petmart.createkwservers.com/media/images/auction/513619-Screen Shot 2021-05-28 at 6.10.22 PM.png","type":"image"}]}]

class PostAuctionModel {
  String? _status;
  String? _message;
  List<Data>? _data;

  String get status => _status!;
  String get message => _message!;
  List<Data> get data => _data!;

  PostAuctionModel({
    String? status,
    String? message,
      List<Data>? data}){
    _status = status;
    _message = message;
    _data = data;
}

  PostAuctionModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// auction_id : "347"
/// auction_name : "test"
/// auction_created_date : "29 May at 12:41 PM"
/// bid_start_date : "2021-05-29 00:41:04"
/// bid_end_date : "2021-05-30 00:41"
/// bid_value : "25 KWD"
/// category : "Bird"
/// sub_category : "طيور ناطقة"
/// auction_description : "test"
/// status : "enable"
/// auction_type : "running"
/// image_count : 1
/// gallery : [{"image":"http://petmart.createkwservers.com/media/images/auction/513619-Screen Shot 2021-05-28 at 6.10.22 PM.png","thumbnail":"http://petmart.createkwservers.com/media/images/auction/513619-Screen Shot 2021-05-28 at 6.10.22 PM.png","type":"image"}]

class Data {
  String? _auctionId;
  String? _auctionName;
  String? _auctionCreatedDate;
  String? _bidStartDate;
  String? _bidEndDate;
  String? _bidValue;
  String? _category;
  String? _subCategory;
  String? _auctionDescription;
  String? _status;
  String? _auctionType;
  int? _imageCount;
  List<Gallery>? _gallery;

  String get auctionId => _auctionId!;
  String get auctionName => _auctionName!;
  String get auctionCreatedDate => _auctionCreatedDate!;
  String get bidStartDate => _bidStartDate!;
  String get bidEndDate => _bidEndDate!;
  String get bidValue => _bidValue!;
  String get category => _category!;
  String get subCategory => _subCategory!;
  String get auctionDescription => _auctionDescription!;
  String get status => _status!;
  String get auctionType => _auctionType!;
  int get imageCount => _imageCount!;
  List<Gallery> get gallery => _gallery!;

  Data({
    String? auctionId,
    String? auctionName,
    String? auctionCreatedDate,
    String? bidStartDate,
    String? bidEndDate,
    String? bidValue,
    String? category,
    String? subCategory,
    String? auctionDescription,
    String? status,
    String? auctionType,
      int? imageCount,
      List<Gallery>? gallery}){
    _auctionId = auctionId;
    _auctionName = auctionName;
    _auctionCreatedDate = auctionCreatedDate;
    _bidStartDate = bidStartDate;
    _bidEndDate = bidEndDate;
    _bidValue = bidValue;
    _category = category;
    _subCategory = subCategory;
    _auctionDescription = auctionDescription;
    _status = status;
    _auctionType = auctionType;
    _imageCount = imageCount;
    _gallery = gallery;
}

  Data.fromJson(dynamic json) {
    _auctionId = json["auction_id"];
    _auctionName = json["auction_name"];
    _auctionCreatedDate = json["auction_created_date"];
    _bidStartDate = json["bid_start_date"];
    _bidEndDate = json["bid_end_date"];
    _bidValue = json["bid_value"];
    _category = json["category"];
    _subCategory = json["sub_category"];
    _auctionDescription = json["auction_description"];
    _status = json["status"];
    _auctionType = json["auction_type"];
    _imageCount = json["image_count"];
    if (json["gallery"] != null) {
      _gallery = [];
      json["gallery"].forEach((v) {
        _gallery!.add(Gallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["auction_id"] = _auctionId;
    map["auction_name"] = _auctionName;
    map["auction_created_date"] = _auctionCreatedDate;
    map["bid_start_date"] = _bidStartDate;
    map["bid_end_date"] = _bidEndDate;
    map["bid_value"] = _bidValue;
    map["category"] = _category;
    map["sub_category"] = _subCategory;
    map["auction_description"] = _auctionDescription;
    map["status"] = _status;
    map["auction_type"] = _auctionType;
    map["image_count"] = _imageCount;
    if (_gallery != null) {
      map["gallery"] = _gallery!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// image : "http://petmart.createkwservers.com/media/images/auction/513619-Screen Shot 2021-05-28 at 6.10.22 PM.png"
/// thumbnail : "http://petmart.createkwservers.com/media/images/auction/513619-Screen Shot 2021-05-28 at 6.10.22 PM.png"
/// type : "image"

class Gallery {
  String? _image;
  String? _thumbnail;
  String? _type;

  String get image => _image!;
  String get thumbnail => _thumbnail!;
  String get type => _type!;

  Gallery({
    String? image,
    String? thumbnail,
    String? type}){
    _image = image;
    _thumbnail = thumbnail;
    _type = type;
}

  Gallery.fromJson(dynamic json) {
    _image = json["image"];
    _thumbnail = json["thumbnail"];
    _type = json["type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image"] = _image;
    map["thumbnail"] = _thumbnail;
    map["type"] = _type;
    return map;
  }

}