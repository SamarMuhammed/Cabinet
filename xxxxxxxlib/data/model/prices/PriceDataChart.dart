import 'dart:convert';
/// pricesData : [{"id":0,"date":"2022-05-31","registerDate":"0001-01-01T00:00:00","value":12},{"id":0,"date":"2022-06-01","registerDate":"0001-01-01T00:00:00","value":11},{"id":0,"date":"2022-06-02","registerDate":"0001-01-01T00:00:00","value":11},{"id":0,"date":"2022-06-03","registerDate":"0001-01-01T00:00:00","value":11},{"id":0,"date":"2022-06-04","registerDate":"0001-01-01T00:00:00","value":11},{"id":0,"date":"2022-06-05","registerDate":"0001-01-01T00:00:00","value":10},{"id":0,"date":"2022-06-06","registerDate":"0001-01-01T00:00:00","value":11},{"id":0,"date":"2022-06-07","registerDate":"0001-01-01T00:00:00","value":11},{"id":0,"date":"2022-06-08","registerDate":"0001-01-01T00:00:00","value":10},{"id":0,"date":"2022-06-09","registerDate":"0001-01-01T00:00:00","value":9},{"id":0,"date":"2022-06-10","registerDate":"0001-01-01T00:00:00","value":9},{"id":0,"date":"2022-06-11","registerDate":"0001-01-01T00:00:00","value":8},{"id":0,"date":"2022-06-12","registerDate":"0001-01-01T00:00:00","value":7},{"id":0,"date":"2022-06-13","registerDate":"0001-01-01T00:00:00","value":8},{"id":0,"date":"2022-06-14","registerDate":"0001-01-01T00:00:00","value":7},{"id":0,"date":"2022-06-15","registerDate":"0001-01-01T00:00:00","value":7}]
/// maxGovs : [{"name":"alex","value":12},{"name":"alex","value":12},null]
/// minGovs : [{"name":"alex","value":12},{"name":"alex","value":12},null]

PriceDataChart priceDataChartFromJson(String str) => PriceDataChart.fromJson(json.decode(str));
String priceDataChartToJson(PriceDataChart data) => json.encode(data.toJson());
class PriceDataChart {
  PriceDataChart({
      List<PricesData>? pricesData, 
      List<MaxGovs>? maxGovs, 
      List<MinGovs>? minGovs,}){
    _pricesData = pricesData;
    _maxGovs = maxGovs;
    _minGovs = minGovs;
}

  PriceDataChart.fromJson(dynamic json) {
    if (json['pricesData'] != null) {
      _pricesData = [];
      json['pricesData'].forEach((v) {
        _pricesData?.add(PricesData.fromJson(v));
      });
    }
    if (json['maxGovs'] != null) {
      _maxGovs = [];
      json['maxGovs'].forEach((v) {
        _maxGovs?.add(MaxGovs.fromJson(v));
      });
    }
    if (json['minGovs'] != null) {
      _minGovs = [];
      json['minGovs'].forEach((v) {
        _minGovs?.add(MinGovs.fromJson(v));
      });
    }
  }
  List<PricesData>? _pricesData;
  List<MaxGovs>? _maxGovs;
  List<MinGovs>? _minGovs;
PriceDataChart copyWith({  List<PricesData>? pricesData,
  List<MaxGovs>? maxGovs,
  List<MinGovs>? minGovs,
}) => PriceDataChart(  pricesData: pricesData ?? _pricesData,
  maxGovs: maxGovs ?? _maxGovs,
  minGovs: minGovs ?? _minGovs,
);
  List<PricesData>? get pricesData => _pricesData;
  List<MaxGovs>? get maxGovs => _maxGovs;
  List<MinGovs>? get minGovs => _minGovs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_pricesData != null) {
      map['pricesData'] = _pricesData?.map((v) => v.toJson()).toList();
    }
    if (_maxGovs != null) {
      map['maxGovs'] = _maxGovs?.map((v) => v.toJson()).toList();
    }
    if (_minGovs != null) {
      map['minGovs'] = _minGovs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "alex"
/// value : 12

MinGovs minGovsFromJson(String str) => MinGovs.fromJson(json.decode(str));
String minGovsToJson(MinGovs data) => json.encode(data.toJson());
class MinGovs {
  MinGovs({
    String? govName,
    num? value,}){
    _govName = govName;
    _value = value;
  }

  MinGovs.fromJson(dynamic json) {
    _govName = json['govName'];
    _value = json['value'];
  }
  String? _govName;
  num? _value;
  MinGovs copyWith({  String? govName,
    num? value,
  }) => MinGovs(  govName: govName ?? _govName,
    value: value ?? _value,
  );
  String? get govName => _govName;
  num? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['govName'] = _govName;
    map['value'] = _value;
    return map;
  }

}

/// name : "alex"
/// value : 12

MaxGovs maxGovsFromJson(String str) => MaxGovs.fromJson(json.decode(str));
String maxGovsToJson(MaxGovs data) => json.encode(data.toJson());
class MaxGovs {
  MaxGovs({
    String? govName,
    num? value,}){
    _govName = govName;
    _value = value;
  }

  MaxGovs.fromJson(dynamic json) {
    _govName = json['govName'];
    _value = json['value'];
  }
  String? _govName;
  num? _value;
  MaxGovs copyWith({  String? govName,
    num? value,
  }) => MaxGovs(  govName: govName ?? _govName,
    value: value ?? _value,
  );
  String? get govName => _govName;
  num? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['govName'] = _govName;
    map['value'] = _value;
    return map;
  }

}

/// id : 0
/// date : "2022-05-31"
/// registerDate : "0001-01-01T00:00:00"
/// value : 12

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