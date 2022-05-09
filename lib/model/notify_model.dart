class NotifyModel {
  bool ok;
  String error;
  String status;
  Data data;

  NotifyModel({this.ok, this.error, this.status, this.data});

  NotifyModel.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    error = json['error'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    data['error'] = this.error;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String total;
  List<Notification> notification;

  Data({this.total, this.notification});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['notification'] != null) {
      notification = <Notification>[];
      json['notification'].forEach((v) {
        notification.add(new Notification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.notification != null) {
      data['notification'] = this.notification.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notification {
  String id;
  String date;
  String userId;
  String notification;
  String seen;

  Notification({this.id, this.date, this.userId, this.notification, this.seen});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    userId = json['userId'];
    notification = json['notification'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['userId'] = this.userId;
    data['notification'] = this.notification;
    data['seen'] = this.seen;
    return data;
  }
}
