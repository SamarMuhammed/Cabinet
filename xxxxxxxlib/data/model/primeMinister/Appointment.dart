import 'dart:convert';

/// id : 3506
/// ownerId : 1
/// titleA : "رئيس الوزراء يستقبل وكيلة الأمين العام المديرة التنفيذية لهيئة الأمم المتحدة للمساواة بين الجنسين وتمكين المرأة"
/// titleE : "مدبولي: دعم غير مسبوق من الرئيس السيسي للمرأة المصرية انعكس فيما اتخذته الدولة من إجراءات"
/// contentA : null
/// contentE : null
/// photo : "SLM_2340.JPG"
/// appointmentDate : "2021-11-29T00:00:00"
/// governmentId : 0
/// appointmentTypeId : null
/// appointmentTypeNameA : "لقاءات رئيس مجلس الوزراء"
/// appointmentTypeNameE : "لقاءات رئيس مجلس الوزراء"
/// sortIndex : 0
/// focus : false
/// active : true
/// governmentA : "وزارة الدكتور/ مصطفى مدبولى (الأولي)"
/// governmentE : "Dr. Mostafa Kamal Madbouly (First Cabinet)"

Appointment appointmentFromJson(String str) => Appointment.fromJson(json.decode(str));
String appointmentToJson(Appointment data) => json.encode(data.toJson());
class Appointment {
  Appointment({
      int? id, 
      int? ownerId, 
      String? titleA, 
      String? titleE, 
      dynamic contentA, 
      dynamic contentE,
    String? formattedAppointmentDate,
    String? photo,
      String? appointmentDate, 
      int? governmentId, 
      dynamic appointmentTypeId, 
      String? appointmentTypeNameA, 
      String? appointmentTypeNameE, 
      int? sortIndex, 
      bool? focus, 
      bool? active, 
      String? governmentA, 
      String? governmentE,}){
    _id = id;
    _ownerId = ownerId;
    _titleA = titleA;
    _titleE = titleE;
    _contentA = contentA;
    _contentE = contentE;
    _photo = photo;
    _formattedAppointmentDate= formattedAppointmentDate;
    _appointmentDate = appointmentDate;
    _governmentId = governmentId;
    _appointmentTypeId = appointmentTypeId;
    _appointmentTypeNameA = appointmentTypeNameA;
    _appointmentTypeNameE = appointmentTypeNameE;
    _sortIndex = sortIndex;
    _focus = focus;
    _active = active;
    _governmentA = governmentA;
    _governmentE = governmentE;
}

  Appointment.fromJson(dynamic json) {
    _id = json['id'];
    _ownerId = json['ownerId'];
    _titleA = json['titleA'];
    _titleE = json['titleE'];
    _contentA = json['contentA'];
    _contentE = json['contentE'];
    _photo = json['photo'];
    _appointmentDate = json['appointmentDate'];
    _formattedAppointmentDate = json['formattedAppointmentDate'];

    _governmentId = json['governmentId'];
    _appointmentTypeId = json['appointmentTypeId'];
    _appointmentTypeNameA = json['appointmentTypeNameA'];
    _appointmentTypeNameE = json['appointmentTypeNameE'];
    _sortIndex = json['sortIndex'];
    _focus = json['focus'];
    _active = json['active'];
    _governmentA = json['governmentA'];
    _governmentE = json['governmentE'];
  }
  int? _id;
  int? _ownerId;
  String? _titleA;
  String? _titleE;
  dynamic _contentA;
  dynamic _contentE;
  String? _photo;
  String? _formattedAppointmentDate;
  String? _appointmentDate;
  int? _governmentId;
  dynamic _appointmentTypeId;
  String? _appointmentTypeNameA;
  String? _appointmentTypeNameE;
  int? _sortIndex;
  bool? _focus;
  bool? _active;
  String? _governmentA;
  String? _governmentE;
Appointment copyWith({  int? id,
  int? ownerId,
  String? titleA,
  String? titleE,
  dynamic contentA,
  dynamic contentE,
  String? photo,
  String? appointmentDate,
  int? governmentId,
  dynamic appointmentTypeId,
  String? appointmentTypeNameA,
  String? appointmentTypeNameE,
  int? sortIndex,
  bool? focus,
  bool? active,
  String? governmentA,
  String? governmentE,
}) => Appointment(  id: id ?? _id,
  ownerId: ownerId ?? _ownerId,
  titleA: titleA ?? _titleA,
  titleE: titleE ?? _titleE,
  contentA: contentA ?? _contentA,
  contentE: contentE ?? _contentE,
  photo: photo ?? _photo,
  formattedAppointmentDate: _formattedAppointmentDate ?? _formattedAppointmentDate,

  appointmentDate: appointmentDate ?? _appointmentDate,
  governmentId: governmentId ?? _governmentId,
  appointmentTypeId: appointmentTypeId ?? _appointmentTypeId,
  appointmentTypeNameA: appointmentTypeNameA ?? _appointmentTypeNameA,
  appointmentTypeNameE: appointmentTypeNameE ?? _appointmentTypeNameE,
  sortIndex: sortIndex ?? _sortIndex,
  focus: focus ?? _focus,
  active: active ?? _active,
  governmentA: governmentA ?? _governmentA,
  governmentE: governmentE ?? _governmentE,
);
  int? get id => _id;
  int? get ownerId => _ownerId;
  String? get titleA => _titleA;
  String? get titleE => _titleE;
  dynamic get contentA => _contentA;
  dynamic get contentE => _contentE;
  String? get photo => _photo;
  String? get formattedAppointmentDate => _formattedAppointmentDate;
  String? get appointmentDate => _appointmentDate;
  int? get governmentId => _governmentId;
  dynamic get appointmentTypeId => _appointmentTypeId;
  String? get appointmentTypeNameA => _appointmentTypeNameA;
  String? get appointmentTypeNameE => _appointmentTypeNameE;
  int? get sortIndex => _sortIndex;
  bool? get focus => _focus;
  bool? get active => _active;
  String? get governmentA => _governmentA;
  String? get governmentE => _governmentE;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ownerId'] = _ownerId;
    map['titleA'] = _titleA;
    map['titleE'] = _titleE;
    map['contentA'] = _contentA;
    map['contentE'] = _contentE;
    map['photo'] = _photo;
    map['appointmentDate'] = _appointmentDate;
    map['formattedAppointmentDate'] = _formattedAppointmentDate;

    map['governmentId'] = _governmentId;
    map['appointmentTypeId'] = _appointmentTypeId;
    map['appointmentTypeNameA'] = _appointmentTypeNameA;
    map['appointmentTypeNameE'] = _appointmentTypeNameE;
    map['sortIndex'] = _sortIndex;
    map['focus'] = _focus;
    map['active'] = _active;
    map['governmentA'] = _governmentA;
    map['governmentE'] = _governmentE;
    return map;
  }

}