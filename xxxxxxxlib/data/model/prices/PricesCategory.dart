import 'dart:convert';
/// subCategories : [{"id":5,"name":"السلع الأساسية","isSelected":false},{"id":1,"name":"الخضراوات","isSelected":false},{"id":11,"name":"الحبوب والبقوليات","isSelected":false},{"id":7,"name":"اللحوم والدواجن","isSelected":false},{"id":8,"name":"الألبان ومنتجاتها","isSelected":false},{"id":3,"name":"الأسماك","isSelected":false},{"id":2,"name":"الفاكهة","isSelected":false},{"id":19,"name":"الأسمدة","isSelected":false},{"id":18,"name":"مواد البناء","isSelected":false}]
/// id : 75
/// name : "السلع المحلية"
/// isSelected : false

PricesCategory pricesCategoryFromJson(String str) => PricesCategory.fromJson(json.decode(str));
String pricesCategoryToJson(PricesCategory data) => json.encode(data.toJson());
class PricesCategory {
  PricesCategory({
      List<SubCategories>? subCategories, 
      int? id, 
      String? name, 
      bool? isSelected,}){
    _subCategories = subCategories;
    _id = id;
    _name = name;
    _isSelected = isSelected;
}

  PricesCategory.fromJson(dynamic json) {
    if (json['subCategories'] != null) {
      _subCategories = [];
      json['subCategories'].forEach((v) {
        _subCategories?.add(SubCategories.fromJson(v));
      });
    }
    _id = json['id'];
    _name = json['name'];
    _isSelected = json['isSelected'];
  }
  List<SubCategories>? _subCategories;
  int? _id;
  String? _name;
  bool? _isSelected;
PricesCategory copyWith({  List<SubCategories>? subCategories,
  int? id,
  String? name,
  bool? isSelected,
}) => PricesCategory(  subCategories: subCategories ?? _subCategories,
  id: id ?? _id,
  name: name ?? _name,
  isSelected: isSelected ?? _isSelected,
);
  List<SubCategories>? get subCategories => _subCategories;
  int? get id => _id;
  String? get name => _name;
  bool? get isSelected => _isSelected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_subCategories != null) {
      map['subCategories'] = _subCategories?.map((v) => v.toJson()).toList();
    }
    map['id'] = _id;
    map['name'] = _name;
    map['isSelected'] = _isSelected;
    return map;
  }

}

/// id : 5
/// name : "السلع الأساسية"
/// isSelected : false

SubCategories subCategoriesFromJson(String str) => SubCategories.fromJson(json.decode(str));
String subCategoriesToJson(SubCategories data) => json.encode(data.toJson());
class SubCategories {
  SubCategories({
      int? id, 
      String? name, 
      bool? isSelected,}){
    _id = id;
    _name = name;
    _isSelected = isSelected;
}

  SubCategories.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _isSelected = json['isSelected'];
  }
  int? _id;
  String? _name;
  bool? _isSelected;
SubCategories copyWith({  int? id,
  String? name,
  bool? isSelected,
}) => SubCategories(  id: id ?? _id,
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