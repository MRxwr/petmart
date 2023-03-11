/// status : "success"
/// message : "Auction bid submitted."
/// data : {"auction_id":"1","user_id":"93","bid_value":"50","created_at":"2021-05-05 05:33:52","updated_at":"2021-05-05 05:33:52","bid_id":"549","auction_name":null,"user_name":null}

class BidModel {
  String? _status;
  String? _message;
  Data? _data;

  String get status => _status!;
  String get message => _message!;
  Data get data => _data!;

  BidModel({
    String? status,
    String? message,
      Data? data}){
    _status = status;
    _message = message;
    _data = data;
}

  BidModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data!.toJson();
    }
    return map;
  }

}

/// auction_id : "1"
/// user_id : "93"
/// bid_value : "50"
/// created_at : "2021-05-05 05:33:52"
/// updated_at : "2021-05-05 05:33:52"
/// bid_id : "549"
/// auction_name : null
/// user_name : null

class Data {
  String? _auctionId;
  String? _userId;
  String? _bidValue;
  String? _createdAt;
  String? _updatedAt;
  String? _bidId;
  dynamic _auctionName;
  dynamic _userName;

  String get auctionId => _auctionId!;
  String get userId => _userId!;
  String get bidValue => _bidValue!;
  String get createdAt => _createdAt!;
  String get updatedAt => _updatedAt!;
  String get bidId => _bidId!;
  dynamic get auctionName => _auctionName;
  dynamic get userName => _userName;

  Data({
    String? auctionId,
    String? userId,
    String? bidValue,
    String? createdAt,
    String? updatedAt,
    String? bidId,
      dynamic auctionName, 
      dynamic userName}){
    _auctionId = auctionId;
    _userId = userId;
    _bidValue = bidValue;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _bidId = bidId;
    _auctionName = auctionName;
    _userName = userName;
}

  Data.fromJson(dynamic json) {
    _auctionId = json["auction_id"];
    _userId = json["user_id"];
    _bidValue = json["bid_value"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _bidId = json["bid_id"];
    _auctionName = json["auction_name"];
    _userName = json["user_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["auction_id"] = _auctionId;
    map["user_id"] = _userId;
    map["bid_value"] = _bidValue;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["bid_id"] = _bidId;
    map["auction_name"] = _auctionName;
    map["user_name"] = _userName;
    return map;
  }

}