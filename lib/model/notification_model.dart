/// status : "success"
/// message : "Notifications retrived"
/// data : [{"notification_id":"7639","message":"Rabbit 243 is created.","date":"2021-05-28 20:44:12","status":1}]

class NotificationModel {
  String _status;
  String _message;
  List<Data> _data;

  String get status => _status;
  String get message => _message;
  List<Data> get data => _data;

  NotificationModel({
      String status, 
      String message, 
      List<Data> data}){
    _status = status;
    _message = message;
    _data = data;
}

  NotificationModel.fromJson(dynamic json) {
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

/// notification_id : "7639"
/// message : "Rabbit 243 is created."
/// date : "2021-05-28 20:44:12"
/// status : 1

class Data {
  String _notificationId;
  String _message;
  String _date;
  int _status;

  String get notificationId => _notificationId;
  String get message => _message;
  String get date => _date;
  int get status => _status;

  Data({
      String notificationId, 
      String message, 
      String date, 
      int status}){
    _notificationId = notificationId;
    _message = message;
    _date = date;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _notificationId = json["notification_id"];
    _message = json["message"];
    _date = json["date"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["notification_id"] = _notificationId;
    map["message"] = _message;
    map["date"] = _date;
    map["status"] = _status;
    return map;
  }

}