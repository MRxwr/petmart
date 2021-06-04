class AuctionDetailsModel {
  String status;
  String message;
  Data data;

  AuctionDetailsModel({this.status, this.message, this.data});

  AuctionDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String auctionId;
  String auctionName;
  String auctionDescription;
  String auctionStatus;
  String auctionRemaining;
  String highestBidderImage;
  String highestBidderName;
  String highestBidderValue;
  OwnerData ownerData;
  int totalParticipate;
  String minBidValue;
  String currentBidValue;
  List<String> bidRange;
  String auctionDate;
  String category;
  String categoryId;
  String subCategory;
  String subCategoryId;
  String stateDate;
  String endDate;
  String bidValue;
  String auctionImage;
  int rating;
  List<Gallery> gallery;

  Data(
      {this.auctionId,
        this.auctionName,
        this.auctionDescription,
        this.auctionStatus,
        this.auctionRemaining,
        this.highestBidderImage,
        this.highestBidderName,
        this.highestBidderValue,
        this.ownerData,
        this.totalParticipate,
        this.minBidValue,
        this.currentBidValue,
        this.bidRange,
        this.auctionDate,
        this.category,
        this.categoryId,
        this.subCategory,
        this.subCategoryId,
        this.stateDate,
        this.endDate,
        this.bidValue,
        this.auctionImage,
        this.rating,
        this.gallery});

  Data.fromJson(Map<String, dynamic> json) {
    auctionId = json['auction_id'];
    auctionName = json['auction_name'];
    auctionDescription = json['auction_description'];
    auctionStatus = json['auction_status'];
    auctionRemaining = json['auction_remaining'];
    highestBidderImage = json['highest_bidder_image'];
    highestBidderName = json['highest_bidder_name'];
    highestBidderValue = json['highest_bidder_value'];
    ownerData = json['owner_data'] != null
        ? new OwnerData.fromJson(json['owner_data'])
        : null;
    totalParticipate = json['total_participate'];
    minBidValue = json['min_bid_value'];
    currentBidValue = json['current_bid_value'];
    bidRange = json['bid_range'].cast<String>();
    auctionDate = json['auction_date'];
    category = json['category'];
    categoryId = json['category_id'];
    subCategory = json['sub_category'];
    subCategoryId = json['sub_category_id'];
    stateDate = json['state_date'];
    endDate = json['end_date'];
    bidValue = json['bid_value'];
    auctionImage = json['auction_image'];
    rating = json['rating'];
    if (json['gallery'] != null) {
      gallery = new List<Gallery>();
      json['gallery'].forEach((v) {
        gallery.add(new Gallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auction_id'] = this.auctionId;
    data['auction_name'] = this.auctionName;
    data['auction_description'] = this.auctionDescription;
    data['auction_status'] = this.auctionStatus;
    data['auction_remaining'] = this.auctionRemaining;
    data['highest_bidder_image'] = this.highestBidderImage;
    data['highest_bidder_name'] = this.highestBidderName;
    data['highest_bidder_value'] = this.highestBidderValue;
    if (this.ownerData != null) {
      data['owner_data'] = this.ownerData.toJson();
    }
    data['total_participate'] = this.totalParticipate;
    data['min_bid_value'] = this.minBidValue;
    data['current_bid_value'] = this.currentBidValue;
    data['bid_range'] = this.bidRange;
    data['auction_date'] = this.auctionDate;
    data['category'] = this.category;
    data['category_id'] = this.categoryId;
    data['sub_category'] = this.subCategory;
    data['sub_category_id'] = this.subCategoryId;
    data['state_date'] = this.stateDate;
    data['end_date'] = this.endDate;
    data['bid_value'] = this.bidValue;
    data['auction_image'] = this.auctionImage;
    data['rating'] = this.rating;
    if (this.gallery != null) {
      data['gallery'] = this.gallery.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OwnerData {
  String customerId;
  String firstname;
  String lastname;
  String email;
  String mobile;
  String gender;
  String profileImage;
  String dateOfBirth;
  String password;
  String confirmPassword;
  String countryName;
  String createdAt;
  String updatedAt;
  String lastLogin;
  String status;
  String isNotify;
  String otp;
  String availableCredit;
  String randomToken;
  String deviceToken;
  String imeiNumber;
  String deviceType;

  OwnerData(
      {this.customerId,
        this.firstname,
        this.lastname,
        this.email,
        this.mobile,
        this.gender,
        this.profileImage,
        this.dateOfBirth,
        this.password,
        this.confirmPassword,
        this.countryName,
        this.createdAt,
        this.updatedAt,
        this.lastLogin,
        this.status,
        this.isNotify,
        this.otp,
        this.availableCredit,
        this.randomToken,
        this.deviceToken,
        this.imeiNumber,
        this.deviceType});

  OwnerData.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    dateOfBirth = json['date_of_birth'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
    countryName = json['country_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastLogin = json['last_login'];
    status = json['status'];
    isNotify = json['is_notify'];
    otp = json['otp'];
    availableCredit = json['available_credit'];
    randomToken = json['random_token'];
    deviceToken = json['device_token'];
    imeiNumber = json['imei_number'];
    deviceType = json['device_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['date_of_birth'] = this.dateOfBirth;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    data['country_name'] = this.countryName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['last_login'] = this.lastLogin;
    data['status'] = this.status;
    data['is_notify'] = this.isNotify;
    data['otp'] = this.otp;
    data['available_credit'] = this.availableCredit;
    data['random_token'] = this.randomToken;
    data['device_token'] = this.deviceToken;
    data['imei_number'] = this.imeiNumber;
    data['device_type'] = this.deviceType;
    return data;
  }
}

class Gallery {
  String image;
  String thumbnail;
  String type;

  Gallery({this.image, this.thumbnail, this.type});

  Gallery.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    thumbnail = json['thumbnail'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['thumbnail'] = this.thumbnail;
    data['type'] = this.type;
    return data;
  }
}