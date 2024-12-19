import 'Indicators.dart';
import 'dart:convert';

/// name : "إجمالي الدعم بالموازنة العامة للدولة"
/// chartID : 1
/// source : "وزارة المالية"
/// indicators : [{"id":90,"name":"القيمة","chartTypeId":2,"unit":"مليار جنيه","data":[{"date":"2021/2022","registerDate":"0001-01-01T00:00:00","value":138.33},{"date":"2020/2021","registerDate":"0001-01-01T00:00:00","value":140.68},{"date":"2019/2020","registerDate":"0001-01-01T00:00:00","value":132.677},{"date":"2018/2019","registerDate":"0001-01-01T00:00:00","value":203.657},{"date":"2017/2018","registerDate":"0001-01-01T00:00:00","value":243.587},{"date":"2016/2017","registerDate":"0001-01-01T00:00:00","value":202.559},{"date":"2015/2016","registerDate":"0001-01-01T00:00:00","value":138.724},{"date":"2014/2015","registerDate":"0001-01-01T00:00:00","value":150.198},{"date":"2013/2014","registerDate":"0001-01-01T00:00:00","value":187.659},{"date":"2012/2013","registerDate":"0001-01-01T00:00:00","value":170.8}]}]

IndChartData indChartDataFromJson(String str) => IndChartData.fromJson(json.decode(str));
String indChartDataToJson(IndChartData data) => json.encode(data.toJson());
class IndChartData {
  IndChartData({
      String? name, 
      int? chartID, 
      String? source, 
      List<Indicators>? indicators,}){
    _name = name;
    _chartID = chartID;
    _source = source;
    _indicators = indicators;
}

  IndChartData.fromJson(dynamic json) {
    _name = json['name'];
    _chartID = json['chartID'];
    _source = json['source'];
    if (json['indicators'] != null) {
      _indicators = [];
      json['indicators'].forEach((v) {
        print("c");
        _indicators?.add(Indicators.fromJson(v));
      });
    }
  }
  String? _name;
  int? _chartID;
  String? _source;
  List<Indicators>? _indicators;
IndChartData copyWith({  String? name,
  int? chartID,
  String? source,
  List<Indicators>? indicators,
}) => IndChartData(  name: name ?? _name,
  chartID: chartID ?? _chartID,
  source: source ?? _source,
  indicators: indicators ?? _indicators,
);
  String? get name => _name;
  int? get chartID => _chartID;
  String? get source => _source;
  List<Indicators>? get indicators => _indicators;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['chartID'] = _chartID;
    map['source'] = _source;
    if (_indicators != null) {
      map['indicators'] = _indicators?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}