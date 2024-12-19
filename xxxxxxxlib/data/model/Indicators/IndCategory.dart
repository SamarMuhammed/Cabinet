import 'dart:convert';

/// id : 1
/// name : "مؤشرات محلية"
/// isSelected : false

IndCategory IndCategoryFromJson(String str) => IndCategory.fromJson(json.decode(str));
String IndCategoryToJson(IndCategory data) => json.encode(data.toJson());
class IndCategory {
  IndCategory({
    int? id,
    String? name,
    bool? isSelected,}){
    _id = id;
    _name = name;
    _isSelected = isSelected;
  }

  IndCategory.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _isSelected = json['isSelected'];
  }
  int? _id;
  String? _name;
  bool? _isSelected;
  IndCategory copyWith({  int? id,
    String? name,
    bool? isSelected,
  }) => IndCategory(  id: id ?? _id,
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

  setIsSelected(value)
  {
    _isSelected = value;
  }
}