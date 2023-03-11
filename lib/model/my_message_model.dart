class MyMessageModel {
  String? status;
  String? message;
  List<Data>? data;

  MyMessageModel({this.status, this.message, this.data});

  MyMessageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? messageId;
  String? postId;
  String? receiverId;
  String? senderImage;
  String? senderName;
  String? message;
  String? messageCount;
  String? dayAgo;

  Data(
      {this.messageId,
        this.postId,
        this.receiverId,
        this.senderImage,
        this.senderName,
        this.message,
        this.messageCount,
        this.dayAgo});

  Data.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    postId = json['post_id'];
    receiverId = json['receiver_id'];
    senderImage = json['sender_image'];
    senderName = json['sender_name'];
    message = json['message'];
    messageCount = json['message_count'];
    dayAgo = json['day_ago'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message_id'] = this.messageId;
    data['post_id'] = this.postId;
    data['receiver_id'] = this.receiverId;
    data['sender_image'] = this.senderImage;
    data['sender_name'] = this.senderName;
    data['message'] = this.message;
    data['message_count'] = this.messageCount;
    data['day_ago'] = this.dayAgo;
    return data;
  }
}