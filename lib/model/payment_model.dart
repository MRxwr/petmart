/// status : "success"
/// message : "You are redirecting to payment page."
/// data : "https://portal.myfatoorah.com/KWT/ie/0508417992820489469"
/// payment_url : "https://portal.myfatoorah.com/KWT/ie/0508417992820489469"

class PaymentModel {
  String? _status;
  String? _message;
  String? _data;
  String? _paymentUrl;

  String get status => _status!;
  String get message => _message!;
  String get data => _data!;
  String get paymentUrl => _paymentUrl!;

  PaymentModel({
      String? status,
      String? message,
      String? data,
      String? paymentUrl}){
    _status = status;
    _message = message;
    _data = data;
    _paymentUrl = paymentUrl;
}

  PaymentModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _data = json["data"];
    _paymentUrl = json["payment_url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    map["data"] = _data;
    map["payment_url"] = _paymentUrl;
    return map;
  }

}