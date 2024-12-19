import 'dart:convert';
/// id : 0
/// date : "2022-05-31"
/// registerDate : "0001-01-01T00:00:00"
/// value : 12

PricesD pricesDFromJson(String str) => PricesD.fromJson(json.decode(str));
String pricesDToJson(PricesD data) => json.encode(data.toJson());
class PricesD {
  PricesD({
      int? id, 
      String? date, 
      String? registerDate, 
      num? value,}){
    _id = id;
    _date = date;
    _registerDate = registerDate;
    _value = value;
}

  PricesD.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _registerDate = json['registerDate'];
    _value = json['value'];
  }
  int? _id;
  String? _date;
  String? _registerDate;
  num? _value;
PricesD copyWith({  int? id,
  String? date,
  String? registerDate,
  num? value,
}) => PricesD(  id: id ?? _id,
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