import 'dart:convert';
/// name : "البنوك السعودية"
/// id : 354
/// indicators : [{"id":0,"name":"نسبة التغير اليومي","value":0.076,"unit":"%","date":"2022-04-18"},null]

CashMarkets cashMarketsFromJson(String str) => CashMarkets.fromJson(json.decode(str));
String cashMarketsToJson(CashMarkets data) => json.encode(data.toJson());
class CashMarkets {
  CashMarkets({
      String? name, 
      int? id, 
      List<Indicators>? indicators,}){
    _name = name;
    _id = id;
    _indicators = indicators;
}

  CashMarkets.fromJson(dynamic json) {
    _name = json['name'];
    _id = json['id'];
    if (json['indicators'] != null) {
      _indicators = [];
      json['indicators'].forEach((v) {
        _indicators?.add(Indicators.fromJson(v));
      });
    }
  }
  String? _name;
  int? _id;
  List<Indicators>? _indicators;

  String? get name => _name;
  int? get id => _id;
  List<Indicators>? get indicators => _indicators;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['id'] = _id;
    if (_indicators != null) {
      map['indicators'] = _indicators?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 0
/// name : "نسبة التغير اليومي"
/// value : 0.076
/// unit : "%"
/// date : "2022-04-18"

Indicators indicatorsFromJson(String str) => Indicators.fromJson(json.decode(str));
String indicatorsToJson(Indicators data) => json.encode(data.toJson());
class Indicators {
  Indicators({
      int? id, 
      String? name, 
      dynamic value,
      String? unit, 
      String? date,}){
    _id = id;
    _name = name;
    _value = value;
    _unit = unit;
    _date = date;
}

  Indicators.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _value = json['value'];
    _unit = json['unit'];
    _date = json['date'];
  }
  int? _id;
  String? _name;
 dynamic _value;
  String? _unit;
  String? _date;

  int? get id => _id;
  String? get name => _name;
  dynamic get value => _value;
  String? get unit => _unit;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['value'] = _value;
    map['unit'] = _unit;
    map['date'] = _date;
    return map;
  }

}