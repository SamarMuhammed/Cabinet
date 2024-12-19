import 'Items.dart';
import 'dart:convert';

/// id : 279
/// name : "مؤشر ممارسة الأعمال "
/// items : [{"name":"عدد الدول","value":"190.000"},{"name":"الترتيب السابق","value":"120.000"},{"name":"الترتيب الحالي","value":"114.000"},{"name":"معدل التغير","value":"6.000"}]
/// source : "البنك الدولي"
/// changeRankCheck : true
/// attachmentURL : "http://41.128.217.181:10092/wwwroot/attachment/InterIndicators/279/InterEditAttachment.pdf"
/// date : "2020"

InterIndicatorData interIndicatorDataFromJson(String str) => InterIndicatorData.fromJson(json.decode(str));
String interIndicatorDataToJson(InterIndicatorData data) => json.encode(data.toJson());
class InterIndicatorData {
  InterIndicatorData({
      int? id, 
      String? name, 
      List<Items>? items, 
      String? source, 
      bool? changeRankCheck, 
      String? attachmentURL, 
      String? date,}){
    _id = id;
    _name = name;
    _items = items;
    _source = source;
    _changeRankCheck = changeRankCheck;
    _attachmentURL = attachmentURL;
    _date = date;
}

  InterIndicatorData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    _source = json['source'];
    _changeRankCheck = json['changeRankCheck'];
    _attachmentURL = json['attachmentURL'];
    _date = json['date'];
  }
  int? _id;
  String? _name;
  List<Items>? _items;
  String? _source;
  bool? _changeRankCheck;
  String? _attachmentURL;
  String? _date;
InterIndicatorData copyWith({  int? id,
  String? name,
  List<Items>? items,
  String? source,
  bool? changeRankCheck,
  String? attachmentURL,
  String? date,
}) => InterIndicatorData(  id: id ?? _id,
  name: name ?? _name,
  items: items ?? _items,
  source: source ?? _source,
  changeRankCheck: changeRankCheck ?? _changeRankCheck,
  attachmentURL: attachmentURL ?? _attachmentURL,
  date: date ?? _date,
);
  int? get id => _id;
  String? get name => _name;
  List<Items>? get items => _items;
  String? get source => _source;
  bool? get changeRankCheck => _changeRankCheck;
  String? get attachmentURL => _attachmentURL;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    map['source'] = _source;
    map['changeRankCheck'] = _changeRankCheck;
    map['attachmentURL'] = _attachmentURL;
    map['date'] = _date;
    return map;
  }

}