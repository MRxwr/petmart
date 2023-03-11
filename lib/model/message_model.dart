/// status : "success"
/// message : "Message Sent"
/// data : [{"messsage_date":"15-05-2021","message_id":"59","user_id":"93","receiver_id":"27","message":"tese","is_read":"0","created_at":"2021-05-15 22:29:30","updated_at":"2021-05-15 22:29:30","sender":"right"},{"messsage_date":"15-05-2021","message_id":"60","user_id":"93","receiver_id":"27","message":"hi","is_read":"0","created_at":"2021-05-15 23:00:26","updated_at":"2021-05-15 23:00:26","sender":"right"},{"messsage_date":"16-05-2021","message_id":"61","user_id":"93","receiver_id":"27","message":"hi","is_read":"0","created_at":"2021-05-16 10:40:14","updated_at":"2021-05-16 10:40:14","sender":"right"},{"messsage_date":"16-05-2021","message_id":"62","user_id":"93","receiver_id":"27","message":"hi","is_read":"0","created_at":"2021-05-16 12:59:42","updated_at":"2021-05-16 12:59:42","sender":"right"},{"messsage_date":"16-05-2021","message_id":"63","user_id":"93","receiver_id":"27","message":"hi","is_read":"0","created_at":"2021-05-16 13:00:27","updated_at":"2021-05-16 13:00:27","sender":"right"},{"messsage_date":"16-05-2021","message_id":"64","user_id":"93","receiver_id":"27","message":"hi","is_read":"0","created_at":"2021-05-16 13:06:23","updated_at":"2021-05-16 13:06:23","sender":"right"},{"messsage_date":"16-05-2021","message_id":"65","user_id":"93","receiver_id":"27","message":"hi","is_read":"0","created_at":"2021-05-16 13:08:13","updated_at":"2021-05-16 13:08:13","sender":"right"}]

class MessageModel {
  String? _status;
  String? _message;
  List<Data>? _data;

  String get status => _status!;
  String get message => _message!;
  List<Data> get data => _data!;

  MessageModel({
    String? status,
    String? message,
      List<Data>? data}){
    _status = status;
    _message = message;
    _data = data;
}

  MessageModel.fromJson(dynamic json) {
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

/// messsage_date : "15-05-2021"
/// message_id : "59"
/// user_id : "93"
/// receiver_id : "27"
/// message : "tese"
/// is_read : "0"
/// created_at : "2021-05-15 22:29:30"
/// updated_at : "2021-05-15 22:29:30"
/// sender : "right"

class Data {
  String? _messsageDate;
  String? _messageId;
  String? _userId;
  String? _receiverId;
  String? _message;
  String? _isRead;
  String? _createdAt;
  String? _updatedAt;
  String? _sender;

  String get messsageDate => _messsageDate!;
  String get messageId => _messageId!;
  String get userId => _userId!;
  String get receiverId => _receiverId!;
  String get message => _message!;
  String get isRead => _isRead!;
  String get createdAt => _createdAt!;
  String get updatedAt => _updatedAt!;
  String get sender => _sender!;

  Data({
    String? messsageDate,
    String? messageId,
    String? userId,
    String? receiverId,
    String? message,
    String? isRead,
    String? createdAt,
    String? updatedAt,
    String? sender}){
    _messsageDate = messsageDate;
    _messageId = messageId;
    _userId = userId;
    _receiverId = receiverId;
    _message = message;
    _isRead = isRead;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _sender = sender;
}

  Data.fromJson(dynamic json) {
    _messsageDate = json["messsage_date"];
    _messageId = json["message_id"];
    _userId = json["user_id"];
    _receiverId = json["receiver_id"];
    _message = json["message"];
    _isRead = json["is_read"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _sender = json["sender"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["messsage_date"] = _messsageDate;
    map["message_id"] = _messageId;
    map["user_id"] = _userId;
    map["receiver_id"] = _receiverId;
    map["message"] = _message;
    map["is_read"] = _isRead;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["sender"] = _sender;
    return map;
  }

}