import 'dart:convert';
/// id : 5
/// name : "السلع الأساسية"
/// isSelected : false

PricesSubCategory pricesSubCategoryFromJson(String str) => PricesSubCategory.fromJson(json.decode(str));
String pricesSubCategoryToJson(PricesSubCategory data) => json.encode(data.toJson());
class PricesSubCategory {
  PricesSubCategory({
      int? id, 
      String? name, 
      bool? isSelected,}){
    _id = id;
    _name = name;
    _isSelected = isSelected;
}

  PricesSubCategory.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _isSelected = json['isSelected'];
  }
  int? _id;
  String? _name;
  bool? _isSelected;
PricesSubCategory copyWith({  int? id,
  String? name,
  bool? isSelected,
}) => PricesSubCategory(  id: id ?? _id,
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