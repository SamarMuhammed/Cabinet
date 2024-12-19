import 'dart:convert';

/// id : 0
/// ownerId : 0
/// titleA : null
/// titleE : "The State Ownership Policy"
/// contentA : null
/// contentE : "<p>\r\n      Over the past decades, the role of the Egyptian State has witnessed many transformations to cope with the economic and social changes and the prevailing economic thought.\r\nIt witnessed advocates of limiting the role of the State to creating ways that ensure the success of liberal regimes based on free economy and advocates of the State’s direct intervention in the economic activity.\r\nThe Egyptian Government is always keen on maximizing the welfare of its citizens as per a comprehensive social contract, which ensures that the State responds to the social and economic entitlements of its citizens.\r\nThis contract varies from one era to another according to the economic and social conditions. \r\nThe significant presence of the State, sometimes, resulted in the expansion of the Egyptian state-owned assets portfolio to include many companies of the public\r\nsector and the public business sector. \r\nOn one hand, it has been present in many other sectors concerned with strategic goods or fundamental services. On the other hand, the State is present in other sectors to realize specific economic or social dimensions.\r\n    </p>"
/// brief_A : null
/// brief_E : null
/// url : null
/// attachmentA : null
/// attachmentE : "/UI/pdf/property-policy-document-eng.pdf"
/// photo : null
/// cover : null
/// sortIndex : 0
/// focus : false
/// active : false
/// weblinkNameA : null
/// weblinkNameE : null
/// weblinkUrl : null
/// weblinkPhoto : null
/// photos : null

OwnerShipDocument ownerShipDocumentFromJson(String str) => OwnerShipDocument.fromJson(json.decode(str));
String ownerShipDocumentToJson(OwnerShipDocument data) => json.encode(data.toJson());
class OwnerShipDocument {
  OwnerShipDocument({
    int? id,
    int? ownerId,
    dynamic titleA,
    String? titleE,
    dynamic contentA,
    String? contentE,
    dynamic briefA,
    dynamic briefE,
    dynamic url,
    dynamic attachmentA,
    String? attachmentE,
    dynamic photo,
    dynamic cover,
    int? sortIndex,
    bool? focus,
    bool? active,
    dynamic weblinkNameA,
    dynamic weblinkNameE,
    dynamic weblinkUrl,
    dynamic weblinkPhoto,
    dynamic photos,}){
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
    _photos = photos;
  }

  OwnerShipDocument.fromJson(dynamic json) {
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
    _photos = json['photos'];
  }
  int? _id;
  int? _ownerId;
  dynamic _titleA;
  String? _titleE;
  dynamic _contentA;
  String? _contentE;
  dynamic _briefA;
  dynamic _briefE;
  dynamic _url;
  dynamic _attachmentA;
  String? _attachmentE;
  dynamic _photo;
  dynamic _cover;
  int? _sortIndex;
  bool? _focus;
  bool? _active;
  dynamic _weblinkNameA;
  dynamic _weblinkNameE;
  dynamic _weblinkUrl;
  dynamic _weblinkPhoto;
  dynamic _photos;
  OwnerShipDocument copyWith({  int? id,
    int? ownerId,
    dynamic titleA,
    String? titleE,
    dynamic contentA,
    String? contentE,
    dynamic briefA,
    dynamic briefE,
    dynamic url,
    dynamic attachmentA,
    String? attachmentE,
    dynamic photo,
    dynamic cover,
    int? sortIndex,
    bool? focus,
    bool? active,
    dynamic weblinkNameA,
    dynamic weblinkNameE,
    dynamic weblinkUrl,
    dynamic weblinkPhoto,
    dynamic photos,
  }) => OwnerShipDocument(  id: id ?? _id,
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
    photos: photos ?? _photos,
  );
  int? get id => _id;
  int? get ownerId => _ownerId;
  dynamic get titleA => _titleA;
  String? get titleE => _titleE;
  dynamic get contentA => _contentA;
  String? get contentE => _contentE;
  dynamic get briefA => _briefA;
  dynamic get briefE => _briefE;
  dynamic get url => _url;
  dynamic get attachmentA => _attachmentA;
  String? get attachmentE => _attachmentE;
  dynamic get photo => _photo;
  dynamic get cover => _cover;
  int? get sortIndex => _sortIndex;
  bool? get focus => _focus;
  bool? get active => _active;
  dynamic get weblinkNameA => _weblinkNameA;
  dynamic get weblinkNameE => _weblinkNameE;
  dynamic get weblinkUrl => _weblinkUrl;
  dynamic get weblinkPhoto => _weblinkPhoto;
  dynamic get photos => _photos;

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
    map['photos'] = _photos;
    return map;
  }

}