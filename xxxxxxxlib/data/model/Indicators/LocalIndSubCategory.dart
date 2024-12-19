import 'Indicator.dart';
import 'dart:convert';

/// indicator : {"id":89,"name":"نسبة العجز","value":6.7,"unit":"%","date":"2021/2022"}
/// id : 2
/// name : "الميزان الكلي كنسبة للناتج المحلي الإجمالي "
/// isSelected : false

LocalIndSubCategory localIndSubCategoryFromJson(String str) => LocalIndSubCategory.fromJson(json.decode(str));
String localIndSubCategoryToJson(LocalIndSubCategory data) => json.encode(data.toJson());
class LocalIndSubCategory {
  LocalIndSubCategory({
      Indicator? indicator, 
      int? id, 
      String? name, 
      bool? isSelected,}){
    _indicator = indicator;
    _id = id;
    _name = name;
    _isSelected = isSelected;
}

  LocalIndSubCategory.fromJson(dynamic json) {
    _indicator = json['indicator'] != null ? Indicator.fromJson(json['indicator']) : null;
    _id = json['id'];
    _name = json['name'];
    _isSelected = json['isSelected'];
  }
  Indicator? _indicator;
  int? _id;
  String? _name;
  bool? _isSelected;
LocalIndSubCategory copyWith({  Indicator? indicator,
  int? id,
  String? name,
  bool? isSelected,
}) => LocalIndSubCategory(  indicator: indicator ?? _indicator,
  id: id ?? _id,
  name: name ?? _name,
  isSelected: isSelected ?? _isSelected,
);
  Indicator? get indicator => _indicator;
  int? get id => _id;
  String? get name => _name;
  bool? get isSelected => _isSelected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_indicator != null) {
      map['indicator'] = _indicator?.toJson();
    }
    map['id'] = _id;
    map['name'] = _name;
    map['isSelected'] = _isSelected;
    return map;
  }

}