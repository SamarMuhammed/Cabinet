import 'dart:convert';
/// pricesData : [{"id":0,"date":" فبراير  - 2022","registerDate":"0001-01-01T00:00:00","value":94.5},{"id":0,"date":" مارس  - 2022","registerDate":"0001-01-01T00:00:00","value":112.4},{"id":0,"date":" أبريل  - 2022","registerDate":"0001-01-01T00:00:00","value":105.9},{"id":0,"date":" مايو  - 2022","registerDate":"0001-01-01T00:00:00","value":111.9},{"id":0,"date":" يونيو  - 2022","registerDate":"0001-01-01T00:00:00","value":120.4}]

GlobalPriceChartData globalPriceChartDataFromJson(String str) => GlobalPriceChartData.fromJson(json.decode(str));
String globalPriceChartDataToJson(GlobalPriceChartData data) => json.encode(data.toJson());
class GlobalPriceChartData {
  GlobalPriceChartData({
      List<PricesData>? pricesData,}){
    _pricesData = pricesData;
}

  GlobalPriceChartData.fromJson(dynamic json) {
    if (json['pricesData'] != null) {
      _pricesData = [];
      json['pricesData'].forEach((v) {
        _pricesData?.add(PricesData.fromJson(v));
      });
    }
  }
  List<PricesData>? _pricesData;
GlobalPriceChartData copyWith({  List<PricesData>? pricesData,
}) => GlobalPriceChartData(  pricesData: pricesData ?? _pricesData,
);
  List<PricesData>? get pricesData => _pricesData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_pricesData != null) {
      map['pricesData'] = _pricesData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 0
/// date : " فبراير  - 2022"
/// registerDate : "0001-01-01T00:00:00"
/// value : 94.5

PricesData pricesDataFromJson(String str) => PricesData.fromJson(json.decode(str));
String pricesDataToJson(PricesData data) => json.encode(data.toJson());
class PricesData {
  PricesData({
      int? id,
      String? date,
      String? registerDate, 
      num? value,}){
    _id = id;
    _date = date;
    _registerDate = registerDate;
    _value = value;
}

  PricesData.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _registerDate = json['registerDate'];
    _value = json['value'];
  }
  int? _id;
  String? _date;
  String? _registerDate;
  num? _value;
PricesData copyWith({  int? id,
  String? date,
  String? registerDate,
  num? value,
}) => PricesData(  id: id ?? _id,
  date: date ?? _date,
  registerDate: registerDate ?? _registerDate,
  value: value ?? _value,
);
  int? get id => _id;
  String? get date => _date;
  String? get registerDate => _registerDate;
  num? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['registerDate'] = _registerDate;
    map['value'] = _value;
    return map;
  }

}