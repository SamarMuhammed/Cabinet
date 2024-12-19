import 'dart:convert';

/// id : 89
/// name : "نسبة العجز"
/// value : 6.7
/// unit : "%"
/// date : "2021/2022"

Indicator indicatorFromJson(String str) => Indicator.fromJson(json.decode(str));
String indicatorToJson(Indicator data) => json.encode(data.toJson());
class Indicator {
  Indicator({
      int? id, 
      String? name, 
      double? value, 
      String? unit,
      String? date,}){
    _id = id;
    _name = name;
    _value = value;
    _unit = unit;
    _date = date;
}

  Indicator.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _value = json['value'].toDouble();
    _unit = json['unit'];
    _date = json['date'];
  }
  int? _id;
  String? _name;
  double? _value;
  String? _unit;
  String? _date;
Indicator copyWith({  int? id,
  String? name,
  double? value,
  String? unit,
  String? date,
}) => Indicator(  id: id ?? _id,
  name: name ?? _name,
  value: value ?? _value,
  unit: unit ?? _unit,
  date: date ?? _date,
);
  int? get id => _id;
  String? get name => _name;
  double? get value => _value;
  String? get unit => _unit;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['value'] = _value!.toDouble();
    map['unit'] = _unit;
    map['date'] = _date;
    return map;
  }

}