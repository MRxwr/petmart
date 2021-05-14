class PostDetailsModel {
  String status;
  String message;
  Data data;

  PostDetailsModel({this.status, this.message, this.data});

  PostDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String postId;
  String postPrice;
  String postName;
  String postDescription;
  String categoryName;
  String subCategoryName;
  String age;
  String ageId;
  String ageLabel;
  String gender;
  String categoryId;
  String subCategoryId;
  String contactNo;
  ContactDetail contactDetail;
  String postDate;

  int ratingCount;
  int contactCount;
  String postType;
  int postMessageCount;
  String views;
  String shared;
  List<Gallery> gallery;
  List<RelatePost> relatePost;

  Data(
      {this.postId,
        this.postPrice,
        this.postName,
        this.postDescription,
        this.categoryName,
        this.subCategoryName,
        this.age,
        this.ageId,
        this.ageLabel,
        this.gender,
        this.categoryId,
        this.subCategoryId,
        this.contactNo,
        this.contactDetail,
        this.postDate,

        this.ratingCount,
        this.contactCount,
        this.postType,
        this.postMessageCount,
        this.views,
        this.shared,
        this.gallery,
        this.relatePost});

  Data.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    postPrice = json['post_price'];
    postName = json['post_name'];
    postDescription = json['post_description'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
    age = json['age'];
    ageId = json['age_id'];
    ageLabel = json['age_label'];
    gender = json['gender'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    contactNo = json['contact_no'];
    contactDetail = json['contact_detail'] != null
        ? new ContactDetail.fromJson(json['contact_detail'])
        : null;
    postDate = json['post_date'];
    // if (json['post_message'] != null) {
    //   postMessage = new List<Null>();
    //   json['post_message'].forEach((v) {
    //     postMessage.add(new Null.fromJson(v));
    //   });
    // }
    ratingCount = json['rating_count'];
    contactCount = json['contact_count'];
    postType = json['post_type'];
    postMessageCount = json['post_message_count'];
    views = json['views'];
    shared = json['shared'];
    if (json['gallery'] != null) {
      gallery = new List<Gallery>();
      json['gallery'].forEach((v) {
        gallery.add(new Gallery.fromJson(v));
      });
    }
    if (json['relate_post'] != null) {
      relatePost = new List<RelatePost>();
      json['relate_post'].forEach((v) {
        relatePost.add(new RelatePost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['post_price'] = this.postPrice;
    data['post_name'] = this.postName;
    data['post_description'] = this.postDescription;
    data['category_name'] = this.categoryName;
    data['sub_category_name'] = this.subCategoryName;
    data['age'] = this.age;
    data['age_id'] = this.ageId;
    data['age_label'] = this.ageLabel;
    data['gender'] = this.gender;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['contact_no'] = this.contactNo;
    if (this.contactDetail != null) {
      data['contact_detail'] = this.contactDetail.toJson();
    }
    data['post_date'] = this.postDate;
    // if (this.postMessage != null) {
    //   data['post_message'] = this.postMessage.map((v) => v.toJson()).toList();
    // }
    data['rating_count'] = this.ratingCount;
    data['contact_count'] = this.contactCount;
    data['post_type'] = this.postType;
    data['post_message_count'] = this.postMessageCount;
    data['views'] = this.views;
    data['shared'] = this.shared;
    if (this.gallery != null) {
      data['gallery'] = this.gallery.map((v) => v.toJson()).toList();
    }
    if (this.relatePost != null) {
      data['relate_post'] = this.relatePost.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactDetail {
  String postId;
  String postCreatedDate;
  String customerId;
  String customerName;
  String email;
  String mobile;
  String profileImage;

  ContactDetail(
      {this.postId,
        this.postCreatedDate,
        this.customerId,
        this.customerName,
        this.email,
        this.mobile,
        this.profileImage});

  ContactDetail.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    postCreatedDate = json['post_created_date'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    email = json['email'];
    mobile = json['mobile'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['post_created_date'] = this.postCreatedDate;
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profile_image'] = this.profileImage;
    return data;
  }
}

class Gallery {
  String image;

  Gallery({this.image});

  Gallery.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class RelatePost {
  String postId;
  String postImage;
  String postPrice;
  String postName;
  String postType;
  String postDate;
  int imageCount;
  List<Gallery> gallery;

  RelatePost(
      {this.postId,
        this.postImage,
        this.postPrice,
        this.postName,
        this.postType,
        this.postDate,
        this.imageCount,
        this.gallery});

  RelatePost.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    postImage = json['post_image'];
    postPrice = json['post_price'];
    postName = json['post_name'];
    postType = json['post_type'];
    postDate = json['post_date'];
    imageCount = json['image_count'];
    if (json['gallery'] != null) {
      gallery = new List<Gallery>();
      json['gallery'].forEach((v) {
        gallery.add(new Gallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['post_image'] = this.postImage;
    data['post_price'] = this.postPrice;
    data['post_name'] = this.postName;
    data['post_type'] = this.postType;
    data['post_date'] = this.postDate;
    data['image_count'] = this.imageCount;
    if (this.gallery != null) {
      data['gallery'] = this.gallery.map((v) => v.toJson()).toList();
    }
    return data;
  }
}