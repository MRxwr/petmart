class MyNewAuctionDetailsModel {
  bool ok;
  String error;
  String status;
  List<Data> data;

  MyNewAuctionDetailsModel({this.ok, this.error, this.status, this.data});

  MyNewAuctionDetailsModel.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    error = json['error'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    data['error'] = this.error;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String endDate;
  String enTitle;
  String arTitle;
  String enDetails;
  String arDetails;
  String price;
  String reach;
  String video;
  String status;
  List<String> bids;
  List<String> image;
  Customer customer;
  List<Bidders> bidders;

  Data(
      {this.id,
        this.endDate,
        this.enTitle,
        this.arTitle,
        this.enDetails,
        this.arDetails,
        this.price,
        this.reach,
        this.video,
        this.status,
        this.bids,
        this.image,
        this.customer,
        this.bidders});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    endDate = json['endDate'];
    enTitle = json['enTitle'];
    arTitle = json['arTitle'];
    enDetails = json['enDetails'];
    arDetails = json['arDetails'];
    price = json['price'];
    reach = json['reach'];
    video = json['video'];
    status = json['status'];
    bids = json['bids'].cast<String>();
    image = json['image'].cast<String>();
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['bidders'] != null) {
      bidders = <Bidders>[];
      json['bidders'].forEach((v) {
        bidders.add(new Bidders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['endDate'] = this.endDate;
    data['enTitle'] = this.enTitle;
    data['arTitle'] = this.arTitle;
    data['enDetails'] = this.enDetails;
    data['arDetails'] = this.arDetails;
    data['price'] = this.price;
    data['reach'] = this.reach;
    data['video'] = this.video;
    data['status'] = this.status;
    data['bids'] = this.bids;
    data['image'] = this.image;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    if (this.bidders != null) {
      data['bidders'] = this.bidders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  String name;
  String mobile;
  String email;
  String logo;
  String rating;

  Customer({this.name, this.mobile, this.email, this.logo, this.rating});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    logo = json['logo'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['logo'] = this.logo;
    data['rating'] = this.rating;
    return data;
  }
}

class Bidders {
  String name;
  String logo;
  String bid;
  String date;

  Bidders({this.name, this.logo, this.bid, this.date});

  Bidders.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
    bid = json['bid'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['bid'] = this.bid;
    data['date'] = this.date;
    return data;
  }
}
