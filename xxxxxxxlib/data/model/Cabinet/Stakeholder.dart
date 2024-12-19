import 'dart:convert';

/// id : 3
/// ownerId : 0
/// modifierId : null
/// createDate : "0001-01-01T00:00:00"
/// modifyDate : null
/// nameA : null
/// nameE : "Council of Ministers General Secretariat"
/// descriptionA : null
/// descriptionE : null
/// addressA : null
/// addressE : null
/// mobile : null
/// phone : "27935000"
/// fax : "27958048"
/// email : null
/// homePage : null
/// cityId : null
/// cityNameA : null
/// cityNameE : "cairo"
/// sortIndex : 0
/// focus : false
/// active : true
/// photo : "/Upload/Stackholder/Photo/3/لوجو رئاسة مجلس الوزراء.png"

Stakeholder stakeholderFromJson(String str) => Stakeholder.fromJson(json.decode(str));
String stakeholderToJson(Stakeholder data) => json.encode(data.toJson());
class Stakeholder {
  Stakeholder({
      int? id, 
      int? ownerId, 
      dynamic modifierId, 
      String? createDate, 
      dynamic modifyDate, 
      dynamic nameA, 
      String? nameE, 
      dynamic descriptionA, 
      dynamic descriptionE, 
      dynamic addressA, 
      dynamic addressE, 
      dynamic mobile, 
      String? phone, 
      String? fax, 
      dynamic email, 
      dynamic homePage, 
      dynamic cityId, 
      dynamic cityNameA, 
      String? cityNameE, 
      int? sortIndex, 
      bool? focus, 
      bool? active, 
      String? photo,}){
    _id = id;
    _ownerId = ownerId;
    _modifierId = modifierId;
    _createDate = createDate;
    _modifyDate = modifyDate;
    _nameA = nameA;
    _nameE = nameE;
    _descriptionA = descriptionA;
    _descriptionE = descriptionE;
    _addressA = addressA;
    _addressE = addressE;
    _mobile = mobile;
    _phone = phone;
    _fax = fax;
    _email = email;
    _homePage = homePage;
    _cityId = cityId;
    _cityNameA = cityNameA;
    _cityNameE = cityNameE;
    _sortIndex = sortIndex;
    _focus = focus;
    _active = active;
    _photo = photo;
}

  Stakeholder.fromJson(dynamic json) {
    _id = json['id'];
    _ownerId = json['ownerId'];
    _modifierId = json['modifierId'];
    _createDate = json['createDate'];
    _modifyDate = json['modifyDate'];
    _nameA = json['nameA'];
    _nameE = json['nameE'];
    _descriptionA = json['descriptionA'];
    _descriptionE = json['descriptionE'];
    _addressA = json['addressA'];
    _addressE = json['addressE'];
    _mobile = json['mobile'];
    _phone = json['phone'];
    _fax = json['fax'];
    _email = json['email'];
    _homePage = json['homePage'];
    _cityId = json['cityId'];
    _cityNameA = json['cityNameA'];
    _cityNameE = json['cityNameE'];
    _sortIndex = json['sortIndex'];
    _focus = json['focus'];
    _active = json['active'];
    _photo = json['photo'];
  }
  int? _id;
  int? _ownerId;
  dynamic _modifierId;
  String? _createDate;
  dynamic _modifyDate;
  dynamic _nameA;
  String? _nameE;
  dynamic _descriptionA;
  dynamic _descriptionE;
  dynamic _addressA;
  dynamic _addressE;
  dynamic _mobile;
  String? _phone;
  String? _fax;
  dynamic _email;
  dynamic _homePage;
  dynamic _cityId;
  dynamic _cityNameA;
  String? _cityNameE;
  int? _sortIndex;
  bool? _focus;
  bool? _active;
  String? _photo;
Stakeholder copyWith({  int? id,
  int? ownerId,
  dynamic modifierId,
  String? createDate,
  dynamic modifyDate,
  dynamic nameA,
  String? nameE,
  dynamic descriptionA,
  dynamic descriptionE,
  dynamic addressA,
  dynamic addressE,
  dynamic mobile,
  String? phone,
  String? fax,
  dynamic email,
  dynamic homePage,
  dynamic cityId,
  dynamic cityNameA,
  String? cityNameE,
  int? sortIndex,
  bool? focus,
  bool? active,
  String? photo,
}) => Stakeholder(  id: id ?? _id,
  ownerId: ownerId ?? _ownerId,
  modifierId: modifierId ?? _modifierId,
  createDate: createDate ?? _createDate,
  modifyDate: modifyDate ?? _modifyDate,
  nameA: nameA ?? _nameA,
  nameE: nameE ?? _nameE,
  descriptionA: descriptionA ?? _descriptionA,
  descriptionE: descriptionE ?? _descriptionE,
  addressA: addressA ?? _addressA,
  addressE: addressE ?? _addressE,
  mobile: mobile ?? _mobile,
  phone: phone ?? _phone,
  fax: fax ?? _fax,
  email: email ?? _email,
  homePage: homePage ?? _homePage,
  cityId: cityId ?? _cityId,
  cityNameA: cityNameA ?? _cityNameA,
  cityNameE: cityNameE ?? _cityNameE,
  sortIndex: sortIndex ?? _sortIndex,
  focus: focus ?? _focus,
  active: active ?? _active,
  photo: photo ?? _photo,
);
  int? get id => _id;
  int? get ownerId => _ownerId;
  dynamic get modifierId => _modifierId;
  String? get createDate => _createDate;
  dynamic get modifyDate => _modifyDate;
  dynamic get nameA => _nameA;
  String? get nameE => _nameE;
  dynamic get descriptionA => _descriptionA;
  dynamic get descriptionE => _descriptionE;
  dynamic get addressA => _addressA;
  dynamic get addressE => _addressE;
  dynamic get mobile => _mobile;
  String? get phone => _phone;
  String? get fax => _fax;
  dynamic get email => _email;
  dynamic get homePage => _homePage;
  dynamic get cityId => _cityId;
  dynamic get cityNameA => _cityNameA;
  String? get cityNameE => _cityNameE;
  int? get sortIndex => _sortIndex;
  bool? get focus => _focus;
  bool? get active => _active;
  String? get photo => _photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ownerId'] = _ownerId;
    map['modifierId'] = _modifierId;
    map['createDate'] = _createDate;
    map['modifyDate'] = _modifyDate;
    map['nameA'] = _nameA;
    map['nameE'] = _nameE;
    map['descriptionA'] = _descriptionA;
    map['descriptionE'] = _descriptionE;
    map['addressA'] = _addressA;
    map['addressE'] = _addressE;
    map['mobile'] = _mobile;
    map['phone'] = _phone;
    map['fax'] = _fax;
    map['email'] = _email;
    map['homePage'] = _homePage;
    map['cityId'] = _cityId;
    map['cityNameA'] = _cityNameA;
    map['cityNameE'] = _cityNameE;
    map['sortIndex'] = _sortIndex;
    map['focus'] = _focus;
    map['active'] = _active;
    map['photo'] = _photo;
    return map;
  }

}