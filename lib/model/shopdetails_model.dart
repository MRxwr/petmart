class ShopdetailsModel {
  String status;
  String message;
  List<Data> data;

  ShopdetailsModel({this.status, this.message, this.data});

  ShopdetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String shopId;
  String shopName;
  String shopImage;
  List<ShopProducts> shopProducts;

  Data({this.shopId, this.shopName, this.shopImage, this.shopProducts});

  Data.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    shopName = json['shop_name'];
    shopImage = json['shop_image'];
    if (json['shop_products'] != null) {
      shopProducts = new List<ShopProducts>();
      json['shop_products'].forEach((v) {
        shopProducts.add(new ShopProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_id'] = this.shopId;
    data['shop_name'] = this.shopName;
    data['shop_image'] = this.shopImage;
    if (this.shopProducts != null) {
      data['shop_products'] = this.shopProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopProducts {
  String postId;
  String postImage;
  String postPrice;
  String postName;
  String postDate;
  int imageCount;
  List<String> gallery;

  ShopProducts(
      {this.postId,
        this.postImage,
        this.postPrice,
        this.postName,
        this.postDate,
        this.imageCount,
        this.gallery});

  ShopProducts.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    postImage = json['post_image'];
    postPrice = json['post_price'];
    postName = json['post_name'];
    postDate = json['post_date'];
    imageCount = json['image_count'];
    gallery = json['gallery'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['post_image'] = this.postImage;
    data['post_price'] = this.postPrice;
    data['post_name'] = this.postName;
    data['post_date'] = this.postDate;
    data['image_count'] = this.imageCount;
    data['gallery'] = this.gallery;
    return data;
  }
}