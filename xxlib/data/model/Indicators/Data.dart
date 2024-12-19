import 'dart:convert';

/// date : "2021/2022"
/// registerDate : "0001-01-01T00:00:00"
/// value : 138.33
import 'dart:convert';

/// id : 1842
/// date : "2022-04-14"
/// registerDate : "2022-04-14T12:38:00"
/// value : -0.33

Data DataFromJson(String str) => Data.fromJson(json.decode(str));
String DataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
    int? id,
    String? date,
    String? registerDate,
    num? value,}){
    _id = id;
    _date = date;
    _registerDate = registerDate;
    _value = value;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _registerDate = json['registerDate'];
    _value = json['value'];
  }
  int? _id;
  String? _date;
  String? _registerDate;
  num? _value;
  Data copyWith({  int? id,
    String? date,
    String? registerDate,
    double? value,
  }) => Data(  id: id ?? _id,
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

