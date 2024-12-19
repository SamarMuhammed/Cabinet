import 'dart:convert';
/// id : 1
/// name : "أخبار وآراء"
/// eName : "News"
/// iconName : "http://41.218.217.999:topics/infp.png"

SelectedCat selectedCatFromJson(String str) => SelectedCat.fromJson(json.decode(str));
String selectedCatToJson(SelectedCat data) => json.encode(data.toJson());
class SelectedCat {
  SelectedCat({
      int? id, 
      String? name, 
      String? eName, 
      String? iconName,}){
    _id = id;
    _name = name;
    _eName = eName;
    _iconName = iconName;
}

  SelectedCat.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _eName = json['eName'];
    _iconName = json['iconName'];
  }
  int? _id;
  String? _name;
  String? _eName;
  String? _iconName;
SelectedCat copyWith({  int? id,
  String? name,
  String? eName,
  String? iconName,
}) => SelectedCat(  id: id ?? _id,
  name: name ?? _name,
  eName: eName ?? _eName,
  iconName: iconName ?? _iconName,
);
  int? get id => _id;
  String? get name => _name;
  String? get eName => _eName;
  String? get iconName => _iconName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['eName'] = _eName;
    map['iconName'] = _iconName;
    return map;
  }

}