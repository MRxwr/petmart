import 'package:equatable/equatable.dart';

/// ok : true
/// error : "0"
/// status : "successful"
/// data : {"category":[{"id":"2","parentId":"0","arTitle":"طيور","enTitle":"Birds","sub":[{"id":"3","parentId":"2","arTitle":"صقور","enTitle":"Falcons"},{"id":"10","parentId":"2","arTitle":"نسور","enTitle":"Eagles"}]},{"id":"8","parentId":"0","arTitle":"حيوانات","enTitle":"Animals","sub":[{"id":"9","parentId":"8","arTitle":"بط","enTitle":"Ducks"}]}],"lost":[{"id":"4","parentId":"0","arTitle":"قطط","enTitle":"Cats","sub":[{"id":"5","parentId":"4","arTitle":"شيرازي","enTitle":"Persian"}]}],"adoption":[{"id":"6","parentId":"0","arTitle":"كلاب","enTitle":"Dogs","sub":[{"id":"7","parentId":"6","arTitle":"هسكي سيبيري","enTitle":"Siberian Husky"}]}],"gender":{"arabic":["زوج","ذكر","انثى","غير معروف"],"English":["Couple","Male","Female","Not Applicable"]},"ageType":{"arabic":["يوم","إسبوع","شهر","سنة"],"English":["Day","Week","Month","Year"]}}

class InitModel {
  InitModel({
      bool ok, 
      String error, 
      String status, 
      Data data,}){
    _ok = ok;
    _error = error;
    _status = status;
    _data = data;
}

  InitModel.fromJson(dynamic json) {
    _ok = json['ok'];
    _error = json['error'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool _ok;
  String _error;
  String _status;
  Data _data;
InitModel copyWith({  bool ok,
  String error,
  String status,
  Data data,
}) => InitModel(  ok: ok ?? _ok,
  error: error ?? _error,
  status: status ?? _status,
  data: data ?? _data,
);
  bool get ok => _ok;
  String get error => _error;
  String get status => _status;
  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ok'] = _ok;
    map['error'] = _error;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

/// category : [{"id":"2","parentId":"0","arTitle":"طيور","enTitle":"Birds","sub":[{"id":"3","parentId":"2","arTitle":"صقور","enTitle":"Falcons"},{"id":"10","parentId":"2","arTitle":"نسور","enTitle":"Eagles"}]},{"id":"8","parentId":"0","arTitle":"حيوانات","enTitle":"Animals","sub":[{"id":"9","parentId":"8","arTitle":"بط","enTitle":"Ducks"}]}]
/// lost : [{"id":"4","parentId":"0","arTitle":"قطط","enTitle":"Cats","sub":[{"id":"5","parentId":"4","arTitle":"شيرازي","enTitle":"Persian"}]}]
/// adoption : [{"id":"6","parentId":"0","arTitle":"كلاب","enTitle":"Dogs","sub":[{"id":"7","parentId":"6","arTitle":"هسكي سيبيري","enTitle":"Siberian Husky"}]}]
/// gender : {"arabic":["زوج","ذكر","انثى","غير معروف"],"English":["Couple","Male","Female","Not Applicable"]}
/// ageType : {"arabic":["يوم","إسبوع","شهر","سنة"],"English":["Day","Week","Month","Year"]}

class Data {
  Data({
      List<Category> category, 
      List<Category> lost,
      List<Category> adoption,
      Gender gender, 
      AgeType ageType,}){
    _category = category;
    _lost = lost;
    _adoption = adoption;
    _gender = gender;
    _ageType = ageType;
}

  Data.fromJson(dynamic json) {
    if (json['category'] != null) {
      _category = [];
      json['category'].forEach((v) {
        _category.add(Category.fromJson(v));
      });
    }
    if (json['lost'] != null) {
      _lost = [];
      json['lost'].forEach((v) {
        _lost.add(Category.fromJson(v));
      });
    }
    if (json['adoption'] != null) {
      _adoption = [];
      json['adoption'].forEach((v) {
        _adoption.add(Category.fromJson(v));
      });
    }
    _gender = json['gender'] != null ? Gender.fromJson(json['gender']) : null;
    _ageType = json['ageType'] != null ? AgeType.fromJson(json['ageType']) : null;
  }
  List<Category> _category;
  List<Category> _lost;
  List<Category> _adoption;
  Gender _gender;
  AgeType _ageType;
Data copyWith({  List<Category> category,
  List<Category> lost,
  List<Category> adoption,
  Gender gender,
  AgeType ageType,
}) => Data(  category: category ?? _category,
  lost: lost ?? _lost,
  adoption: adoption ?? _adoption,
  gender: gender ?? _gender,
  ageType: ageType ?? _ageType,
);
  List<Category> get category => _category;
  List<Category> get lost => _lost;
  List<Category> get adoption => _adoption;
  Gender get gender => _gender;
  AgeType get ageType => _ageType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_category != null) {
      map['category'] = _category.map((v) => v.toJson()).toList();
    }
    if (_lost != null) {
      map['lost'] = _lost.map((v) => v.toJson()).toList();
    }
    if (_adoption != null) {
      map['adoption'] = _adoption.map((v) => v.toJson()).toList();
    }
    if (_gender != null) {
      map['gender'] = _gender.toJson();
    }
    if (_ageType != null) {
      map['ageType'] = _ageType.toJson();
    }
    return map;
  }

}

/// arabic : ["يوم","إسبوع","شهر","سنة"]
/// English : ["Day","Week","Month","Year"]

class AgeType {
  AgeType({
      List<String> arabic, 
      List<String> english,}){
    _arabic = arabic;
    _english = english;
}

  AgeType.fromJson(dynamic json) {
    _arabic = json['arabic'] != null ? json['arabic'].cast<String>() : [];
    _english = json['English'] != null ? json['English'].cast<String>() : [];
  }
  List<String> _arabic;
  List<String> _english;
AgeType copyWith({  List<String> arabic,
  List<String> english,
}) => AgeType(  arabic: arabic ?? _arabic,
  english: english ?? _english,
);
  List<String> get arabic => _arabic;
  List<String> get english => _english;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['arabic'] = _arabic;
    map['English'] = _english;
    return map;
  }

}

/// arabic : ["زوج","ذكر","انثى","غير معروف"]
/// English : ["Couple","Male","Female","Not Applicable"]

class Gender {
  Gender({
      List<String> arabic, 
      List<String> english,}){
    _arabic = arabic;
    _english = english;
}

  Gender.fromJson(dynamic json) {
    _arabic = json['arabic'] != null ? json['arabic'].cast<String>() : [];
    _english = json['English'] != null ? json['English'].cast<String>() : [];
  }
  List<String> _arabic;
  List<String> _english;
Gender copyWith({  List<String> arabic,
  List<String> english,
}) => Gender(  arabic: arabic ?? _arabic,
  english: english ?? _english,
);
  List<String> get arabic => _arabic;
  List<String> get english => _english;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['arabic'] = _arabic;
    map['English'] = _english;
    return map;
  }

}

/// id : "6"
/// parentId : "0"
/// arTitle : "كلاب"
/// enTitle : "Dogs"
/// sub : [{"id":"7","parentId":"6","arTitle":"هسكي سيبيري","enTitle":"Siberian Husky"}]



/// id : "7"
/// parentId : "6"
/// arTitle : "هسكي سيبيري"
/// enTitle : "Siberian Husky"

class Sub  extends Equatable{
  Sub({
      String id, 
      String parentId,
      String arTitle, 
      String enTitle,}){
    _id = id;
    _parentId = parentId;
    _arTitle = arTitle;
    _enTitle = enTitle;
}

  Sub.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parentId'];
    _arTitle = json['arTitle'];
    _enTitle = json['enTitle'];
  }

  String name = "tag";
  String _id;
  String _parentId;
  String _arTitle;
  String _enTitle;
Sub copyWith({  String id,
  String parentId,
  String arTitle,
  String enTitle,
}) => Sub(  id: id ?? _id,
  parentId: parentId ?? _parentId,
  arTitle: arTitle ?? _arTitle,
  enTitle: enTitle ?? _enTitle,
);
  String get id => _id;
  String get parentId => _parentId;
  String get arTitle => _arTitle;
  String get enTitle => _enTitle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parentId'] = _parentId;
    map['arTitle'] = _arTitle;
    map['enTitle'] = _enTitle;
    return map;
  }

  @override
  int get hashCode => super.hashCode;


  // TODO: implement props
  @override
  List<Object> get props => [id,enTitle,arTitle,parentId];
}

/// id : "4"
/// parentId : "0"
/// arTitle : "قطط"
/// enTitle : "Cats"
/// sub : [{"id":"5","parentId":"4","arTitle":"شيرازي","enTitle":"Persian"}]



/// id : "5"
/// parentId : "4"
/// arTitle : "شيرازي"
/// enTitle : "Persian"



/// id : "2"
/// parentId : "0"
/// arTitle : "طيور"
/// enTitle : "Birds"
/// sub : [{"id":"3","parentId":"2","arTitle":"صقور","enTitle":"Falcons"},{"id":"10","parentId":"2","arTitle":"نسور","enTitle":"Eagles"}]

class Category  extends Equatable {
  Category({
      String id, 
      String parentId,
      String arTitle, 
      String enTitle, 
      List<Sub> sub,}){
    _id = id;
    _parentId = parentId;
    _arTitle = arTitle;
    _enTitle = enTitle;
    _sub = sub;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parentId'];
    _arTitle = json['arTitle'];
    _enTitle = json['enTitle'];
    if (json['sub'] != null) {
      _sub = [];
      json['sub'].forEach((v) {
        _sub.add(Sub.fromJson(v));
      });
    }
  }
  String _id;
  String _parentId;
  String _arTitle;
  String _enTitle;
  List<Sub> _sub;

Category copyWith({  String id,
  String parentId,
  String arTitle,
  String enTitle,
  List<Sub> sub,
}) => Category(  id: id ?? _id,
  parentId: parentId ?? _parentId,
  arTitle: arTitle ?? _arTitle,
  enTitle: enTitle ?? _enTitle,
  sub: sub ?? _sub,
);
  String get id => _id;
  String get parentId => _parentId;
  String get arTitle => _arTitle;
  String get enTitle => _enTitle;
  List<Sub> get sub => _sub;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parentId'] = _parentId;
    map['arTitle'] = _arTitle;
    map['enTitle'] = _enTitle;
    if (_sub != null) {
      map['sub'] = _sub.map((v) => v.toJson()).toList();
    }
    return map;
  }


  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id,enTitle,arTitle,parentId,sub];
}

/// id : "3"
/// parentId : "2"
/// arTitle : "صقور"
/// enTitle : "Falcons"

