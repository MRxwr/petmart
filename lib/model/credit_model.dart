/// status : "success"
/// message : "Credit Data Retrived"
/// data : {"credit":"0","expiry_date":"18-05-2021 09:51:37","order_history":[{"payment_id":"27990280","package_name":"Daily package","package_expiry_date":"17-05-2021 11:10:29","package_transaction_id":"0","package_purchase_date":"15-05-2021 11:10:29","package_price":"20 KWD","package_credit":"20","payment_type":"","payment_status":"pending"},{"payment_id":"28038336","package_name":"Silver","package_expiry_date":"26-05-2021 09:48:28","package_transaction_id":"0","package_purchase_date":"16-05-2021 09:48:28","package_price":"3 KWD","package_credit":"5","payment_type":"","payment_status":"pending"},{"payment_id":"28038440","package_name":"Daily package","package_expiry_date":"18-05-2021 09:50:28","package_transaction_id":"0","package_purchase_date":"16-05-2021 09:50:28","package_price":"20 KWD","package_credit":"20","payment_type":"","payment_status":"pending"},{"payment_id":"28038498","package_name":"Daily package","package_expiry_date":"18-05-2021 09:51:37","package_transaction_id":"0","package_purchase_date":"16-05-2021 09:51:37","package_price":"20 KWD","package_credit":"20","payment_type":"","payment_status":"pending"}]}

class CreditModel {
  String _status;
  String _message;
  Data _data;

  String get status => _status;
  String get message => _message;
  Data get data => _data;

  CreditModel({
      String status, 
      String message, 
      Data data}){
    _status = status;
    _message = message;
    _data = data;
}

  CreditModel.fromJson(dynamic json) {
    _status = json["status"];
    _message = json["message"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

}

/// credit : "0"
/// expiry_date : "18-05-2021 09:51:37"
/// order_history : [{"payment_id":"27990280","package_name":"Daily package","package_expiry_date":"17-05-2021 11:10:29","package_transaction_id":"0","package_purchase_date":"15-05-2021 11:10:29","package_price":"20 KWD","package_credit":"20","payment_type":"","payment_status":"pending"},{"payment_id":"28038336","package_name":"Silver","package_expiry_date":"26-05-2021 09:48:28","package_transaction_id":"0","package_purchase_date":"16-05-2021 09:48:28","package_price":"3 KWD","package_credit":"5","payment_type":"","payment_status":"pending"},{"payment_id":"28038440","package_name":"Daily package","package_expiry_date":"18-05-2021 09:50:28","package_transaction_id":"0","package_purchase_date":"16-05-2021 09:50:28","package_price":"20 KWD","package_credit":"20","payment_type":"","payment_status":"pending"},{"payment_id":"28038498","package_name":"Daily package","package_expiry_date":"18-05-2021 09:51:37","package_transaction_id":"0","package_purchase_date":"16-05-2021 09:51:37","package_price":"20 KWD","package_credit":"20","payment_type":"","payment_status":"pending"}]

class Data {
  String _credit;
  String _expiryDate;
  List<Order_history> _orderHistory;

  String get credit => _credit;
  String get expiryDate => _expiryDate;
  List<Order_history> get orderHistory => _orderHistory;

  Data({
      String credit, 
      String expiryDate, 
      List<Order_history> orderHistory}){
    _credit = credit;
    _expiryDate = expiryDate;
    _orderHistory = orderHistory;
}

  Data.fromJson(dynamic json) {
    _credit = json["credit"];
    _expiryDate = json["expiry_date"];
    if (json["order_history"] != null) {
      _orderHistory = [];
      json["order_history"].forEach((v) {
        _orderHistory.add(Order_history.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["credit"] = _credit;
    map["expiry_date"] = _expiryDate;
    if (_orderHistory != null) {
      map["order_history"] = _orderHistory.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// payment_id : "27990280"
/// package_name : "Daily package"
/// package_expiry_date : "17-05-2021 11:10:29"
/// package_transaction_id : "0"
/// package_purchase_date : "15-05-2021 11:10:29"
/// package_price : "20 KWD"
/// package_credit : "20"
/// payment_type : ""
/// payment_status : "pending"

class Order_history {
  String _paymentId;
  String _packageName;
  String _packageExpiryDate;
  String _packageTransactionId;
  String _packagePurchaseDate;
  String _packagePrice;
  String _packageCredit;
  String _paymentType;
  String _paymentStatus;

  String get paymentId => _paymentId;
  String get packageName => _packageName;
  String get packageExpiryDate => _packageExpiryDate;
  String get packageTransactionId => _packageTransactionId;
  String get packagePurchaseDate => _packagePurchaseDate;
  String get packagePrice => _packagePrice;
  String get packageCredit => _packageCredit;
  String get paymentType => _paymentType;
  String get paymentStatus => _paymentStatus;

  Order_history({
      String paymentId, 
      String packageName, 
      String packageExpiryDate, 
      String packageTransactionId, 
      String packagePurchaseDate, 
      String packagePrice, 
      String packageCredit, 
      String paymentType, 
      String paymentStatus}){
    _paymentId = paymentId;
    _packageName = packageName;
    _packageExpiryDate = packageExpiryDate;
    _packageTransactionId = packageTransactionId;
    _packagePurchaseDate = packagePurchaseDate;
    _packagePrice = packagePrice;
    _packageCredit = packageCredit;
    _paymentType = paymentType;
    _paymentStatus = paymentStatus;
}

  Order_history.fromJson(dynamic json) {
    _paymentId = json["payment_id"];
    _packageName = json["package_name"];
    _packageExpiryDate = json["package_expiry_date"];
    _packageTransactionId = json["package_transaction_id"];
    _packagePurchaseDate = json["package_purchase_date"];
    _packagePrice = json["package_price"];
    _packageCredit = json["package_credit"];
    _paymentType = json["payment_type"];
    _paymentStatus = json["payment_status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["payment_id"] = _paymentId;
    map["package_name"] = _packageName;
    map["package_expiry_date"] = _packageExpiryDate;
    map["package_transaction_id"] = _packageTransactionId;
    map["package_purchase_date"] = _packagePurchaseDate;
    map["package_price"] = _packagePrice;
    map["package_credit"] = _packageCredit;
    map["payment_type"] = _paymentType;
    map["payment_status"] = _paymentStatus;
    return map;
  }

}