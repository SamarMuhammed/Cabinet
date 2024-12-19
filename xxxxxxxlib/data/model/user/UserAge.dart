/// id : 1
/// name : "18-25"

class  UserAge {
  UserAge({
    int? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  UserAge.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;
  UserAge copyWith({  int? id,
    String? name,
  }) => UserAge(  id: id ?? _id,
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

