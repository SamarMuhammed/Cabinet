import 'dart:convert';
/// id : 1220
/// createDate : "4/18/2022"
/// title : "قرار يهمك :- رئيس الوزراء يصدر قراراً بتحديد الإجازة الرسمية لعيد العمال وعيد الفطر المبارك"
/// description : "رئيس الوزراء يصدر قرار بتحديد الإجازة الرسمية بمناسبة عيد العمال وعيد الفطر المبارك\" \r\nأصدر الدكتور مصطفى مدبولي، رئيس مجلس الوزراء، قراراً بأن تكون الفترة من يوم السبت 30 أبريل 2022، حتى يوم الخميس 5 مايو  2022، إجازة رسمية مدفوعة الأجر فى الوزارات والمصالح الحكومية، وذلك بمناسبة عيد العمال، وعيد الفطر المبارك. \r\nيسري القرار ايضا على الهيئات العامة ووحدات الإدارة المحلية وشركات القطاع العام وشركات قطاع الأعمال العام."
/// topicID : 1
/// topicName : "كوفيد-19"
/// link : null
/// hashtags : " مركز_المعلومات_ودعم_اتخاذ_القرار, قرار_يهمك, IDSC"
/// attachments : [{"id":1407,"attach":"http://idscapp.gov.eg/public/upload/media/Attachment/1220/MediaFile0.jpg"}]

Media mediaFromJson(String str) => Media.fromJson(json.decode(str));
String mediaToJson(Media data) => json.encode(data.toJson());
class Media {
  Media({
      int? id, 
      String? createDate, 
      String? title, 
      String? description, 
      int? topicID, 
      String? topicName, 
      dynamic link, 
      String? hashtags,
    String? categoryName,
    List<Attachments>? attachments,}){
    _id = id;
    _createDate = createDate;
    _title = title;
    _description = description;
    _topicID = topicID;
    _topicName = topicName;
    _link = link;
    _hashtags = hashtags;
    _categoryName = categoryName;
    _attachments = attachments;
}

  Media.fromJson(dynamic json) {
    _id = json['id'];
    _createDate = json['createDate'];
    _title = json['title'];
    _description = json['description'];
    _topicID = json['topicID'];
    _topicName = json['topicName'];
    _link = json['link'];
    _categoryName = json['categoryName'];
    _hashtags = json['hashtags'];
    if (json['attachments'] != null) {
      _attachments = [];
      json['attachments'].forEach((v) {
        _attachments?.add(Attachments.fromJson(v));
      });
    }
  }
  int? _id;
  String? _createDate;
  String? _title;
  String? _description;
  int? _topicID;
  String? _topicName;
  dynamic _link;
  String? _hashtags;
  String? _categoryName;
  List<Attachments>? _attachments;
Media copyWith({  int? id,
  String? createDate,
  String? title,
  String? description,
  int? topicID,
  String? topicName,
  dynamic link,
  String? hashtags,
  String? categoryName,
  List<Attachments>? attachments,
}) => Media(  id: id ?? _id,
  createDate: createDate ?? _createDate,
  title: title ?? _title,
  description: description ?? _description,
  topicID: topicID ?? _topicID,
  topicName: topicName ?? _topicName,
  link: link ?? _link,
  hashtags: hashtags ?? _hashtags,
  categoryName: categoryName ?? _categoryName,
  attachments: attachments ?? _attachments,
);
  int? get id => _id;
  String? get createDate => _createDate;
  String? get title => _title;
  String? get description => _description;
  int? get topicID => _topicID;
  String? get topicName => _topicName;
  dynamic get link => _link;
  String? get hashtags => _hashtags;
  String? get categoryName => _categoryName;
  List<Attachments>? get attachments => _attachments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['createDate'] = _createDate;
    map['title'] = _title;
    map['description'] = _description;
    map['topicID'] = _topicID;
    map['topicName'] = _topicName;
    map['link'] = _link;
    map['hashtags'] = _hashtags;
    map['categoryName'] = _categoryName;
    if (_attachments != null) {
      map['attachments'] = _attachments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1407
/// attach : "http://idscapp.gov.eg/public/upload/media/Attachment/1220/MediaFile0.jpg"

Attachments attachmentsFromJson(String str) => Attachments.fromJson(json.decode(str));
String attachmentsToJson(Attachments data) => json.encode(data.toJson());
class Attachments {
  Attachments({
      int? id, 
      String? attach,
  int? playingstatus =0,
  }){
    _id = id;
    _attach = attach;
}

  Attachments.fromJson(dynamic json) {
    _id = json['id'];
    _attach = json['attach'];

  }
  int? _id;
  String? _attach;
  int? playingstatus =0;
Attachments copyWith({  int? id,
  String? attach,
  int?playingstatus=0,
}) => Attachments(  id: id ?? _id,
  attach: attach ?? _attach,

);
  int? get id => _id;
  String? get attach => _attach;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['attach'] = _attach;

    return map;
  }

}