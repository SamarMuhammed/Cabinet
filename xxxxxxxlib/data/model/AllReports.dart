import 'dart:convert';
/// description : ""
/// reports : [{"id":92,"createDate":"8/3/2021","title":"التكتيكات والأهداف الإرهابية المحليَّة في الولايات المتحدة الأمريكية ","description":"في ضوء الاهتمام المشترك من قِبل مجلس الشيوخ الأمريكي ومركز الدراسات الاستراتيجية والدولية بمكافحة الإرهاب في الولايات المتحدة الامريكية، تأتي هذه الشهادة من قِبل الدكتور \"سيث جونز\"، نائب مدير مركز الدراسات الاستراتيجية والدولية، ومدير برنامج الأمن الدولي؛ لتوضيح بعض الحقائق عن الإرهاب المحلي في الولايات المتحدة الأمريكية. ","image":"http://idscapp.gov.eg/public/upload/reports/images/92/ReportImg.jpg","sourceID":57,"sourceName":"مركز المعلومات ودعم اتخاذ القرار","topicID":1,"topicName":"كوفيد-19","categoryID":39,"categoryName":"إصدارات دولية","attachment":"http://idscapp.gov.eg/public/upload/reports/attachment/92/ReportAttachment.pdf","hashtags":""},{"id":91,"createDate":"4/22/2021","title":"توقعات الاستثمار العالمي لعام 2021","description":"","image":"http://idscapp.gov.eg/public/upload/reports/images/91/ReportImg.png","sourceID":57,"sourceName":"مركز المعلومات ودعم اتخاذ القرار","topicID":1,"topicName":"كوفيد-19","categoryID":39,"categoryName":"إصدارات دولية","attachment":"http://idscapp.gov.eg/public/upload/reports/attachment/91/ReportAttachment.pdf","hashtags":""},{"id":90,"createDate":"4/7/2021","title":"أثر التحويلات المالية","description":"تناول التقرير الصادر عن أكسفورد إيكينومكس (Oxford Economics) التوقعات بشأن التحويلات المالية على مستوى العالم وتداعيات جائحة \"كوفيد- 19 \" على حجم التحويلات العالمية","image":"http://idscapp.gov.eg/public/upload/reports/images/90/ReportImg.jpg","sourceID":57,"sourceName":"مركز المعلومات ودعم اتخاذ القرار","topicID":1,"topicName":"كوفيد-19","categoryID":39,"categoryName":"إصدارات دولية","attachment":"http://idscapp.gov.eg/public/upload/reports/attachment/90/ReportAttachment.pdf","hashtags":""},{"id":81,"createDate":"3/18/2021","title":"عرض تقرير مؤشر الحرية الأقتصادية","description":"تقدمت مصر 12 مركزًا في مؤشر الحرية الاقتصادية عام 2021 مقارنة بعام 2020، كما حصلت على المركز الحادي عشر على مستوى دول الشرق الأوسط وشمال إفريقيا وهي بذلك تعد ضمن الدول الخمس الأولى التي حققت تقدمًا على المستوى الإقليمي. ","image":"http://idscapp.gov.eg/public/upload/reports/images/81/ReportEdit.png","sourceID":26,"sourceName":"أخرى","topicID":1,"topicName":"كوفيد-19","categoryID":39,"categoryName":"إصدارات دولية","attachment":"http://idscapp.gov.eg/public/upload/reports/attachment/81/عرض تقرير الحرية الاقتصادية.pdf","hashtags":""},{"id":80,"createDate":"3/18/2021","title":"تقرير مؤشر المعرفة العالمى ","description":"","image":"http://idscapp.gov.eg/public/upload/reports/images/80/ReportEdit.png","sourceID":26,"sourceName":"أخرى","topicID":1,"topicName":"كوفيد-19","categoryID":39,"categoryName":"إصدارات دولية","attachment":"http://idscapp.gov.eg/public/upload/reports/attachment/80/عرض تقرير المعرفة العالمي.pdf","hashtags":"test"}]
/// id : 39
/// name : "إصدارات دولية"
/// isSelected : false
////allreports دي هي السلسلة اللي فيها كل التقارير الخاصة بيها بس
AllReports AllReportsFromJson(String str) => AllReports.fromJson(json.decode(str));
String AllReportsToJson(AllReports data) => json.encode(data.toJson());
class AllReports {
  AllReports({
    String? description,
    List<Reports>? reports,
    int? id,
    String? name,
    bool? isSelected,
    String? icon,
  }){
    _description = description;
    _reports = reports;
    _id = id;
    _name = name;
    _isSelected = isSelected;
    _icon = icon;
  }

  AllReports.fromJson(dynamic json) {
    _description = json['description'];
    if (json['reports'] != null) {
      _reports = [];
      json['reports'].forEach((v) {
        _reports?.add(Reports.fromJson(v));
      });
    }
    _id = json['id'];
    _name = json['name'];
    _isSelected = json['isSelected'];
    _icon = json['icon'];
  }
  String? _description;
  List<Reports>? _reports;
  int? _id;
  String? _name;
  String? _icon;
  bool? _isSelected;

  String? get description => _description;
  List<Reports>? get reports => _reports;
  int? get id => _id;
  String? get name => _name;
  bool? get isSelected => _isSelected;
  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = _description;
    if (_reports != null) {
      map['reports'] = _reports?.map((v) => v.toJson()).toList();
    }
    map['id'] = _id;
    map['name'] = _name;
    map['isSelected'] = _isSelected;
    map['icon'] = _icon;
    return map;
  }

}

/// id : 92
/// createDate : "8/3/2021"
/// title : "التكتيكات والأهداف الإرهابية المحليَّة في الولايات المتحدة الأمريكية "
/// description : "في ضوء الاهتمام المشترك من قِبل مجلس الشيوخ الأمريكي ومركز الدراسات الاستراتيجية والدولية بمكافحة الإرهاب في الولايات المتحدة الامريكية، تأتي هذه الشهادة من قِبل الدكتور \"سيث جونز\"، نائب مدير مركز الدراسات الاستراتيجية والدولية، ومدير برنامج الأمن الدولي؛ لتوضيح بعض الحقائق عن الإرهاب المحلي في الولايات المتحدة الأمريكية. "
/// image : "http://idscapp.gov.eg/public/upload/reports/images/92/ReportImg.jpg"
/// sourceID : 57
/// sourceName : "مركز المعلومات ودعم اتخاذ القرار"
/// topicID : 1
/// topicName : "كوفيد-19"
/// categoryID : 39
/// categoryName : "إصدارات دولية"
/// attachment : "http://idscapp.gov.eg/public/upload/reports/attachment/92/ReportAttachment.pdf"
/// hashtags : ""

Reports reportsFromJson(String str) => Reports.fromJson(json.decode(str));
String reportsToJson(Reports data) => json.encode(data.toJson());
class Reports {
  Reports({
    int? id,
    String? createDate,
    String? title,
    String? description,
    String? image,
    int? sourceID,
    String? sourceName,
    int? topicID,
    String? topicName,
    int? categoryID,
    String? categoryName,
    String? attachment,
    String? hashtags,}){
    _id = id;
    _createDate = createDate;
    _title = title;
    _description = description;
    _image = image;
    _sourceID = sourceID;
    _sourceName = sourceName;
    _topicID = topicID;
    _topicName = topicName;
    _categoryID = categoryID;
    _categoryName = categoryName;
    _attachment = attachment;
    _hashtags = hashtags;
  }

  Reports.fromJson(dynamic json) {
    _id = json['id'];
    _createDate = json['createDate'];
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
    _sourceID = json['sourceID'];
    _sourceName = json['sourceName'];
    _topicID = json['topicID'];
    _topicName = json['topicName'];
    _categoryID = json['categoryID'];
    _categoryName = json['categoryName'];
    _attachment = json['attachment'];
    _hashtags = json['hashtags'];
  }
  int? _id;
  String? _createDate;
  String? _title;
  String? _description;
  String? _image;
  int? _sourceID;
  String? _sourceName;
  int? _topicID;
  String? _topicName;
  int? _categoryID;
  String? _categoryName;
  String? _attachment;
  String? _hashtags;

  int? get id => _id;
  String? get createDate => _createDate;
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  int? get sourceID => _sourceID;
  String? get sourceName => _sourceName;
  int? get topicID => _topicID;
  String? get topicName => _topicName;
  int? get categoryID => _categoryID;
  String? get categoryName => _categoryName;
  String? get attachment => _attachment;
  String? get hashtags => _hashtags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['createDate'] = _createDate;
    map['title'] = _title;
    map['description'] = _description;
    map['image'] = _image;
    map['sourceID'] = _sourceID;
    map['sourceName'] = _sourceName;
    map['topicID'] = _topicID;
    map['topicName'] = _topicName;
    map['categoryID'] = _categoryID;
    map['categoryName'] = _categoryName;
    map['attachment'] = _attachment;
    map['hashtags'] = _hashtags;
    return map;
  }

}