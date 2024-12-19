/// id : 1
/// name : "ذكر"

class  UserGender {
  UserGender({
    int? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  UserGender.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;
  UserGender copyWith({  int? id,
    String? name,
  }) => UserGender(  id: id ?? _id,
    name: name ?? _name,
  );
  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}