/// status : "success"
/// message : "Running auction retrived."
/// data : [{"auction_id":"1","name":"دانيلسون الخيول العربية للبيع","category":"الطيور","description":"دانيلسون الخيول العربية للبيع","auction_date":"01 May at 2:30 AM","status":"running","auction_type":"running","start_date":"01-05-2021 02:30:55","end_date":"10-05-2021 20:58:45","image_count":1,"auction_image":"http://petmart.createkwservers.com/media/images/auction/Picture_1590503696.jpg","total_participate":3,"current_bid_value":"115","gallery":[{"image":"http://petmart.createkwservers.com/media/images/auction/Picture_1590503696.jpg","thumbnail":"http://petmart.createkwservers.com/media/images/auction/Picture_1590503696.jpg","type":"image"}]}]

class AuctionModel {
  String _status;
  String _message;
  List<Data> _data;

  String get status => _status;
  String get message => _message;
  List<Data> get data => _data;

  AuctionModel({
      String status, 
      String message, 
      List<Data> data}){
    _status = status;
    _message = message;
    _data = data;
}

  AuctionModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];

    if (json["data"]!= null) {
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

/// auction_id : "1"
/// name : "دانيلسون الخيول العربية للبيع"
/// category : "الطيور"
/// description : "دانيلسون الخيول العربية للبيع"
/// auction_date : "01 May at 2:30 AM"
/// status : "running"
/// auction_type : "running"
/// start_date : "01-05-2021 02:30:55"
/// end_date : "10-05-2021 20:58:45"
/// image_count : 1
/// auction_image : "http://petmart.createkwservers.com/media/images/auction/Picture_1590503696.jpg"
/// total_participate : 3
/// current_bid_value : "115"
/// gallery : [{"image":"http://petmart.createkwservers.com/media/images/auction/Picture_1590503696.jpg","thumbnail":"http://petmart.createkwservers.com/media/images/auction/Picture_1590503696.jpg","type":"image"}]

class Data {
  String _auctionId;
  String _name;
  String _category;
  String _description;
  String _auctionDate;
  String _status;
  String _auctionType;
  String _startDate;
  String _endDate;
  int _imageCount;
  String _auctionImage;
  int _totalParticipate;
  String _currentBidValue;
  List<Gallery> _gallery;

  String get auctionId => _auctionId;
  String get name => _name;
  String get category => _category;
  String get description => _description;
  String get auctionDate => _auctionDate;
  String get status => _status;
  String get auctionType => _auctionType;
  String get startDate => _startDate;
  String get endDate => _endDate;
  int get imageCount => _imageCount;
  String get auctionImage => _auctionImage;
  int get totalParticipate => _totalParticipate;
  String get currentBidValue => _currentBidValue;
  List<Gallery> get gallery => _gallery;

  Data({
      String auctionId, 
      String name, 
      String category, 
      String description, 
      String auctionDate, 
      String status, 
      String auctionType, 
      String startDate, 
      String endDate, 
      int imageCount, 
      String auctionImage, 
      int totalParticipate, 
      String currentBidValue, 
      List<Gallery> gallery}){
    _auctionId = auctionId;
    _name = name;
    _category = category;
    _description = description;
    _auctionDate = auctionDate;
    _status = status;
    _auctionType = auctionType;
    _startDate = startDate;
    _endDate = endDate;
    _imageCount = imageCount;
    _auctionImage = auctionImage;
    _totalParticipate = totalParticipate;
    _currentBidValue = currentBidValue;
    _gallery = gallery;
}

  Data.fromJson(dynamic json) {
    _auctionId = json["auction_id"];
    _name = json["name"];
    _category = json["category"];
    _description = json["description"];
    _auctionDate = json["auction_date"];
    _status = json["status"];
    _auctionType = json["auction_type"];
    _startDate = json["start_date"];
    _endDate = json["end_date"];
    _imageCount = json["image_count"];
    _auctionImage = json["auction_image"];
    _totalParticipate = json["total_participate"];
    _currentBidValue = json["current_bid_value"];
    if (json["gallery"] != null) {
      _gallery = [];
      json["gallery"].forEach((v) {
        _gallery.add(Gallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["auction_id"] = _auctionId;
    map["name"] = _name;
    map["category"] = _category;
    map["description"] = _description;
    map["auction_date"] = _auctionDate;
    map["status"] = _status;
    map["auction_type"] = _auctionType;
    map["start_date"] = _startDate;
    map["end_date"] = _endDate;
    map["image_count"] = _imageCount;
    map["auction_image"] = _auctionImage;
    map["total_participate"] = _totalParticipate;
    map["current_bid_value"] = _currentBidValue;
    if (_gallery != null) {
      map["gallery"] = _gallery.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// image : "http://petmart.createkwservers.com/media/images/auction/Picture_1590503696.jpg"
/// thumbnail : "http://petmart.createkwservers.com/media/images/auction/Picture_1590503696.jpg"
/// type : "image"

class Gallery {
  String _image;
  String _thumbnail;
  String _type;

  String get image => _image;
  String get thumbnail => _thumbnail;
  String get type => _type;

  Gallery({
      String image, 
      String thumbnail, 
      String type}){
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