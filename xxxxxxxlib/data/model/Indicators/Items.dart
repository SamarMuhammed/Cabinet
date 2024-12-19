import 'dart:convert';

/// name : "عدد الدول"
/// value : "190.000"

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));
String itemsToJson(Items data) => json.encode(data.toJson());
class Items {
  Items({
      String? name, 
      String? value,}){
    _name = name;
    _value = value;
}

  Items.fromJson(dynamic json) {
    _name = json['name'];
    _value = json['value'];
  }
  String? _name;
  String? _value;
Items copyWith({  String? name,
  String? value,
}) => Items(  name: name ?? _name,
  value: value ?? _value,
);
  String? get name => _name;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['value'] = _value;
    return map;
  }

}