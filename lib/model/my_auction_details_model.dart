class MyAuctionDetailsModel {
  String _status;
  String _message;
  Data _data;

  MyAuctionDetailsModel({String status, String message, Data data}) {
    this._status = status;
    this._message = message;
    this._data = data;
  }

  String get status => _status;
  set status(String status) => _status = status;
  String get message => _message;
  set message(String message) => _message = message;
  Data get data => _data;
  set data(Data data) => _data = data;

  MyAuctionDetailsModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class Data {
  String _auctionId;
  String _auctionName;
  String _auctionDescription;
  String _auctionStatus;
  String _auctionRemaining;
  String _highestBidderImage;
  String _highestBidderName;
  String _highestBidderValue;

  OwnerData _ownerData;
  int _totalParticipate;
  String _minBidValue;
  String _currentBidValue;
  List<String> _bidRange;
  String _auctionDate;
  String _category;
  String _categoryId;
  String _subCategory;
  String _subCategoryId;
  String _stateDate;
  String _endDate;
  String _bidValue;
  String _auctionImage;
  int _rating;
  List<Gallery> _gallery;

  Data({String auctionId, String auctionName, String auctionDescription, String auctionStatus, String auctionRemaining, String highestBidderImage, String highestBidderName, String highestBidderValue,  OwnerData ownerData, int totalParticipate, String minBidValue, String currentBidValue, List<String> bidRange, String auctionDate, String category, String categoryId, String subCategory, String subCategoryId, String stateDate, String endDate, String bidValue, String auctionImage, int rating, List<Gallery> gallery}) {
    this._auctionId = auctionId;
    this._auctionName = auctionName;
    this._auctionDescription = auctionDescription;
    this._auctionStatus = auctionStatus;
    this._auctionRemaining = auctionRemaining;
    this._highestBidderImage = highestBidderImage;
    this._highestBidderName = highestBidderName;
    this._highestBidderValue = highestBidderValue;
    this._ownerData = ownerData;
    this._totalParticipate = totalParticipate;
    this._minBidValue = minBidValue;
    this._currentBidValue = currentBidValue;
    this._bidRange = bidRange;
    this._auctionDate = auctionDate;
    this._category = category;
    this._categoryId = categoryId;
    this._subCategory = subCategory;
    this._subCategoryId = subCategoryId;
    this._stateDate = stateDate;
    this._endDate = endDate;
    this._bidValue = bidValue;
    this._auctionImage = auctionImage;
    this._rating = rating;
    this._gallery = gallery;
  }

  String get auctionId => _auctionId;
  set auctionId(String auctionId) => _auctionId = auctionId;
  String get auctionName => _auctionName;
  set auctionName(String auctionName) => _auctionName = auctionName;
  String get auctionDescription => _auctionDescription;
  set auctionDescription(String auctionDescription) => _auctionDescription = auctionDescription;
  String get auctionStatus => _auctionStatus;
  set auctionStatus(String auctionStatus) => _auctionStatus = auctionStatus;
  String get auctionRemaining => _auctionRemaining;
  set auctionRemaining(String auctionRemaining) => _auctionRemaining = auctionRemaining;
  String get highestBidderImage => _highestBidderImage;
  set highestBidderImage(String highestBidderImage) => _highestBidderImage = highestBidderImage;
  String get highestBidderName => _highestBidderName;
  set highestBidderName(String highestBidderName) => _highestBidderName = highestBidderName;
  String get highestBidderValue => _highestBidderValue;
  set highestBidderValue(String highestBidderValue) => _highestBidderValue = highestBidderValue;

  OwnerData get ownerData => _ownerData;
  set ownerData(OwnerData ownerData) => _ownerData = ownerData;
  int get totalParticipate => _totalParticipate;
  set totalParticipate(int totalParticipate) => _totalParticipate = totalParticipate;
  String get minBidValue => _minBidValue;
  set minBidValue(String minBidValue) => _minBidValue = minBidValue;
  String get currentBidValue => _currentBidValue;
  set currentBidValue(String currentBidValue) => _currentBidValue = currentBidValue;
  List<String> get bidRange => _bidRange;
  set bidRange(List<String> bidRange) => _bidRange = bidRange;
  String get auctionDate => _auctionDate;
  set auctionDate(String auctionDate) => _auctionDate = auctionDate;
  String get category => _category;
  set category(String category) => _category = category;
  String get categoryId => _categoryId;
  set categoryId(String categoryId) => _categoryId = categoryId;
  String get subCategory => _subCategory;
  set subCategory(String subCategory) => _subCategory = subCategory;
  String get subCategoryId => _subCategoryId;
  set subCategoryId(String subCategoryId) => _subCategoryId = subCategoryId;
  String get stateDate => _stateDate;
  set stateDate(String stateDate) => _stateDate = stateDate;
  String get endDate => _endDate;
  set endDate(String endDate) => _endDate = endDate;
  String get bidValue => _bidValue;
  set bidValue(String bidValue) => _bidValue = bidValue;
  String get auctionImage => _auctionImage;
  set auctionImage(String auctionImage) => _auctionImage = auctionImage;
  int get rating => _rating;
  set rating(int rating) => _rating = rating;
  List<Gallery> get gallery => _gallery;
  set gallery(List<Gallery> gallery) => _gallery = gallery;

  Data.fromJson(Map<String, dynamic> json) {
    _auctionId = json['auction_id'];
    _auctionName = json['auction_name'];
    _auctionDescription = json['auction_description'];
    _auctionStatus = json['auction_status'];
    _auctionRemaining = json['auction_remaining'];
    _highestBidderImage = json['highest_bidder_image'];
    _highestBidderName = json['highest_bidder_name'];
    _highestBidderValue = json['highest_bidder_value'];
       _ownerData = json['owner_data'] != null ? new OwnerData.fromJson(json['owner_data']) : null;
    _totalParticipate = json['total_participate'];
    _minBidValue = json['min_bid_value'];
    _currentBidValue = json['current_bid_value'];
    _bidRange = json['bid_range'].cast<String>();
    _auctionDate = json['auction_date'];
    _category = json['category'];
    _categoryId = json['category_id'];
    _subCategory = json['sub_category'];
    _subCategoryId = json['sub_category_id'];
    _stateDate = json['state_date'];
    _endDate = json['end_date'];
    _bidValue = json['bid_value'];
    _auctionImage = json['auction_image'];
    _rating = json['rating'];
    if (json['gallery'] != null) {
      _gallery = new List<Gallery>();
      json['gallery'].forEach((v) { _gallery.add(new Gallery.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auction_id'] = this._auctionId;
    data['auction_name'] = this._auctionName;
    data['auction_description'] = this._auctionDescription;
    data['auction_status'] = this._auctionStatus;
    data['auction_remaining'] = this._auctionRemaining;
    data['highest_bidder_image'] = this._highestBidderImage;
    data['highest_bidder_name'] = this._highestBidderName;
    data['highest_bidder_value'] = this._highestBidderValue;

    if (this._ownerData != null) {
      data['owner_data'] = this._ownerData.toJson();
    }
    data['total_participate'] = this._totalParticipate;
    data['min_bid_value'] = this._minBidValue;
    data['current_bid_value'] = this._currentBidValue;
    data['bid_range'] = this._bidRange;
    data['auction_date'] = this._auctionDate;
    data['category'] = this._category;
    data['category_id'] = this._categoryId;
    data['sub_category'] = this._subCategory;
    data['sub_category_id'] = this._subCategoryId;
    data['state_date'] = this._stateDate;
    data['end_date'] = this._endDate;
    data['bid_value'] = this._bidValue;
    data['auction_image'] = this._auctionImage;
    data['rating'] = this._rating;
    if (this._gallery != null) {
      data['gallery'] = this._gallery.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class OwnerData {
  String _customerId;
  String _firstname;
  String _lastname;
  String _email;
  String _mobile;
  String _gender;
  String _profileImage;
  String _dateOfBirth;
  String _password;
  String _confirmPassword;
  String _countryName;
  String _createdAt;
  String _updatedAt;
  String _lastLogin;
  String _status;
  String _isNotify;
  String _otp;
  String _availableCredit;
  String _randomToken;
  String _deviceToken;
  String _imeiNumber;
  String _deviceType;

  OwnerData({String customerId, String firstname, String lastname, String email, String mobile, String gender, String profileImage, String dateOfBirth, String password, String confirmPassword, String countryName, String createdAt, String updatedAt, String lastLogin, String status, String isNotify, String otp, String availableCredit, String randomToken, String deviceToken, String imeiNumber, String deviceType}) {
    this._customerId = customerId;
    this._firstname = firstname;
    this._lastname = lastname;
    this._email = email;
    this._mobile = mobile;
    this._gender = gender;
    this._profileImage = profileImage;
    this._dateOfBirth = dateOfBirth;
    this._password = password;
    this._confirmPassword = confirmPassword;
    this._countryName = countryName;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._lastLogin = lastLogin;
    this._status = status;
    this._isNotify = isNotify;
    this._otp = otp;
    this._availableCredit = availableCredit;
    this._randomToken = randomToken;
    this._deviceToken = deviceToken;
    this._imeiNumber = imeiNumber;
    this._deviceType = deviceType;
  }

  String get customerId => _customerId;
  set customerId(String customerId) => _customerId = customerId;
  String get firstname => _firstname;
  set firstname(String firstname) => _firstname = firstname;
  String get lastname => _lastname;
  set lastname(String lastname) => _lastname = lastname;
  String get email => _email;
  set email(String email) => _email = email;
  String get mobile => _mobile;
  set mobile(String mobile) => _mobile = mobile;
  String get gender => _gender;
  set gender(String gender) => _gender = gender;
  String get profileImage => _profileImage;
  set profileImage(String profileImage) => _profileImage = profileImage;
  String get dateOfBirth => _dateOfBirth;
  set dateOfBirth(String dateOfBirth) => _dateOfBirth = dateOfBirth;
  String get password => _password;
  set password(String password) => _password = password;
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String confirmPassword) => _confirmPassword = confirmPassword;
  String get countryName => _countryName;
  set countryName(String countryName) => _countryName = countryName;
  String get createdAt => _createdAt;
  set createdAt(String createdAt) => _createdAt = createdAt;
  String get updatedAt => _updatedAt;
  set updatedAt(String updatedAt) => _updatedAt = updatedAt;
  String get lastLogin => _lastLogin;
  set lastLogin(String lastLogin) => _lastLogin = lastLogin;
  String get status => _status;
  set status(String status) => _status = status;
  String get isNotify => _isNotify;
  set isNotify(String isNotify) => _isNotify = isNotify;
  String get otp => _otp;
  set otp(String otp) => _otp = otp;
  String get availableCredit => _availableCredit;
  set availableCredit(String availableCredit) => _availableCredit = availableCredit;
  String get randomToken => _randomToken;
  set randomToken(String randomToken) => _randomToken = randomToken;
  String get deviceToken => _deviceToken;
  set deviceToken(String deviceToken) => _deviceToken = deviceToken;
  String get imeiNumber => _imeiNumber;
  set imeiNumber(String imeiNumber) => _imeiNumber = imeiNumber;
  String get deviceType => _deviceType;
  set deviceType(String deviceType) => _deviceType = deviceType;

  OwnerData.fromJson(Map<String, dynamic> json) {
    _customerId = json['customer_id'];
    _firstname = json['firstname'];
    _lastname = json['lastname'];
    _email = json['email'];
    _mobile = json['mobile'];
    _gender = json['gender'];
    _profileImage = json['profile_image'];
    _dateOfBirth = json['date_of_birth'];
    _password = json['password'];
    _confirmPassword = json['confirm_password'];
    _countryName = json['country_name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _lastLogin = json['last_login'];
    _status = json['status'];
    _isNotify = json['is_notify'];
    _otp = json['otp'];
    _availableCredit = json['available_credit'];
    _randomToken = json['random_token'];
    _deviceToken = json['device_token'];
    _imeiNumber = json['imei_number'];
    _deviceType = json['device_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this._customerId;
    data['firstname'] = this._firstname;
    data['lastname'] = this._lastname;
    data['email'] = this._email;
    data['mobile'] = this._mobile;
    data['gender'] = this._gender;
    data['profile_image'] = this._profileImage;
    data['date_of_birth'] = this._dateOfBirth;
    data['password'] = this._password;
    data['confirm_password'] = this._confirmPassword;
    data['country_name'] = this._countryName;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['last_login'] = this._lastLogin;
    data['status'] = this._status;
    data['is_notify'] = this._isNotify;
    data['otp'] = this._otp;
    data['available_credit'] = this._availableCredit;
    data['random_token'] = this._randomToken;
    data['device_token'] = this._deviceToken;
    data['imei_number'] = this._imeiNumber;
    data['device_type'] = this._deviceType;
    return data;
  }
}

class Gallery {
  String _image;
  String _thumbnail;
  String _type;

  Gallery({String image, String thumbnail, String type}) {
    this._image = image;
    this._thumbnail = thumbnail;
    this._type = type;
  }

  String get image => _image;
  set image(String image) => _image = image;
  String get thumbnail => _thumbnail;
  set thumbnail(String thumbnail) => _thumbnail = thumbnail;
  String get type => _type;
  set type(String type) => _type = type;

  Gallery.fromJson(Map<String, dynamic> json) {
    _image = json['image'];
    _thumbnail = json['thumbnail'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this._image;
    data['thumbnail'] = this._thumbnail;
    data['type'] = this._type;
    return data;
  }
}