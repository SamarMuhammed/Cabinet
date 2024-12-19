/// id : 3524
/// ownerId : 0
/// titleA : "كلمة رئيس الوزراء خلال القمة العالمية للحكومات ٢٠٢٤ بدبي"
/// titleE : "Prime Minister s Speech During World Government Summit 2024 in Dubai"
/// titleF : null
/// titleEs : null
/// titleRu : null
/// titleC : null
/// titleIt : null
/// contentA : null
/// contentE : null
/// contentF : null
/// contentEs : null
/// contentRu : null
/// contentC : null
/// contentIt : null
/// photo : "/Upload/Appointment/Photo/3524/SLM_2513.JPG"
/// appointmentDate : "2024-02-12T00:00:00"
/// governmentId : 0
/// appointmentTypeId : null
/// appointmentTypeNameA : "كلمات رئيس مجلس الوزراء"
/// appointmentTypeNameE : "كلمات رئيس مجلس الوزراء"
/// appointmentTypeNameF : null
/// appointmentTypeNameEs : null
/// appointmentTypeNameRu : null
/// appointmentTypeNameC : null
/// appointmentTypeNameIt : null
/// formattedAppointmentDate : "Monday, 12 February 2024"
/// sortIndex : 0
/// focus : false
/// active : true
/// governmentA : "وزارة الدكتور/ مصطفى مدبولى (الثانية)"
/// governmentE : "Dr. Mostafa Madbouly (Second Cabinet)"
/// governmentF : null
/// governmentEs : null
/// governmentRu : null
/// governmentC : null
/// governmentIt : null

class Appointment {
  Appointment({
      num? id, 
      num? ownerId, 
      String? titleA, 
      String? titleE, 
      dynamic titleF, 
      dynamic titleEs, 
      dynamic titleRu, 
      dynamic titleC, 
      dynamic titleIt, 
      dynamic contentA, 
      dynamic contentE, 
      dynamic contentF, 
      dynamic contentEs, 
      dynamic contentRu, 
      dynamic contentC, 
      dynamic contentIt, 
      String? photo, 
      String? appointmentDate, 
      num? governmentId, 
      dynamic appointmentTypeId, 
      String? appointmentTypeNameA, 
      String? appointmentTypeNameE, 
      dynamic appointmentTypeNameF, 
      dynamic appointmentTypeNameEs, 
      dynamic appointmentTypeNameRu, 
      dynamic appointmentTypeNameC, 
      dynamic appointmentTypeNameIt, 
      String? formattedAppointmentDate, 
      num? sortIndex, 
      bool? focus, 
      bool? active, 
      String? governmentA, 
      String? governmentE, 
      dynamic governmentF, 
      dynamic governmentEs, 
      dynamic governmentRu, 
      dynamic governmentC, 
      dynamic governmentIt,}){
    _id = id;
    _ownerId = ownerId;
    _titleA = titleA;
    _titleE = titleE;
    _titleF = titleF;
    _titleEs = titleEs;
    _titleRu = titleRu;
    _titleC = titleC;
    _titleIt = titleIt;
    _contentA = contentA;
    _contentE = contentE;
    _contentF = contentF;
    _contentEs = contentEs;
    _contentRu = contentRu;
    _contentC = contentC;
    _contentIt = contentIt;
    _photo = photo;
    _appointmentDate = appointmentDate;
    _governmentId = governmentId;
    _appointmentTypeId = appointmentTypeId;
    _appointmentTypeNameA = appointmentTypeNameA;
    _appointmentTypeNameE = appointmentTypeNameE;
    _appointmentTypeNameF = appointmentTypeNameF;
    _appointmentTypeNameEs = appointmentTypeNameEs;
    _appointmentTypeNameRu = appointmentTypeNameRu;
    _appointmentTypeNameC = appointmentTypeNameC;
    _appointmentTypeNameIt = appointmentTypeNameIt;
    _formattedAppointmentDate = formattedAppointmentDate;
    _sortIndex = sortIndex;
    _focus = focus;
    _active = active;
    _governmentA = governmentA;
    _governmentE = governmentE;
    _governmentF = governmentF;
    _governmentEs = governmentEs;
    _governmentRu = governmentRu;
    _governmentC = governmentC;
    _governmentIt = governmentIt;
}

  Appointment.fromJson(dynamic json) {
    _id = json['id'];
    _ownerId = json['ownerId'];
    _titleA = json['titleA'];
    _titleE = json['titleE'];
    _titleF = json['titleF'];
    _titleEs = json['titleEs'];
    _titleRu = json['titleRu'];
    _titleC = json['titleC'];
    _titleIt = json['titleIt'];
    _contentA = json['contentA'];
    _contentE = json['contentE'];
    _contentF = json['contentF'];
    _contentEs = json['contentEs'];
    _contentRu = json['contentRu'];
    _contentC = json['contentC'];
    _contentIt = json['contentIt'];
    _photo = json['photo'];
    _appointmentDate = json['appointmentDate'];
    _governmentId = json['governmentId'];
    _appointmentTypeId = json['appointmentTypeId'];
    _appointmentTypeNameA = json['appointmentTypeNameA'];
    _appointmentTypeNameE = json['appointmentTypeNameE'];
    _appointmentTypeNameF = json['appointmentTypeNameF'];
    _appointmentTypeNameEs = json['appointmentTypeNameEs'];
    _appointmentTypeNameRu = json['appointmentTypeNameRu'];
    _appointmentTypeNameC = json['appointmentTypeNameC'];
    _appointmentTypeNameIt = json['appointmentTypeNameIt'];
    _formattedAppointmentDate = json['formattedAppointmentDate'];
    _sortIndex = json['sortIndex'];
    _focus = json['focus'];
    _active = json['active'];
    _governmentA = json['governmentA'];
    _governmentE = json['governmentE'];
    _governmentF = json['governmentF'];
    _governmentEs = json['governmentEs'];
    _governmentRu = json['governmentRu'];
    _governmentC = json['governmentC'];
    _governmentIt = json['governmentIt'];
  }
  num? _id;
  num? _ownerId;
  String? _titleA;
  String? _titleE;
  dynamic _titleF;
  dynamic _titleEs;
  dynamic _titleRu;
  dynamic _titleC;
  dynamic _titleIt;
  dynamic _contentA;
  dynamic _contentE;
  dynamic _contentF;
  dynamic _contentEs;
  dynamic _contentRu;
  dynamic _contentC;
  dynamic _contentIt;
  String? _photo;
  String? _appointmentDate;
  num? _governmentId;
  dynamic _appointmentTypeId;
  String? _appointmentTypeNameA;
  String? _appointmentTypeNameE;
  dynamic _appointmentTypeNameF;
  dynamic _appointmentTypeNameEs;
  dynamic _appointmentTypeNameRu;
  dynamic _appointmentTypeNameC;
  dynamic _appointmentTypeNameIt;
  String? _formattedAppointmentDate;
  num? _sortIndex;
  bool? _focus;
  bool? _active;
  String? _governmentA;
  String? _governmentE;
  dynamic _governmentF;
  dynamic _governmentEs;
  dynamic _governmentRu;
  dynamic _governmentC;
  dynamic _governmentIt;
Appointment copyWith({  num? id,
  num? ownerId,
  String? titleA,
  String? titleE,
  dynamic titleF,
  dynamic titleEs,
  dynamic titleRu,
  dynamic titleC,
  dynamic titleIt,
  dynamic contentA,
  dynamic contentE,
  dynamic contentF,
  dynamic contentEs,
  dynamic contentRu,
  dynamic contentC,
  dynamic contentIt,
  String? photo,
  String? appointmentDate,
  num? governmentId,
  dynamic appointmentTypeId,
  String? appointmentTypeNameA,
  String? appointmentTypeNameE,
  dynamic appointmentTypeNameF,
  dynamic appointmentTypeNameEs,
  dynamic appointmentTypeNameRu,
  dynamic appointmentTypeNameC,
  dynamic appointmentTypeNameIt,
  String? formattedAppointmentDate,
  num? sortIndex,
  bool? focus,
  bool? active,
  String? governmentA,
  String? governmentE,
  dynamic governmentF,
  dynamic governmentEs,
  dynamic governmentRu,
  dynamic governmentC,
  dynamic governmentIt,
}) => Appointment(  id: id ?? _id,
  ownerId: ownerId ?? _ownerId,
  titleA: titleA ?? _titleA,
  titleE: titleE ?? _titleE,
  titleF: titleF ?? _titleF,
  titleEs: titleEs ?? _titleEs,
  titleRu: titleRu ?? _titleRu,
  titleC: titleC ?? _titleC,
  titleIt: titleIt ?? _titleIt,
  contentA: contentA ?? _contentA,
  contentE: contentE ?? _contentE,
  contentF: contentF ?? _contentF,
  contentEs: contentEs ?? _contentEs,
  contentRu: contentRu ?? _contentRu,
  contentC: contentC ?? _contentC,
  contentIt: contentIt ?? _contentIt,
  photo: photo ?? _photo,
  appointmentDate: appointmentDate ?? _appointmentDate,
  governmentId: governmentId ?? _governmentId,
  appointmentTypeId: appointmentTypeId ?? _appointmentTypeId,
  appointmentTypeNameA: appointmentTypeNameA ?? _appointmentTypeNameA,
  appointmentTypeNameE: appointmentTypeNameE ?? _appointmentTypeNameE,
  appointmentTypeNameF: appointmentTypeNameF ?? _appointmentTypeNameF,
  appointmentTypeNameEs: appointmentTypeNameEs ?? _appointmentTypeNameEs,
  appointmentTypeNameRu: appointmentTypeNameRu ?? _appointmentTypeNameRu,
  appointmentTypeNameC: appointmentTypeNameC ?? _appointmentTypeNameC,
  appointmentTypeNameIt: appointmentTypeNameIt ?? _appointmentTypeNameIt,
  formattedAppointmentDate: formattedAppointmentDate ?? _formattedAppointmentDate,
  sortIndex: sortIndex ?? _sortIndex,
  focus: focus ?? _focus,
  active: active ?? _active,
  governmentA: governmentA ?? _governmentA,
  governmentE: governmentE ?? _governmentE,
  governmentF: governmentF ?? _governmentF,
  governmentEs: governmentEs ?? _governmentEs,
  governmentRu: governmentRu ?? _governmentRu,
  governmentC: governmentC ?? _governmentC,
  governmentIt: governmentIt ?? _governmentIt,
);
  num? get id => _id;
  num? get ownerId => _ownerId;
  String? get titleA => _titleA;
  String? get titleE => _titleE;
  dynamic get titleF => _titleF;
  dynamic get titleEs => _titleEs;
  dynamic get titleRu => _titleRu;
  dynamic get titleC => _titleC;
  dynamic get titleIt => _titleIt;
  dynamic get contentA => _contentA;
  dynamic get contentE => _contentE;
  dynamic get contentF => _contentF;
  dynamic get contentEs => _contentEs;
  dynamic get contentRu => _contentRu;
  dynamic get contentC => _contentC;
  dynamic get contentIt => _contentIt;
  String? get photo => _photo;
  String? get appointmentDate => _appointmentDate;
  num? get governmentId => _governmentId;
  dynamic get appointmentTypeId => _appointmentTypeId;
  String? get appointmentTypeNameA => _appointmentTypeNameA;
  String? get appointmentTypeNameE => _appointmentTypeNameE;
  dynamic get appointmentTypeNameF => _appointmentTypeNameF;
  dynamic get appointmentTypeNameEs => _appointmentTypeNameEs;
  dynamic get appointmentTypeNameRu => _appointmentTypeNameRu;
  dynamic get appointmentTypeNameC => _appointmentTypeNameC;
  dynamic get appointmentTypeNameIt => _appointmentTypeNameIt;
  String? get formattedAppointmentDate => _formattedAppointmentDate;
  num? get sortIndex => _sortIndex;
  bool? get focus => _focus;
  bool? get active => _active;
  String? get governmentA => _governmentA;
  String? get governmentE => _governmentE;
  dynamic get governmentF => _governmentF;
  dynamic get governmentEs => _governmentEs;
  dynamic get governmentRu => _governmentRu;
  dynamic get governmentC => _governmentC;
  dynamic get governmentIt => _governmentIt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ownerId'] = _ownerId;
    map['titleA'] = _titleA;
    map['titleE'] = _titleE;
    map['titleF'] = _titleF;
    map['titleEs'] = _titleEs;
    map['titleRu'] = _titleRu;
    map['titleC'] = _titleC;
    map['titleIt'] = _titleIt;
    map['contentA'] = _contentA;
    map['contentE'] = _contentE;
    map['contentF'] = _contentF;
    map['contentEs'] = _contentEs;
    map['contentRu'] = _contentRu;
    map['contentC'] = _contentC;
    map['contentIt'] = _contentIt;
    map['photo'] = _photo;
    map['appointmentDate'] = _appointmentDate;
    map['governmentId'] = _governmentId;
    map['appointmentTypeId'] = _appointmentTypeId;
    map['appointmentTypeNameA'] = _appointmentTypeNameA;
    map['appointmentTypeNameE'] = _appointmentTypeNameE;
    map['appointmentTypeNameF'] = _appointmentTypeNameF;
    map['appointmentTypeNameEs'] = _appointmentTypeNameEs;
    map['appointmentTypeNameRu'] = _appointmentTypeNameRu;
    map['appointmentTypeNameC'] = _appointmentTypeNameC;
    map['appointmentTypeNameIt'] = _appointmentTypeNameIt;
    map['formattedAppointmentDate'] = _formattedAppointmentDate;
    map['sortIndex'] = _sortIndex;
    map['focus'] = _focus;
    map['active'] = _active;
    map['governmentA'] = _governmentA;
    map['governmentE'] = _governmentE;
    map['governmentF'] = _governmentF;
    map['governmentEs'] = _governmentEs;
    map['governmentRu'] = _governmentRu;
    map['governmentC'] = _governmentC;
    map['governmentIt'] = _governmentIt;
    return map;
  }

  Map<String, dynamic> toMap() {
    return {
      'titleA': titleA,
      'titleE': titleE,
      'titleF': titleF,
      'titleEs': titleEs,
      'titleRu': titleRu,
      'titleC': titleC,
      'titleIt': titleIt,
      'contentE':contentE,
      'contentF':contentF,
      'contentEs':contentEs,
      'contentRu':contentRu,
      'contentC':contentC,
      'contentIt':contentIt,


    };
  }

}