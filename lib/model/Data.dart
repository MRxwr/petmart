class Data {
  Data({
      this.url, 
      this.id,});

  Data.fromJson(dynamic json) {
    url = json['url'];
    id = json['id'];
  }
  String? url;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['id'] = id;
    return map;
  }

}