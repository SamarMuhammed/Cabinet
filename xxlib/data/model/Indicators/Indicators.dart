import 'Data.dart';
import 'dart:convert';

/// id : 90
/// name : "القيمة"
/// chartTypeId : 2
/// unit : "مليار جنيه"
/// data : [{"date":"2021/2022","registerDate":"0001-01-01T00:00:00","value":138.33},{"date":"2020/2021","registerDate":"0001-01-01T00:00:00","value":140.68},{"date":"2019/2020","registerDate":"0001-01-01T00:00:00","value":132.677},{"date":"2018/2019","registerDate":"0001-01-01T00:00:00","value":203.657},{"date":"2017/2018","registerDate":"0001-01-01T00:00:00","value":243.587},{"date":"2016/2017","registerDate":"0001-01-01T00:00:00","value":202.559},{"date":"2015/2016","registerDate":"0001-01-01T00:00:00","value":138.724},{"date":"2014/2015","registerDate":"0001-01-01T00:00:00","value":150.198},{"date":"2013/2014","registerDate":"0001-01-01T00:00:00","value":187.659},{"date":"2012/2013","registerDate":"0001-01-01T00:00:00","value":170.8}]

Indicators indicatorsFromJson(String str) => Indicators.fromJson(json.decode(str));
String indicatorsToJson(Indicators data) => json.encode(data.toJson());
class Indicators {
  Indicators({
      int? id, 
      String? name, 
      int? chartTypeId, 
      String? unit, 
      List<Data>? data,}){
    _id = id;
    _name = name;
    _chartTypeId = chartTypeId;
    _unit = unit;
    _data = data;
}

  Indicators.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _chartTypeId = json['chartTypeId'];
    _unit = json['unit'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  int? _chartTypeId;
  String? _unit;
  List<Data>? _data;
Indicators copyWith({  int? id,
  String? name,
  int? chartTypeId,
  String? unit,
  List<Data>? data,
}) => Indicators(  id: id ?? _id,
  name: name ?? _name,
  chartTypeId: chartTypeId ?? _chartTypeId,
  unit: unit ?? _unit,
  data: data ?? _data,
);
  int? get id => _id;
  String? get name => _name;
  int? get chartTypeId => _chartTypeId;
  String? get unit => _unit;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['chartTypeId'] = _chartTypeId;
    map['unit'] = _unit;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}