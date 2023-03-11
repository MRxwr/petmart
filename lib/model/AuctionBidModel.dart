class AuctionBidModel {
  bool? ok;
  String? error;
  String? status;
  Data? data;

  AuctionBidModel({this.ok, this.error, this.status, this.data});

  AuctionBidModel.fromJson(Map<String, dynamic> json) {
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
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? enTitle;
  String? arTitle;
  String? reach;
  String? enDetails;
  String? arDetails;
  String? startDate;
  String? endDate;
  String? winnerRated;
  String? ownerRated;
  dynamic image;
  Owner? owner;
  Owner? winner;

  Data(
      {this.id,
        this.enTitle,
        this.arTitle,
        this.reach,
        this.enDetails,
        this.arDetails,
        this.startDate,
        this.endDate,
        this.winnerRated,
        this.ownerRated,
        this.image,
        this.owner,
        this.winner});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enTitle = json['enTitle'];
    arTitle = json['arTitle'];
    reach = json['reach'];
    enDetails = json['enDetails'];
    arDetails = json['arDetails'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    winnerRated = json['winnerRated'];
    ownerRated = json['ownerRated'];
    image = json['image'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    winner = json['winner'] != null ? new Owner.fromJson(json['winner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enTitle'] = this.enTitle;
    data['arTitle'] = this.arTitle;
    data['reach'] = this.reach;
    data['enDetails'] = this.enDetails;
    data['arDetails'] = this.arDetails;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['winnerRated'] = this.winnerRated;
    data['ownerRated'] = this.ownerRated;
    data['image'] = this.image;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.winner != null) {
      data['winner'] = this.winner!.toJson();
    }
    return data;
  }
}

class Owner {
  String? id;
  String? email;
  String? mobile;
  String? name;
  String? logo;
  String? oRate;

  Owner({this.id, this.email, this.mobile, this.name, this.logo, this.oRate});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    mobile = json['mobile'];
    name = json['name'];
    logo = json['logo'];
    oRate = json['oRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['oRate'] = this.oRate;
    return data;
  }
}
