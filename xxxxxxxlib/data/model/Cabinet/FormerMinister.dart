import 'dart:convert';

/// id : 0
/// ownerId : 0
/// nameA : null
/// nameE : null
/// descriptionA : null
/// descriptionE : null
/// photo : null
/// photoE : "/upload/Ministor/PhotoE/1027/sherif-ismael.png"
/// resumeA : null
/// resumeE : null
/// startDate : null
/// endDate : null
/// governmentId : 0
/// presidentId : 0
/// isCurrent : false
/// sortIndex : 0
/// focus : false
/// active : false
/// governmentNameA : null
/// governmentNameE : null
/// presidents : null

FormerMinister formerMinisterFromJson(String str) => FormerMinister.fromJson(json.decode(str));
String formerMinisterToJson(FormerMinister data) => json.encode(data.toJson());
class FormerMinister {
  FormerMinister({
      int? id, 
      int? ownerId, 
      dynamic nameA, 
      dynamic nameE, 
      dynamic descriptionA, 
      dynamic descriptionE, 
      dynamic photo, 
      String? photoE, 
      dynamic resumeA, 
      dynamic resumeE, 
      dynamic startDate, 
      dynamic endDate, 
      int? governmentId, 
      int? presidentId, 
      bool? isCurrent, 
      int? sortIndex, 
      bool? focus, 
      bool? active, 
      dynamic governmentNameA, 
      dynamic governmentNameE, 
      dynamic presidents,}){
    _id = id;
    _ownerId = ownerId;
    _nameA = nameA;
    _nameE = nameE;
    _descriptionA = descriptionA;
    _descriptionE = descriptionE;
    _photo = photo;
    _photoE = photoE;
    _resumeA = resumeA;
    _resumeE = resumeE;
    _startDate = startDate;
    _endDate = endDate;
    _governmentId = governmentId;
    _presidentId = presidentId;
    _isCurrent = isCurrent;
    _sortIndex = sortIndex;
    _focus = focus;
    _active = active;
    _governmentNameA = governmentNameA;
    _governmentNameE = governmentNameE;
    _presidents = presidents;
}

  FormerMinister.fromJson(dynamic json) {
    _id = json['id'];
    _ownerId = json['ownerId'];
    _nameA = json['nameA'];
    _nameE = json['nameE'];
    _descriptionA = json['descriptionA'];
    _descriptionE = json['descriptionE'];
    _photo = json['photo'];
    _photoE = json['photoE'];
    _resumeA = json['resumeA'];
    _resumeE = json['resumeE'];
    _startDate = json['startDate'];
    _endDate = json['endDate'];
    _governmentId = json['governmentId'];
    _presidentId = json['presidentId'];
    _isCurrent = json['isCurrent'];
    _sortIndex = json['sortIndex'];
    _focus = json['focus'];
    _active = json['active'];
    _governmentNameA = json['governmentNameA'];
    _governmentNameE = json['governmentNameE'];
    _presidents = json['presidents'];
  }
  int? _id;
  int? _ownerId;
  dynamic _nameA;
  dynamic _nameE;
  dynamic _descriptionA;
  dynamic _descriptionE;
  dynamic _photo;
  String? _photoE;
  dynamic _resumeA;
  dynamic _resumeE;
  dynamic _startDate;
  dynamic _endDate;
  int? _governmentId;
  int? _presidentId;
  bool? _isCurrent;
  int? _sortIndex;
  bool? _focus;
  bool? _active;
  dynamic _governmentNameA;
  dynamic _governmentNameE;
  dynamic _presidents;
FormerMinister copyWith({  int? id,
  int? ownerId,
  dynamic nameA,
  dynamic nameE,
  dynamic descriptionA,
  dynamic descriptionE,
  dynamic photo,
  String? photoE,
  dynamic resumeA,
  dynamic resumeE,
  dynamic startDate,
  dynamic endDate,
  int? governmentId,
  int? presidentId,
  bool? isCurrent,
  int? sortIndex,
  bool? focus,
  bool? active,
  dynamic governmentNameA,
  dynamic governmentNameE,
  dynamic presidents,
}) => FormerMinister(  id: id ?? _id,
  ownerId: ownerId ?? _ownerId,
  nameA: nameA ?? _nameA,
  nameE: nameE ?? _nameE,
  descriptionA: descriptionA ?? _descriptionA,
  descriptionE: descriptionE ?? _descriptionE,
  photo: photo ?? _photo,
  photoE: photoE ?? _photoE,
  resumeA: resumeA ?? _resumeA,
  resumeE: resumeE ?? _resumeE,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  governmentId: governmentId ?? _governmentId,
  presidentId: presidentId ?? _presidentId,
  isCurrent: isCurrent ?? _isCurrent,
  sortIndex: sortIndex ?? _sortIndex,
  focus: focus ?? _focus,
  active: active ?? _active,
  governmentNameA: governmentNameA ?? _governmentNameA,
  governmentNameE: governmentNameE ?? _governmentNameE,
  presidents: presidents ?? _presidents,
);
  int? get id => _id;
  int? get ownerId => _ownerId;
  dynamic get nameA => _nameA;
  dynamic get nameE => _nameE;
  dynamic get descriptionA => _descriptionA;
  dynamic get descriptionE => _descriptionE;
  dynamic get photo => _photo;
  String? get photoE => _photoE;
  dynamic get resumeA => _resumeA;
  dynamic get resumeE => _resumeE;
  dynamic get startDate => _startDate;
  dynamic get endDate => _endDate;
  int? get governmentId => _governmentId;
  int? get presidentId => _presidentId;
  bool? get isCurrent => _isCurrent;
  int? get sortIndex => _sortIndex;
  bool? get focus => _focus;
  bool? get active => _active;
  dynamic get governmentNameA => _governmentNameA;
  dynamic get governmentNameE => _governmentNameE;
  dynamic get presidents => _presidents;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ownerId'] = _ownerId;
    map['nameA'] = _nameA;
    map['nameE'] = _nameE;
    map['descriptionA'] = _descriptionA;
    map['descriptionE'] = _descriptionE;
    map['photo'] = _photo;
    map['photoE'] = _photoE;
    map['resumeA'] = _resumeA;
    map['resumeE'] = _resumeE;
    map['startDate'] = _startDate;
    map['endDate'] = _endDate;
    map['governmentId'] = _governmentId;
    map['presidentId'] = _presidentId;
    map['isCurrent'] = _isCurrent;
    map['sortIndex'] = _sortIndex;
    map['focus'] = _focus;
    map['active'] = _active;
    map['governmentNameA'] = _governmentNameA;
    map['governmentNameE'] = _governmentNameE;
    map['presidents'] = _presidents;
    return map;
  }

}