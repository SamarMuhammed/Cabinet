class Topic {
  Topic({
    int? id,
    String? name,
    String? checkedImage,
    String? unCheckedImage,}){
    _id = id;
    _name = name;
    _checkedImage = checkedImage;
    _unCheckedImage = unCheckedImage;
  }

  Topic.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _checkedImage = json['checkedImage'];
    _unCheckedImage = json['unCheckedImage'];
  }
  int? _id;
  String? _name;
  String? _checkedImage;
  String? _unCheckedImage;
  Topic copyWith({ int? id,
    String? name,
    String? checkedImage,
    String? unCheckedImage,
  }) => Topic( id: id ?? _id,
    name: name ?? _name,
    checkedImage: checkedImage ?? _checkedImage,
    unCheckedImage: unCheckedImage ?? _unCheckedImage,
  );
  int? get id => _id;
  String? get name => _name;
  String? get checkedImage => _checkedImage;
  String? get unCheckedImage => _unCheckedImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['checkedImage'] = _checkedImage;
    map['unCheckedImage'] = _unCheckedImage;
    return map;
  }

}