/// id : 1
/// name : "الاشعارات"
/// eName : "Notifications"
/// nameE : "Notifications"
/// nameF : "notifications"
/// nameEs : null
/// nameR : "уведомления"
/// nameC : "通知"
/// nameIt : "notifiche"
/// descriptionE : null
/// descriptionF : null
/// descriptionEs : null
/// descriptionR : null
/// descriptionC : null
/// descriptionIt : null
/// type : "Radio"
/// icon : null

class Settings {
  Settings({
      num? id, 
      String? name, 
      String? eName, 
      String? nameE, 
      String? nameF, 
      dynamic nameEs, 
      String? nameR, 
      String? nameC, 
      String? nameIt, 
      dynamic descriptionE, 
      dynamic descriptionF, 
      dynamic descriptionEs, 
      dynamic descriptionR, 
      dynamic descriptionC, 
      dynamic descriptionIt, 
      String? type, 
      dynamic icon,}){
    _id = id;
    _name = name;
    _eName = eName;
    _nameE = nameE;
    _nameF = nameF;
    _nameEs = nameEs;
    _nameR = nameR;
    _nameC = nameC;
    _nameIt = nameIt;
    _descriptionE = descriptionE;
    _descriptionF = descriptionF;
    _descriptionEs = descriptionEs;
    _descriptionR = descriptionR;
    _descriptionC = descriptionC;
    _descriptionIt = descriptionIt;
    _type = type;
    _icon = icon;
}

  Settings.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _eName = json['eName'];
    _nameE = json['nameE'];
    _nameF = json['nameF'];
    _nameEs = json['nameEs'];
    _nameR = json['nameR'];
    _nameC = json['nameC'];
    _nameIt = json['nameIt'];
    _descriptionE = json['descriptionE'];
    _descriptionF = json['descriptionF'];
    _descriptionEs = json['descriptionEs'];
    _descriptionR = json['descriptionR'];
    _descriptionC = json['descriptionC'];
    _descriptionIt = json['descriptionIt'];
    _type = json['type'];
    _icon = json['icon'];
  }
  num? _id;
  String? _name;
  String? _eName;
  String? _nameE;
  String? _nameF;
  dynamic _nameEs;
  String? _nameR;
  String? _nameC;
  String? _nameIt;
  dynamic _descriptionE;
  dynamic _descriptionF;
  dynamic _descriptionEs;
  dynamic _descriptionR;
  dynamic _descriptionC;
  dynamic _descriptionIt;
  String? _type;
  dynamic _icon;
Settings copyWith({  num? id,
  String? name,
  String? eName,
  String? nameE,
  String? nameF,
  dynamic nameEs,
  String? nameR,
  String? nameC,
  String? nameIt,
  dynamic descriptionE,
  dynamic descriptionF,
  dynamic descriptionEs,
  dynamic descriptionR,
  dynamic descriptionC,
  dynamic descriptionIt,
  String? type,
  dynamic icon,
}) => Settings(  id: id ?? _id,
  name: name ?? _name,
  eName: eName ?? _eName,
  nameE: nameE ?? _nameE,
  nameF: nameF ?? _nameF,
  nameEs: nameEs ?? _nameEs,
  nameR: nameR ?? _nameR,
  nameC: nameC ?? _nameC,
  nameIt: nameIt ?? _nameIt,
  descriptionE: descriptionE ?? _descriptionE,
  descriptionF: descriptionF ?? _descriptionF,
  descriptionEs: descriptionEs ?? _descriptionEs,
  descriptionR: descriptionR ?? _descriptionR,
  descriptionC: descriptionC ?? _descriptionC,
  descriptionIt: descriptionIt ?? _descriptionIt,
  type: type ?? _type,
  icon: icon ?? _icon,
);
  num? get id => _id;
  String? get name => _name;
  String? get eName => _eName;
  String? get nameE => _nameE;
  String? get nameF => _nameF;
  dynamic get nameEs => _nameEs;
  String? get nameR => _nameR;
  String? get nameC => _nameC;
  String? get nameIt => _nameIt;
  dynamic get descriptionE => _descriptionE;
  dynamic get descriptionF => _descriptionF;
  dynamic get descriptionEs => _descriptionEs;
  dynamic get descriptionR => _descriptionR;
  dynamic get descriptionC => _descriptionC;
  dynamic get descriptionIt => _descriptionIt;
  String? get type => _type;
  dynamic get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['eName'] = _eName;
    map['nameE'] = _nameE;
    map['nameF'] = _nameF;
    map['nameEs'] = _nameEs;
    map['nameR'] = _nameR;
    map['nameC'] = _nameC;
    map['nameIt'] = _nameIt;
    map['descriptionE'] = _descriptionE;
    map['descriptionF'] = _descriptionF;
    map['descriptionEs'] = _descriptionEs;
    map['descriptionR'] = _descriptionR;
    map['descriptionC'] = _descriptionC;
    map['descriptionIt'] = _descriptionIt;
    map['type'] = _type;
    map['icon'] = _icon;
    return map;
  }
  Map<String, dynamic> toMap() {
    return {
      'nameE': nameE,
      'nameF': nameF,
      'nameEs': nameEs,
      'nameR': nameR,
      'nameC': nameC,
      'nameIt': nameIt,
      'descriptionE':descriptionE,
      'descriptionF':descriptionF,
      'descriptionEs':descriptionEs,
      'descriptionR':descriptionR,
      'descriptionC':descriptionC,
      'descriptionIt':descriptionIt,


    };

  }
}