import 'dart:convert';

GovernmentAgenda governmentAgendaFromJson(String str) => GovernmentAgenda.fromJson(json.decode(str));
String governmentAgendaToJson(GovernmentAgenda data) => json.encode(data.toJson());
class GovernmentAgenda {
  GovernmentAgenda({
    int? id,
    int? ownerId,
    String? titleA,
    String? titleE,
    String? contentA,
    String? contentE,
    dynamic briefA,
    dynamic briefE,
    dynamic url,
    dynamic attachmentA,
    dynamic attachmentE,
    String? photo,
    dynamic cover,
    int? sortIndex,
    bool? focus,
    bool? active,
    dynamic weblinkNameA,
    dynamic weblinkNameE,
    dynamic weblinkUrl,
    dynamic weblinkPhoto,}){
    _id = id;
    _ownerId = ownerId;
    _titleA = titleA;
    _titleE = titleE;
    _contentA = contentA;
    _contentE = contentE;
    _briefA = briefA;
    _briefE = briefE;
    _url = url;
    _attachmentA = attachmentA;
    _attachmentE = attachmentE;
    _photo = photo;
    _cover = cover;
    _sortIndex = sortIndex;
    _focus = focus;
    _active = active;
    _weblinkNameA = weblinkNameA;
    _weblinkNameE = weblinkNameE;
    _weblinkUrl = weblinkUrl;
    _weblinkPhoto = weblinkPhoto;
  }

  GovernmentAgenda.fromJson(dynamic json) {
    _id = json['id'];
    _ownerId = json['ownerId'];
    _titleA = json['titleA'];
    _titleE = json['titleE'];
    _contentA = json['contentA'];
    _contentE = json['contentE'];
    _briefA = json['brief_A'];
    _briefE = json['brief_E'];
    _url = json['url'];
    _attachmentA = json['attachmentA'];
    _attachmentE = json['attachmentE'];
    _photo = json['photo'];
    _cover = json['cover'];
    _sortIndex = json['sortIndex'];
    _focus = json['focus'];
    _active = json['active'];
    _weblinkNameA = json['weblinkNameA'];
    _weblinkNameE = json['weblinkNameE'];
    _weblinkUrl = json['weblinkUrl'];
    _weblinkPhoto = json['weblinkPhoto'];
  }
  int? _id;
  int? _ownerId;
  String? _titleA;
  String? _titleE;
  String? _contentA;
  String? _contentE;
  dynamic _briefA;
  dynamic _briefE;
  dynamic _url;
  dynamic _attachmentA;
  dynamic _attachmentE;
  String? _photo;
  dynamic _cover;
  int? _sortIndex;
  bool? _focus;
  bool? _active;
  dynamic _weblinkNameA;
  dynamic _weblinkNameE;
  dynamic _weblinkUrl;
  dynamic _weblinkPhoto;
  GovernmentAgenda copyWith({  int? id,
    int? ownerId,
    String? titleA,
    String? titleE,
    String? contentA,
    String? contentE,
    dynamic briefA,
    dynamic briefE,
    dynamic url,
    dynamic attachmentA,
    dynamic attachmentE,
    String? photo,
    dynamic cover,
    int? sortIndex,
    bool? focus,
    bool? active,
    dynamic weblinkNameA,
    dynamic weblinkNameE,
    dynamic weblinkUrl,
    dynamic weblinkPhoto,
  }) => GovernmentAgenda(  id: id ?? _id,
    ownerId: ownerId ?? _ownerId,
    titleA: titleA ?? _titleA,
    titleE: titleE ?? _titleE,
    contentA: contentA ?? _contentA,
    contentE: contentE ?? _contentE,
    briefA: briefA ?? _briefA,
    briefE: briefE ?? _briefE,
    url: url ?? _url,
    attachmentA: attachmentA ?? _attachmentA,
    attachmentE: attachmentE ?? _attachmentE,
    photo: photo ?? _photo,
    cover: cover ?? _cover,
    sortIndex: sortIndex ?? _sortIndex,
    focus: focus ?? _focus,
    active: active ?? _active,
    weblinkNameA: weblinkNameA ?? _weblinkNameA,
    weblinkNameE: weblinkNameE ?? _weblinkNameE,
    weblinkUrl: weblinkUrl ?? _weblinkUrl,
    weblinkPhoto: weblinkPhoto ?? _weblinkPhoto,
  );
  int? get id => _id;
  int? get ownerId => _ownerId;
  String? get titleA => _titleA;
  String? get titleE => _titleE;
  String? get contentA => _contentA;
  String? get contentE => _contentE;
  dynamic get briefA => _briefA;
  dynamic get briefE => _briefE;
  dynamic get url => _url;
  dynamic get attachmentA => _attachmentA;
  dynamic get attachmentE => _attachmentE;
  String? get photo => _photo;
  dynamic get cover => _cover;
  int? get sortIndex => _sortIndex;
  bool? get focus => _focus;
  bool? get active => _active;
  dynamic get weblinkNameA => _weblinkNameA;
  dynamic get weblinkNameE => _weblinkNameE;
  dynamic get weblinkUrl => _weblinkUrl;
  dynamic get weblinkPhoto => _weblinkPhoto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ownerId'] = _ownerId;
    map['titleA'] = _titleA;
    map['titleE'] = _titleE;
    map['contentA'] = _contentA;
    map['contentE'] = _contentE;
    map['brief_A'] = _briefA;
    map['brief_E'] = _briefE;
    map['url'] = _url;
    map['attachmentA'] = _attachmentA;
    map['attachmentE'] = _attachmentE;
    map['photo'] = _photo;
    map['cover'] = _cover;
    map['sortIndex'] = _sortIndex;
    map['focus'] = _focus;
    map['active'] = _active;
    map['weblinkNameA'] = _weblinkNameA;
    map['weblinkNameE'] = _weblinkNameE;
    map['weblinkUrl'] = _weblinkUrl;
    map['weblinkPhoto'] = _weblinkPhoto;
    return map;
  }

}