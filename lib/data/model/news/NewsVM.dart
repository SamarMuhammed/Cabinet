import 'dart:convert';

/// id : 60284
/// ownerId : 0
/// introTitleA : null
/// introTitleE : null
/// titleA : "خلال جولته بالحي الحكومي: رئيس الوزراء يتفقد مقر وزارة النقل بالعاصمة الإدارية الجديدة"
/// titleE : "During his tour of the government district: Prime Minister inspects the headquarters of the Ministry of Transport in the New Administrative Capital"
/// contentA : null
/// contentE : null
/// youtubeId : null
/// url : null
/// urltext : null
/// photoCaptionA : null
/// photoCaptionE : null
/// photo : "/Upload/News/Photo/60284/SLM_2793.JPG"
/// attachmentA : null
/// attachmentE : null
/// author : null
/// publishDate : "2023-05-09T00:00:00"
/// newsCategoryId : 0
/// governmentId : 0
/// sourceTypeId : 0
/// sourceId : 0
/// sortIndex : 0
/// focus : false
/// active : true
/// newsCategoryNameA : "الزيارات الميدانية"
/// newsCategoryNameE : "Field Visits"
/// governmentNameA : "وزارة الدكتور/ مصطفى مدبولى (الثانية)"
/// governmentNameE : "Dr. Mostafa Kamal Madbouly (Second Cabinet)"
/// sourceTypeNameA : null
/// sourceTypeNameE : null
/// sourceNameA : null
/// sourceNameE : null

NewsVM newsVmFromJson(String str) => NewsVM.fromJson(json.decode(str));
String newsVmToJson(NewsVM data) => json.encode(data.toJson());
class NewsVM {
  NewsVm({
    int? id,
    int? ownerId,
    dynamic introTitleA,
    dynamic introTitleE,
    String? titleA,
    String? titleE,
    String? titleF,
    String? titleEs,
    String? titleR,
    String? titleC,
    String? titleIt,
    dynamic contentA,
    dynamic contentE,
    dynamic contentF,
    dynamic contentEs,
    dynamic contentR,
    dynamic contentC,
    dynamic contentIt,
    dynamic youtubeId,
    dynamic url,
    dynamic urltext,
    dynamic photoCaptionA,
    dynamic photoCaptionE,
    String? photo,
    dynamic attachmentA,
    dynamic attachmentE,
    dynamic author,
    String? publishDate,
    String? formatedPublishDate,
    String? shareUrl,
    int? newsCategoryId,
    int? governmentId,
    int? sourceTypeId,
    int? sourceId,
    int? sortIndex,
    bool? focus,
    bool? active,
    String? newsCategoryNameA,
    String? newsCategoryNameE,
    String? newsCategoryNameF,
    String? newsCategoryNameIt,
    String? newsCategoryNameR,
    String? newsCategoryNameC,
    String? newsCategoryNameEs,
    String? governmentNameA,
    String? governmentNameE,
    dynamic sourceTypeNameA,
    dynamic sourceTypeNameE,
    dynamic sourceNameA,
    dynamic sourceNameE,}){
    _id = id;
    _ownerId = ownerId;
    _introTitleA = introTitleA;
    _introTitleE = introTitleE;
    _titleA = titleA;
    _titleE = titleE;
    _titleF =titleF;
    _titleEs =titleEs;
    _titleR =titleR;
    _titleC =titleC;
    _titleIt =titleIt;
    _contentA = contentA;
    _contentE = contentE;
    _contentF = contentF;
    _contentEs = contentEs;
    _contentR = contentR;
    _contentC = contentC;
    _contentIt = contentIt;

    _youtubeId = youtubeId;
    _url = url;
    _urltext = urltext;
    _photoCaptionA = photoCaptionA;
    _photoCaptionE = photoCaptionE;
    _photo = photo;
    _attachmentA = attachmentA;
    _attachmentE = attachmentE;
    _author = author;
    _publishDate = publishDate;
    _formatedPublishDate = formatedPublishDate;
    _shareUrl = shareUrl;
    _newsCategoryId = newsCategoryId;
    _governmentId = governmentId;
    _sourceTypeId = sourceTypeId;
    _sourceId = sourceId;
    _sortIndex = sortIndex;
    _focus = focus;
    _active = active;
    _newsCategoryNameA = newsCategoryNameA;
    _newsCategoryNameE = newsCategoryNameE;
    _newsCategoryNameF = newsCategoryNameF;
    _newsCategoryNameEs = newsCategoryNameEs;
    _newsCategoryNameIt = newsCategoryNameIt;
    _newsCategoryNameR = newsCategoryNameR;
    _newsCategoryNameC = newsCategoryNameC;
    _governmentNameA = governmentNameA;
    _governmentNameE = governmentNameE;
    _sourceTypeNameA = sourceTypeNameA;
    _sourceTypeNameE = sourceTypeNameE;
    _sourceNameA = sourceNameA;
    _sourceNameE = sourceNameE;
  }

  NewsVM.fromJson(dynamic json) {
    _id = json['id'];
    _ownerId = json['ownerId'];
    _introTitleA = json['introTitleA'];
    _introTitleE = json['introTitleE'];
    _titleA = json['titleA'];
    _titleE = json['titleE'];
    _titleF = json['titleF'];
    _titleEs =json['titleEs'];
    _titleR =json['titleR'];
    _titleC =json['titleC'];
    _titleIt =json['titleIt'];

    _contentF = json['contentF'];;
    _contentEs = json['contentEs'];
    _contentR = json['contentR'];;
    _contentC = json['contentC'];
    _contentIt = json['contentIt'];
    _contentA = json['contentA'];
    _contentE = json['contentE'];
    _youtubeId = json['youtubeId'];
    _url = json['url'];
    _urltext = json['urltext'];
    _photoCaptionA = json['photoCaptionA'];
    _photoCaptionE = json['photoCaptionE'];
    _photo = json['photo'];
    _attachmentA = json['attachmentA'];
    _attachmentE = json['attachmentE'];
    _author = json['author'];
    _publishDate = json['publishDate'];
    _formatedPublishDate = json['formatedPublishDate'];
    _shareUrl = json['shareUrl'];
    _newsCategoryId = json['newsCategoryId'];
    _governmentId = json['governmentId'];
    _sourceTypeId = json['sourceTypeId'];
    _sourceId = json['sourceId'];
    _sortIndex = json['sortIndex'];
    _focus = json['focus'];
    _active = json['active'];
    _newsCategoryNameA = json['newsCategoryNameA'];
    _newsCategoryNameE = json['newsCategoryNameE'];
    _newsCategoryNameEs = json['newsCategoryNameEs'];
    _newsCategoryNameF = json['newsCategoryNameF'];
    _newsCategoryNameR = json['newsCategoryNameR'];
    _newsCategoryNameC = json['newsCategoryNameC'];
    _newsCategoryNameIt = json['newsCategoryNameIt'];
    _governmentNameA = json['governmentNameA'];
    _governmentNameE = json['governmentNameE'];
    _sourceTypeNameA = json['sourceTypeNameA'];
    _sourceTypeNameE = json['sourceTypeNameE'];
    _sourceNameA = json['sourceNameA'];
    _sourceNameE = json['sourceNameE'];
  }
  int? _id;
  int? _ownerId;
  dynamic _introTitleA;
  dynamic _introTitleE;
  String? _titleA;
  String? _titleE;
  String? _titleF;
  String? _titleEs;
  String? _titleR;
  String? _titleC;
  String? _titleIt;
  dynamic _contentA;
  dynamic _contentE;
  dynamic _contentF;
  dynamic _contentEs;
  dynamic _contentR;
  dynamic _contentC;
  dynamic _contentIt;
  dynamic _youtubeId;
  dynamic _url;
  dynamic _urltext;
  dynamic _photoCaptionA;
  dynamic _photoCaptionE;
  String? _photo;
  dynamic _attachmentA;
  dynamic _attachmentE;
  dynamic _author;
  String? _publishDate;
  String? _formatedPublishDate;
  String? _shareUrl;
  int? _newsCategoryId;
  int? _governmentId;
  int? _sourceTypeId;
  int? _sourceId;
  int? _sortIndex;
  bool? _focus;
  bool? _active;
  String? _newsCategoryNameA;
  String? _newsCategoryNameE;
  String? _newsCategoryNameEs;
  String? _newsCategoryNameF;
  String? _newsCategoryNameR;
  String? _newsCategoryNameC;
  String? _newsCategoryNameIt;
  String? _governmentNameA;
  String? _governmentNameE;
  dynamic _sourceTypeNameA;
  dynamic _sourceTypeNameE;
  dynamic _sourceNameA;
  dynamic _sourceNameE;
  NewsVM copyWith({  int? id,
    int? ownerId,
    dynamic introTitleA,
    dynamic introTitleE,
    String? titleA,
    String? titleE,
    String? titleF,
    String? titleEs,
    String? titleR,
    String? titleC,
    String? titleIt,
    dynamic contentA,
    dynamic contentE,
    dynamic contentF,
    dynamic contentEs,
    dynamic contentR,
    dynamic contentC,
    dynamic contentIt,
    dynamic youtubeId,
    dynamic url,
    dynamic urltext,
    dynamic photoCaptionA,
    dynamic photoCaptionE,
    String? photo,
    dynamic attachmentA,
    dynamic attachmentE,
    dynamic author,
    String? publishDate,
    String? formatePublishDate,
    String? shareUrl,
    int? newsCategoryId,
    int? governmentId,
    int? sourceTypeId,
    int? sourceId,
    int? sortIndex,
    bool? focus,
    bool? active,
    String? newsCategoryNameA,
    String? newsCategoryNameE,
    String? newsCategoryNameEs,
    String? newsCategoryNameF,
    String? newsCategoryNameIt,
    String? newsCategoryNameC,
    String? newsCategoryNameR,
    String? governmentNameA,
    String? governmentNameE,
    dynamic sourceTypeNameA,
    dynamic sourceTypeNameE,
    dynamic sourceNameA,
    dynamic sourceNameE,
  }) => NewsVm(  id: id ?? _id,
    ownerId: ownerId ?? _ownerId,
    introTitleA: introTitleA ?? _introTitleA,
    introTitleE: introTitleE ?? _introTitleE,
    titleA: titleA ?? _titleA,
    titleE: titleE ?? _titleE,
    titleF: titleF ?? _titleF,
    titleEs: titleEs ?? _titleEs,
    titleR: titleR ?? _titleR,
    titleC: titleC ?? _titleC,
    titleIt: titleIt ?? _titleIt,
    contentA: contentA ?? _contentA,
    contentE: contentE ?? _contentE,
    contentF: contentF ?? _contentF,
    contentEs: contentEs ?? _contentEs,
    contentR: contentR ?? _contentR,
    contentC: contentC ?? _contentC,
    contentIt: contentIt ?? _contentIt,
    youtubeId: youtubeId ?? _youtubeId,
    url: url ?? _url,
    urltext: urltext ?? _urltext,
    photoCaptionA: photoCaptionA ?? _photoCaptionA,
    photoCaptionE: photoCaptionE ?? _photoCaptionE,
    photo: photo ?? _photo,
    attachmentA: attachmentA ?? _attachmentA,
    attachmentE: attachmentE ?? _attachmentE,
    author: author ?? _author,
    publishDate: publishDate ?? _publishDate,
    formatedPublishDate: formatedPublishDate ?? _formatedPublishDate,

    shareUrl: shareUrl ?? _shareUrl,
    newsCategoryId: newsCategoryId ?? _newsCategoryId,
    governmentId: governmentId ?? _governmentId,
    sourceTypeId: sourceTypeId ?? _sourceTypeId,
    sourceId: sourceId ?? _sourceId,
    sortIndex: sortIndex ?? _sortIndex,
    focus: focus ?? _focus,
    active: active ?? _active,
    newsCategoryNameA: newsCategoryNameA ?? _newsCategoryNameA,
    newsCategoryNameE: newsCategoryNameE ?? _newsCategoryNameE,
    newsCategoryNameEs: newsCategoryNameEs ?? _newsCategoryNameEs,
    newsCategoryNameR: newsCategoryNameR ?? _newsCategoryNameR,
    newsCategoryNameC: newsCategoryNameC ?? _newsCategoryNameC,
    newsCategoryNameIt: newsCategoryNameIt ?? _newsCategoryNameIt,
    newsCategoryNameF: newsCategoryNameF ?? _newsCategoryNameF,
    governmentNameA: governmentNameA ?? _governmentNameA,
    governmentNameE: governmentNameE ?? _governmentNameE,
    sourceTypeNameA: sourceTypeNameA ?? _sourceTypeNameA,
    sourceTypeNameE: sourceTypeNameE ?? _sourceTypeNameE,
    sourceNameA: sourceNameA ?? _sourceNameA,
    sourceNameE: sourceNameE ?? _sourceNameE,
  );
  int? get id => _id;
  int? get ownerId => _ownerId;
  dynamic get introTitleA => _introTitleA;
  dynamic get introTitleE => _introTitleE;
  String? get titleA => _titleA;
  String? get titleE => _titleE;
  String? get titleF => _titleF;
  String? get titleEs => _titleEs;
  String? get titleR => _titleR;
  String? get titleC => _titleC;
  String? get titleIt => _titleIt;
  dynamic get contentA => _contentA;
  dynamic get contentE => _contentE;
  dynamic get contentF => _contentF;
  dynamic get contentEs => _contentEs;
  dynamic get contentR => _contentR;
  dynamic get contentC => _contentC;
  dynamic get contentIt => _contentIt;
  dynamic get youtubeId => _youtubeId;
  dynamic get url => _url;
  dynamic get urltext => _urltext;
  dynamic get photoCaptionA => _photoCaptionA;
  dynamic get photoCaptionE => _photoCaptionE;
  String? get photo => _photo;
  dynamic get attachmentA => _attachmentA;
  dynamic get attachmentE => _attachmentE;
  dynamic get author => _author;
  String? get publishDate => _publishDate;
  String? get formatedPublishDate => _formatedPublishDate;
  String? get shareUrl => _shareUrl;
  int? get newsCategoryId => _newsCategoryId;
  int? get governmentId => _governmentId;
  int? get sourceTypeId => _sourceTypeId;
  int? get sourceId => _sourceId;
  int? get sortIndex => _sortIndex;
  bool? get focus => _focus;
  bool? get active => _active;
  String? get newsCategoryNameA => _newsCategoryNameA;
  String? get newsCategoryNameE => _newsCategoryNameE;
  String? get newsCategoryNameEs => _newsCategoryNameEs;
  String? get newsCategoryNameF => _newsCategoryNameF;
  String? get newsCategoryNameR => _newsCategoryNameR;
  String? get newsCategoryNameIt => _newsCategoryNameIt;
  String? get newsCategoryNameC => _newsCategoryNameC;
  String? get governmentNameA => _governmentNameA;
  String? get governmentNameE => _governmentNameE;
  dynamic get sourceTypeNameA => _sourceTypeNameA;
  dynamic get sourceTypeNameE => _sourceTypeNameE;
  dynamic get sourceNameA => _sourceNameA;
  dynamic get sourceNameE => _sourceNameE;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ownerId'] = _ownerId;
    map['introTitleA'] = _introTitleA;
    map['introTitleE'] = _introTitleE;
    map['titleA'] = _titleA;
    map['titleE'] = _titleE;
    map['titleF'] = _titleF;
    map['titleEs'] = _titleEs;
    map['titleR'] = _titleR;
    map['titleC'] = _titleC;
    map['titleIt'] = _titleIt;
    map['contentA'] = _contentA;
    map['contentE'] = _contentE;
    map['contentF'] = _contentF;
    map['contentEs'] = _contentEs;
    map['contentR'] = _contentR;
    map['contentC'] = _contentC;
    map['contentIt'] = _contentIt;
    map['youtubeId'] = _youtubeId;
    map['url'] = _url;
    map['urltext'] = _urltext;
    map['photoCaptionA'] = _photoCaptionA;
    map['photoCaptionE'] = _photoCaptionE;
    map['photo'] = _photo;
    map['attachmentA'] = _attachmentA;
    map['attachmentE'] = _attachmentE;
    map['author'] = _author;
    map['publishDate'] = _publishDate;
    map['formatedPublishDate'] = _formatedPublishDate;
    map['shareUrl'] = _shareUrl;
    map['newsCategoryId'] = _newsCategoryId;
    map['governmentId'] = _governmentId;
    map['sourceTypeId'] = _sourceTypeId;
    map['sourceId'] = _sourceId;
    map['sortIndex'] = _sortIndex;
    map['focus'] = _focus;
    map['active'] = _active;
    map['newsCategoryNameA'] = _newsCategoryNameA;
    map['newsCategoryNameE'] = _newsCategoryNameE;
    map['newsCategoryNameEs'] = _newsCategoryNameEs;
    map['newsCategoryNameF'] = _newsCategoryNameF;
    map['newsCategoryNameR'] = _newsCategoryNameR;
    map['newsCategoryNameC'] = _newsCategoryNameC;
    map['newsCategoryNameIt'] = _newsCategoryNameIt;
    map['governmentNameA'] = _governmentNameA;
    map['governmentNameE'] = _governmentNameE;
    map['sourceTypeNameA'] = _sourceTypeNameA;
    map['sourceTypeNameE'] = _sourceTypeNameE;
    map['sourceNameA'] = _sourceNameA;
    map['sourceNameE'] = _sourceNameE;
    return map;
  }

  Map<String, dynamic> toMap() {
    return {
      'titleA': titleA,
      'titleE': titleE,
      'titleF': titleF,
      'titleEs': titleEs,
      'titleR': titleR,
      'titleC': titleC,
      'titleIt': titleIt,
      'contentE':contentE,
      'contentF':contentF,
      'contentEs':contentEs,
      'contentR':contentR,
      'contentC':contentC,
      'contentIt':contentIt,
      'newsCategoryNameC':newsCategoryNameC,
      'newsCategoryNameE':newsCategoryNameE,
      'newsCategoryNameF':newsCategoryNameF,
      'newsCategoryNameEs':newsCategoryNameEs,
      'newsCategoryNameIt':newsCategoryNameIt,
      'newsCategoryNameR':newsCategoryNameR,

    };

  }

  String getTitle(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return titleA ?? '';
      case 'en':
        return titleE ?? '';
      case 'fr':
        return titleF ?? '';
      case 'es':
        return titleEs ?? '';
      case 'ru':
        return titleR ?? '';
      case 'zh':
        return titleC ?? '';
      case 'it':
        return titleIt ?? '';
      default:
        return titleE ?? ''; // Default to English if no match
    }
  }

  /// Method to dynamically get content based on language
  String getContent(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return contentA ?? '';
      case 'en':
        return contentE ?? '';
      case 'fr':
        return contentF ?? '';
      case 'es':
        return contentEs ?? '';
      case 'ru':
        return contentR ?? '';
      case 'zh':
        return contentC ?? '';
      case 'it':
        return contentIt ?? '';
      default:
        return contentE ?? ''; // Default to English if no match
    }
  }

  // Method to get the localized value dynamically


}