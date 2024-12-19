import 'dart:convert';

/// id : 1
/// name : "مؤشرات محلية"
/// isSelected : false

Test testFromJson(String str) => Test.fromJson(json.decode(str));
String testToJson(Test data) => json.encode(data.toJson());
class Test {
  Test({
      int? id, 
      String? name, 
      bool? isSelected,}){
    _id = id;
    _name = name;
    _isSelected = isSelected;
}

  Test.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _isSelected = json['isSelected'];
  }
  int? _id;
  String? _name;
  bool? _isSelected;
Test copyWith({  int? id,
  String? name,
  bool? isSelected,
}) => Test(  id: id ?? _id,
  name: name ?? _name,
  isSelected: isSelected ?? _isSelected,
);
  int? get id => _id;
  String? get name => _name;
  bool? get isSelected => _isSelected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['isSelected'] = _isSelected;
    return map;
  }

}