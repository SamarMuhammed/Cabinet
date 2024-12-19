import 'dart:convert';
/// id : 77
/// name : "أسعار العملات الدولية"
/// isSelected : false

CashMarketsCat cashMarketsCatFromJson(String str) => CashMarketsCat.fromJson(json.decode(str));
String cashMarketsCatToJson(CashMarketsCat data) => json.encode(data.toJson());
class CashMarketsCat {
  CashMarketsCat({
      int? id, 
      String? name, 
      bool? isSelected,}){
    _id = id;
    _name = name;
    _isSelected = isSelected;
}

  CashMarketsCat.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _isSelected = json['isSelected'];
  }
  int? _id;
  String? _name;
  bool? _isSelected;

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