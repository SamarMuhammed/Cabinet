import 'dart:convert';
/// id : 712
/// periodicity : 0
/// date : "2022-06-15"
/// name : "البرنت"
/// unit : "دولار/برميل"
/// dailyPercentage : "-2.2"
/// yearlyPercentage : "60.2"
/// source : "مركز المعلومات و دعم اتخاذ القرار"
/// status : "up"
/// value : 119

PricesDataall pricesDataallFromJson(String str) => PricesDataall.fromJson(json.decode(str));
String pricesDataallToJson(PricesDataall data) => json.encode(data.toJson());
class PricesDataall {
  PricesDataall({
      int? id, 
      int? periodicity, 
      String? date, 
      String? name, 
      String? unit, 
      String? dailyPercentage, 
      String? yearlyPercentage, 
      String? source, 
      String? status, 
      int? value,}){
    _id = id;
    _periodicity = periodicity;
    _date = date;
    _name = name;
    _unit = unit;
    _dailyPercentage = dailyPercentage;
    _yearlyPercentage = yearlyPercentage;
    _source = source;
    _status = status;
    _value = value;
}

  PricesDataall.fromJson(dynamic json) {
    _id = json['id'];
    _periodicity = json['periodicity'];
    _date = json['date'];
    _name = json['name'];
    _unit = json['unit'];
    _dailyPercentage = json['dailyPercentage'];
    _yearlyPercentage = json['yearlyPercentage'];
    _source = json['source'];
    _status = json['status'];
    _value = json['value'];
  }
  int? _id;
  int? _periodicity;
  String? _date;
  String? _name;
  String? _unit;
  String? _dailyPercentage;
  String? _yearlyPercentage;
  String? _source;
  String? _status;
  int? _value;
PricesDataall copyWith({  int? id,
  int? periodicity,
  String? date,
  String? name,
  String? unit,
  String? dailyPercentage,
  String? yearlyPercentage,
  String? source,
  String? status,
  int? value,
}) => PricesDataall(  id: id ?? _id,
  periodicity: periodicity ?? _periodicity,
  date: date ?? _date,
  name: name ?? _name,
  unit: unit ?? _unit,
  dailyPercentage: dailyPercentage ?? _dailyPercentage,
  yearlyPercentage: yearlyPercentage ?? _yearlyPercentage,
  source: source ?? _source,
  status: status ?? _status,
  value: value ?? _value,
);
  int? get id => _id;
  int? get periodicity => _periodicity;
  String? get date => _date;
  String? get name => _name;
  String? get unit => _unit;
  String? get dailyPercentage => _dailyPercentage;
  String? get yearlyPercentage => _yearlyPercentage;
  String? get source => _source;
  String? get status => _status;
  int? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['periodicity'] = _periodicity;
    map['date'] = _date;
    map['name'] = _name;
    map['unit'] = _unit;
    map['dailyPercentage'] = _dailyPercentage;
    map['yearlyPercentage'] = _yearlyPercentage;
    map['source'] = _source;
    map['status'] = _status;
    map['value'] = _value;
    return map;
  }

}