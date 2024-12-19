import 'dart:convert';

/// date : "2021/2022"
/// registerDate : "2022-06-30"
/// value : 138.33

Testtest1 testtest1FromJson(String str) => Testtest1.fromJson(json.decode(str));
String testtest1ToJson(Testtest1 data) => json.encode(data.toJson());
class Testtest1 {
  Testtest1({
      String? date, 
      String? registerDate, 
      double? value,}){
    _date = date;
    _registerDate = registerDate;
    _value = value;
}

  Testtest1.fromJson(dynamic json) {
    _date = json['date'];
    _registerDate = json['registerDate'];
    _value = json['value'];
  }
  String? _date;
  String? _registerDate;
  double? _value;
Testtest1 copyWith({  String? date,
  String? registerDate,
  double? value,
}) => Testtest1(  date: date ?? _date,
  registerDate: registerDate ?? _registerDate,
  value: value ?? _value,
);
  String? get date => _date;
  String? get registerDate => _registerDate;
  double? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['registerDate'] = _registerDate;
    map['value'] = _value;
    return map;
  }

}