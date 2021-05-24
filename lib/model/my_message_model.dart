/// status : "success"
/// message : "Message retrived"
/// data : [{"message_id":"77","receiver_id":"69","sender_image":"http://petmart.createkwservers.com/media/images/user/Picture_1612864687.jpg","sender_name":"Aarefa Bashi","message":"hi","message_count":"0","day_ago":"7 days ago"},{"message_id":"59","receiver_id":"27","sender_image":"http://petmart.createkwservers.com/media/images/no-image.jpg","sender_name":"A W","message":"tese","message_count":"0","day_ago":"a week ago"}]

class MyMessageModel {
  String _status;
  String _message;
  List<Data> _data;

  String get status => _status;
  String get message => _message;
  List<Data> get data => _data;

  MyMessageModel({
      String status, 
      String message, 
      List<Data> data}){
    _status = status;
    _message = message;
    _data = data;
}

  MyMessageModel.fromJson(dynamic json) {
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

/// message_id : "77"
/// receiver_id : "69"
/// sender_image : "http://petmart.createkwservers.com/media/images/user/Picture_1612864687.jpg"
/// sender_name : "Aarefa Bashi"
/// message : "hi"
/// message_count : "0"
/// day_ago : "7 days ago"

class Data {
  String _messageId;
  String _receiverId;
  String _senderImage;
  String _senderName;
  String _message;
  String _messageCount;
  String _dayAgo;

  String get messageId => _messageId;
  String get receiverId => _receiverId;
  String get senderImage => _senderImage;
  String get senderName => _senderName;
  String get message => _message;
  String get messageCount => _messageCount;
  String get dayAgo => _dayAgo;

  Data({
      String messageId, 
      String receiverId, 
      String senderImage, 
      String senderName, 
      String message, 
      String messageCount, 
      String dayAgo}){
    _messageId = messageId;
    _receiverId = receiverId;
    _senderImage = senderImage;
    _senderName = senderName;
    _message = message;
    _messageCount = messageCount;
    _dayAgo = dayAgo;
}

  Data.fromJson(dynamic json) {
    _messageId = json["message_id"];
    _receiverId = json["receiver_id"];
    _senderImage = json["sender_image"];
    _senderName = json["sender_name"];
    _message = json["message"];
    _messageCount = json["message_count"];
    _dayAgo = json["day_ago"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message_id"] = _messageId;
    map["receiver_id"] = _receiverId;
    map["sender_image"] = _senderImage;
    map["sender_name"] = _senderName;
    map["message"] = _message;
    map["message_count"] = _messageCount;
    map["day_ago"] = _dayAgo;
    return map;
  }

}