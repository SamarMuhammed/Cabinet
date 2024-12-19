import 'dart:convert';

/// id : 12
/// ownerId : 0
/// modifierId : null
/// createDate : "0001-01-01T00:00:00"
/// modifyDate : null
/// nameA : "السيد الفريق أول/ محمد أحمد زكي"
/// nameE : "General\\ Mohamed Ahmed Zaki"
/// addressA : null
/// addressE : null
/// shortBriefA : null
/// briefA : null
/// shortBriefE : null
/// briefE : null
/// facebook : "https://www.facebook.com/EgyArmySpox/"
/// twitter : "https://twitter.com/EgyArmySpox"
/// youtube : "https://www.youtube.com/channel/UC5AvwPA0ewLnAcNvCF8ZEhg"
/// instagram : null
/// phone : null
/// fax : null
/// email : null
/// homepage : null
/// photo : "/Upload/Hierarchy/Photo/12/51218757-1fb5-460a-a88a-fd8c4d9fa741.jfif"
/// homePhoto : null
/// homeSmallPhoto : null
/// ministryId : null
/// ministryNameA : "وزير الدفاع والإنتاج الحربي"
/// ministryNameE : "Minister of Defense and Military Production"
/// sortIndex : 0
/// focus : false
/// active : false
/// isHead : false

Minister ministerFromJson(String str) => Minister.fromJson(json.decode(str));
String ministerToJson(Minister data) => json.encode(data.toJson());
class Minister {
  Minister({
      int? id, 
      int? ownerId, 
      dynamic modifierId, 
      String? createDate, 
      dynamic modifyDate, 
      String? nameA, 
      String? nameE, 
      dynamic addressA, 
      dynamic addressE, 
      dynamic shortBriefA, 
      dynamic briefA, 
      dynamic shortBriefE, 
      dynamic briefE, 
      String? facebook, 
      String? twitter, 
      String? youtube, 
      dynamic instagram, 
      dynamic phone, 
      dynamic fax, 
      dynamic email, 
      dynamic homepage, 
      String? photo, 
      dynamic homePhoto, 
      dynamic homeSmallPhoto, 
      dynamic ministryId, 
      String? ministryNameA, 
      String? ministryNameE, 
      int? sortIndex, 
      bool? focus, 
      bool? active, 
      bool? isHead,}){
    _id = id;
    _ownerId = ownerId;
    _modifierId = modifierId;
    _createDate = createDate;
    _modifyDate = modifyDate;
    _nameA = nameA;
    _nameE = nameE;
    _addressA = addressA;
    _addressE = addressE;
    _shortBriefA = shortBriefA;
    _briefA = briefA;
    _shortBriefE = shortBriefE;
    _briefE = briefE;
    _facebook = facebook;
    _twitter = twitter;
    _youtube = youtube;
    _instagram = instagram;
    _phone = phone;
    _fax = fax;
    _email = email;
    _homepage = homepage;
    _photo = photo;
    _homePhoto = homePhoto;
    _homeSmallPhoto = homeSmallPhoto;
    _ministryId = ministryId;
    _ministryNameA = ministryNameA;
    _ministryNameE = ministryNameE;
    _sortIndex = sortIndex;
    _focus = focus;
    _active = active;
    _isHead = isHead;
}

  Minister.fromJson(dynamic json) {
    _id = json['id'];
    _ownerId = json['ownerId'];
    _modifierId = json['modifierId'];
    _createDate = json['createDate'];
    _modifyDate = json['modifyDate'];
    _nameA = json['nameA'];
    _nameE = json['nameE'];
    _addressA = json['addressA'];
    _addressE = json['addressE'];
    _shortBriefA = json['shortBriefA'];
    _briefA = json['briefA'];
    _shortBriefE = json['shortBriefE'];
    _briefE = json['briefE'];
    _facebook = json['facebook'];
    _twitter = json['twitter'];
    _youtube = json['youtube'];
    _instagram = json['instagram'];
    _phone = json['phone'];
    _fax = json['fax'];
    _email = json['email'];
    _homepage = json['homepage'];
    _photo = json['photo'];
    _homePhoto = json['homePhoto'];
    _homeSmallPhoto = json['homeSmallPhoto'];
    _ministryId = json['ministryId'];
    _ministryNameA = json['ministryNameA'];
    _ministryNameE = json['ministryNameE'];
    _sortIndex = json['sortIndex'];
    _focus = json['focus'];
    _active = json['active'];
    _isHead = json['isHead'];
  }
  int? _id;
  int? _ownerId;
  dynamic _modifierId;
  String? _createDate;
  dynamic _modifyDate;
  String? _nameA;
  String? _nameE;
  dynamic _addressA;
  dynamic _addressE;
  dynamic _shortBriefA;
  dynamic _briefA;
  dynamic _shortBriefE;
  dynamic _briefE;
  String? _facebook;
  String? _twitter;
  String? _youtube;
  dynamic _instagram;
  dynamic _phone;
  dynamic _fax;
  dynamic _email;
  dynamic _homepage;
  String? _photo;
  dynamic _homePhoto;
  dynamic _homeSmallPhoto;
  dynamic _ministryId;
  String? _ministryNameA;
  String? _ministryNameE;
  int? _sortIndex;
  bool? _focus;
  bool? _active;
  bool? _isHead;
Minister copyWith({  int? id,
  int? ownerId,
  dynamic modifierId,
  String? createDate,
  dynamic modifyDate,
  String? nameA,
  String? nameE,
  dynamic addressA,
  dynamic addressE,
  dynamic shortBriefA,
  dynamic briefA,
  dynamic shortBriefE,
  dynamic briefE,
  String? facebook,
  String? twitter,
  String? youtube,
  dynamic instagram,
  dynamic phone,
  dynamic fax,
  dynamic email,
  dynamic homepage,
  String? photo,
  dynamic homePhoto,
  dynamic homeSmallPhoto,
  dynamic ministryId,
  String? ministryNameA,
  String? ministryNameE,
  int? sortIndex,
  bool? focus,
  bool? active,
  bool? isHead,
}) => Minister(  id: id ?? _id,
  ownerId: ownerId ?? _ownerId,
  modifierId: modifierId ?? _modifierId,
  createDate: createDate ?? _createDate,
  modifyDate: modifyDate ?? _modifyDate,
  nameA: nameA ?? _nameA,
  nameE: nameE ?? _nameE,
  addressA: addressA ?? _addressA,
  addressE: addressE ?? _addressE,
  shortBriefA: shortBriefA ?? _shortBriefA,
  briefA: briefA ?? _briefA,
  shortBriefE: shortBriefE ?? _shortBriefE,
  briefE: briefE ?? _briefE,
  facebook: facebook ?? _facebook,
  twitter: twitter ?? _twitter,
  youtube: youtube ?? _youtube,
  instagram: instagram ?? _instagram,
  phone: phone ?? _phone,
  fax: fax ?? _fax,
  email: email ?? _email,
  homepage: homepage ?? _homepage,
  photo: photo ?? _photo,
  homePhoto: homePhoto ?? _homePhoto,
  homeSmallPhoto: homeSmallPhoto ?? _homeSmallPhoto,
  ministryId: ministryId ?? _ministryId,
  ministryNameA: ministryNameA ?? _ministryNameA,
  ministryNameE: ministryNameE ?? _ministryNameE,
  sortIndex: sortIndex ?? _sortIndex,
  focus: focus ?? _focus,
  active: active ?? _active,
  isHead: isHead ?? _isHead,
);
  int? get id => _id;
  int? get ownerId => _ownerId;
  dynamic get modifierId => _modifierId;
  String? get createDate => _createDate;
  dynamic get modifyDate => _modifyDate;
  String? get nameA => _nameA;
  String? get nameE => _nameE;
  dynamic get addressA => _addressA;
  dynamic get addressE => _addressE;
  dynamic get shortBriefA => _shortBriefA;
  dynamic get briefA => _briefA;
  dynamic get shortBriefE => _shortBriefE;
  dynamic get briefE => _briefE;
  String? get facebook => _facebook;
  String? get twitter => _twitter;
  String? get youtube => _youtube;
  dynamic get instagram => _instagram;
  dynamic get phone => _phone;
  dynamic get fax => _fax;
  dynamic get email => _email;
  dynamic get homepage => _homepage;
  String? get photo => _photo;
  dynamic get homePhoto => _homePhoto;
  dynamic get homeSmallPhoto => _homeSmallPhoto;
  dynamic get ministryId => _ministryId;
  String? get ministryNameA => _ministryNameA;
  String? get ministryNameE => _ministryNameE;
  int? get sortIndex => _sortIndex;
  bool? get focus => _focus;
  bool? get active => _active;
  bool? get isHead => _isHead;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ownerId'] = _ownerId;
    map['modifierId'] = _modifierId;
    map['createDate'] = _createDate;
    map['modifyDate'] = _modifyDate;
    map['nameA'] = _nameA;
    map['nameE'] = _nameE;
    map['addressA'] = _addressA;
    map['addressE'] = _addressE;
    map['shortBriefA'] = _shortBriefA;
    map['briefA'] = _briefA;
    map['shortBriefE'] = _shortBriefE;
    map['briefE'] = _briefE;
    map['facebook'] = _facebook;
    map['twitter'] = _twitter;
    map['youtube'] = _youtube;
    map['instagram'] = _instagram;
    map['phone'] = _phone;
    map['fax'] = _fax;
    map['email'] = _email;
    map['homepage'] = _homepage;
    map['photo'] = _photo;
    map['homePhoto'] = _homePhoto;
    map['homeSmallPhoto'] = _homeSmallPhoto;
    map['ministryId'] = _ministryId;
    map['ministryNameA'] = _ministryNameA;
    map['ministryNameE'] = _ministryNameE;
    map['sortIndex'] = _sortIndex;
    map['focus'] = _focus;
    map['active'] = _active;
    map['isHead'] = _isHead;
    return map;
  }

}