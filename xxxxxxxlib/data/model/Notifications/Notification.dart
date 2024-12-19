import 'dart:convert';

/// id : 6039
/// date : "4/18/2022 12:09 PM"
/// title : "مركز معلومات مجلس الوزراء"
/// body : "القوات الأوكرانية المحاصرة في \"ماريوبول\" ترفض المطالب الروسية بالاستسلام\r\nللمزيد تابع \"نشرة الإيكونومست\". "
/// parentName : "أخبار وآراء"
/// parentId : 30852

IDSCNotification notificationFromJson(String str) => IDSCNotification.fromJson(json.decode(str));
String notificationToJson(IDSCNotification data) => json.encode(data.toJson());
class IDSCNotification {
  IDSCNotification({
      int? id, 
      String? date, 
      String? title, 
      String? body, 
      String? parentName, 
      int? parentId,}){
    _id = id;
    _date = date;
    _title = title;
    _body = body;
    _parentName = parentName;
    _parentId = parentId;
}

  IDSCNotification.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _title = json['title'];
    _body = json['body'];
    _parentName = json['parentName'];
    _parentId = json['parentId'];
  }
  int? _id;
  String? _date;
  String? _title;
  String? _body;
  String? _parentName;
  int? _parentId;
  IDSCNotification copyWith({  int? id,
  String? date,
  String? title,
  String? body,
  String? parentName,
  int? parentId,
}) => IDSCNotification(  id: id ?? _id,
  date: date ?? _date,
  title: title ?? _title,
  body: body ?? _body,
  parentName: parentName ?? _parentName,
  parentId: parentId ?? _parentId,
);
  int? get id => _id;
  String? get date => _date;
  String? get title => _title;
  String? get body => _body;
  String? get parentName => _parentName;
  int? get parentId => _parentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['title'] = _title;
    map['body'] = _body;
    map['parentName'] = _parentName;
    map['parentId'] = _parentId;
    return map;
  }

}