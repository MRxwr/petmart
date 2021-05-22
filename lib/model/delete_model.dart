/// status : "success"
/// message : "Post has been deleted."
/// data : []

class DeleteModel {
  String _status;
  String _message;


  String get status => _status;
  String get message => _message;


  DeleteModel({
      String status, 
      String message}){
    _status = status;
    _message = message;

}

  DeleteModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;

    return map;
  }

}