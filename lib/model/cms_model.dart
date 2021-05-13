/// status : "success"
/// message : "Page data retrived."
/// data : {"page_id":"10","page_content":"jsjsdjsjjsddj"}

class CmsModel {
  String status;
  String message;
  Data data;

  CmsModel({this.status, this.message, this.data});

  CmsModel.fromJson(Map<String, dynamic> json) {
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

/// page_id : "10"
/// page_content : "jsjsdjsjjsddj"

class Data {
  String pageId;
  String pageContent;

  Data({this.pageId, this.pageContent});

  Data.fromJson(Map<String, dynamic> json) {
    pageId = json['page_id'];
    pageContent = json['page_content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_id'] = this.pageId;
    data['page_content'] = this.pageContent;
    return data;
  }
}