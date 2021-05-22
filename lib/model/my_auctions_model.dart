class MyAuctionsModel {
  String _status;
  String _message;
  Data _data;

  MyAuctionsModel({String status, String message, Data data}) {
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

  MyAuctionsModel.fromJson(Map<String, dynamic> json) {
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
  List<AuctionData> _auctionData;

  Data({List<AuctionData> auctionData}) {
    this._auctionData = auctionData;
  }

  List<AuctionData> get auctionData => _auctionData;
  set auctionData(List<AuctionData> auctionData) => _auctionData = auctionData;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['auction_data'] != null) {
      _auctionData = new List<AuctionData>();
      json['auction_data'].forEach((v) {
        _auctionData.add(new AuctionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._auctionData != null) {
      data['auction_data'] = this._auctionData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AuctionData {
  String _auctionId;
  String _auctionName;
  String _auctionStatus;
  int _imageCount;
  String _auctionDescription;
  String _auctionRemaining;
  String _auctionDate;
  String _category;
  String _stateDate;
  String _endDate;
  String _bidValue;
  String _acutionImage;
  List<Gallery> _gallery;

  AuctionData(
      {String auctionId,
        String auctionName,
        String auctionStatus,
        int imageCount,
        String auctionDescription,
        String auctionRemaining,
        String auctionDate,
        String category,
        String stateDate,
        String endDate,
        String bidValue,
        String acutionImage,
        List<Gallery> gallery}) {
    this._auctionId = auctionId;
    this._auctionName = auctionName;
    this._auctionStatus = auctionStatus;
    this._imageCount = imageCount;
    this._auctionDescription = auctionDescription;
    this._auctionRemaining = auctionRemaining;
    this._auctionDate = auctionDate;
    this._category = category;
    this._stateDate = stateDate;
    this._endDate = endDate;
    this._bidValue = bidValue;
    this._acutionImage = acutionImage;
    this._gallery = gallery;
  }

  String get auctionId => _auctionId;
  set auctionId(String auctionId) => _auctionId = auctionId;
  String get auctionName => _auctionName;
  set auctionName(String auctionName) => _auctionName = auctionName;
  String get auctionStatus => _auctionStatus;
  set auctionStatus(String auctionStatus) => _auctionStatus = auctionStatus;
  int get imageCount => _imageCount;
  set imageCount(int imageCount) => _imageCount = imageCount;
  String get auctionDescription => _auctionDescription;
  set auctionDescription(String auctionDescription) =>
      _auctionDescription = auctionDescription;
  String get auctionRemaining => _auctionRemaining;
  set auctionRemaining(String auctionRemaining) =>
      _auctionRemaining = auctionRemaining;
  String get auctionDate => _auctionDate;
  set auctionDate(String auctionDate) => _auctionDate = auctionDate;
  String get category => _category;
  set category(String category) => _category = category;
  String get stateDate => _stateDate;
  set stateDate(String stateDate) => _stateDate = stateDate;
  String get endDate => _endDate;
  set endDate(String endDate) => _endDate = endDate;
  String get bidValue => _bidValue;
  set bidValue(String bidValue) => _bidValue = bidValue;
  String get acutionImage => _acutionImage;
  set acutionImage(String acutionImage) => _acutionImage = acutionImage;
  List<Gallery> get gallery => _gallery;
  set gallery(List<Gallery> gallery) => _gallery = gallery;

  AuctionData.fromJson(Map<String, dynamic> json) {
    _auctionId = json['auction_id'];
    _auctionName = json['auction_name'];
    _auctionStatus = json['auction_status'];
    _imageCount = json['image_count'];
    _auctionDescription = json['auction_description'];
    _auctionRemaining = json['auction_remaining'];
    _auctionDate = json['auction_date'];
    _category = json['category'];
    _stateDate = json['state_date'];
    _endDate = json['end_date'];
    _bidValue = json['bid_value'];
    _acutionImage = json['acution_image'];
    if (json['gallery'] != null) {
      _gallery = new List<Gallery>();
      json['gallery'].forEach((v) {
        _gallery.add(new Gallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auction_id'] = this._auctionId;
    data['auction_name'] = this._auctionName;
    data['auction_status'] = this._auctionStatus;
    data['image_count'] = this._imageCount;
    data['auction_description'] = this._auctionDescription;
    data['auction_remaining'] = this._auctionRemaining;
    data['auction_date'] = this._auctionDate;
    data['category'] = this._category;
    data['state_date'] = this._stateDate;
    data['end_date'] = this._endDate;
    data['bid_value'] = this._bidValue;
    data['acution_image'] = this._acutionImage;
    if (this._gallery != null) {
      data['gallery'] = this._gallery.map((v) => v.toJson()).toList();
    }
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
