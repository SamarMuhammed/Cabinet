/// id : 30077
/// createDate : "Apr 18 2022  5:04PM"
/// date : "منذ 26 يوم "
/// title : "أوراسيا ريفيو: أسباب تدعو لتفاؤل الأوكرانيين في الحرب"
/// description : "<p>سلَّط الكاتب \"بول جوبل\" الضوء على ستة أسباب رئيسة قد تؤدي إلى انتصار الأوكرانيين في معركتهم ضد روسيا، وذلك بالرغم من المزاعم التي تؤكد صعوبة هزيمة القوات الروسية.&nbsp;</p>\r\n<p>وفي هذا السياق، يرى الكاتب أن السبب الأول يكمن في دعم الغرب لأوكرانيا، فالأوكرانيون واثقون من أنهم لا يقاتلون بمفردهم، وأن لديهم حلفاء سيستمرون في مساعدتهم.</p>\r\n<p>ويتلخص السبب الثاني في العقوبات الاقتصادية الغربية المفروضة ضد روسيا، والتي من شأنها إجبار \"موسكو\" على تغيير مسارها، حيث تستهدف عزل نظام بوتين سياسيا ودبلوماسيا واقتصاديا؛ مما يحول دون استكمال طموحاته العدائية في أوروبا.&nbsp;</p>\r\n<p>وبالإضافة إلى ذلك، أشار الكاتب إلى أن السبب الثالث يرجع إلى قرار \"موسكو\" نقل قواتها بعيدًا عن \"كييف\"، وتوجيهها إلى إقليم \"دونباس\"، مما يعكس تراجع القوات الروسية على أرض الواقع.&nbsp;</p>\r\n<p>ويضيف المقال أن السبب الرابع يكمن في اعتقاد الأوكرانيين أن الغرب أصبح أكثر قبولًا من أي وقت مضى لمواجهة روسيا، وبالتالي، سيكون أكثر دعمًا لأوكرانيا.&nbsp;</p>\r\n<p>أما السبب الخامس فينطلق من إدراك الأوكرانيين لخطورة حرب المعلومات التي يتعرضون لها، والتي باتت تمثل شكلًا من أشكال الحروب الهجينة غير التقليدية.&nbsp;</p>\r\n<p>وأخيرًا، يتعلق السبب السادس باعتقاد الأوكرانيين بأنه كلما طالت مدة قتالهم، زادت احتمالية انضمامهم إلى الاتحاد الأوروبي.</p>\r\n<p>وختامًا، لفت المقال الانتباه إلى أن السبب الأخير يُعد كافيًا بالنسبة للعديد من الأوكرانيين، الذين يؤمنون بأهمية الاندماج مع الاتحاد الأوروبي وحلف \"الناتو\"، مما يمثل دافعًا قويًّا لاستمرار أوكرانيا في المقاومة، اعتقادًا منها بأن ذلك سيزيد من فرص قبول بروكسيل لعضويتها في كل من الاتحاد الأوروبي وحلف الناتو.&nbsp;</p>"
/// image : "https://bit.ly/3MgQ00Z"
/// sourceID : 524
/// sourceName : "أوراسيا ريفيو"
/// topicID : 1
/// topicName : "كوفيد-19"
/// link : "https://bit.ly/3MgQ00Z"
/// sourceLink : "https://bit.ly/3MgQ00Z"
/// comment : "<p><span style=\"font-weight: bold;\">&bull; يعتقد الأوكرانيون أنه كلما طالت مدة قتالهم، زادت احتمالية انضمامهم إلى الاتحاد الأوروبي.</span></p>\r\n<hr />\r\n<p><span style=\"font-weight: bold;\">&bull; يثق الأوكرانيون في أنهم لا يقاتلون بمفردهم وأن لديهم حلفاء سيستمرون في مساعدتهم.</span></p>\r\n<hr />\r\n<p><span style=\"font-weight: bold;\">&bull; القرار الروسي بنقل القوات الروسية بعيدًا عن \"كييف\"، وتوجيهها إلى إقليم \"دونباس\" يمثل تراجعًا للقوات الروسية.&nbsp;</span></p>"
/////hashtags:""
class News {
  News({
      int? id, 
      String? createDate, 
      String? date, 
      String? title, 
      String? description,
       String? image,
      int? sourceID, 
      String? sourceName, 
      int? topicID, 
      String? topicName, 
      String? link, 
      String? sourceLink, 
      String? comment,
    String? hashtags,
  }){
    _id = id;
    _createDate = createDate;
    _date = date;
    _title = title;
    _description = description;
    _image = image;
    _sourceID = sourceID;
    _sourceName = sourceName;
    _topicID = topicID;
    _topicName = topicName;
    _link = link;
    _sourceLink = sourceLink;
    _comment = comment;
    _hashtags=hashtags;
}

  News.fromJson(dynamic json) {
    _id = json['id'];
    _createDate = json['createDate'];
    _date = json['date'];
    _title = json['title'];
    _description = json['description'];
    _image = json['image'];
    _sourceID = json['sourceID'];
    _sourceName = json['sourceName'];
    _topicID = json['topicID'];
    _topicName = json['topicName'];
    _link = json['link'];
    _sourceLink = json['sourceLink'];
    _comment = json['comment'];
    _hashtags=json['hashtags'];
  }
  int? _id;
  String? _createDate;
  String? _date;
  String? _title;
  String? _description;
  String? _image;
  int? _sourceID;
  String? _sourceName;
  int? _topicID;
  String? _topicName;
  String? _link;
  String? _sourceLink;
  String? _comment;
  String? _hashtags;

  int? get id => _id;
  String? get createDate => _createDate;
  String? get date => _date;
  String? get title => _title;
  String? get description => _description;
  String? get image => _image;
  int? get sourceID => _sourceID;
  String? get sourceName => _sourceName;
  int? get topicID => _topicID;
  String? get topicName => _topicName;
  String? get link => _link;
  String? get sourceLink => _sourceLink;
  String? get comment => _comment;
  String? get hashtags => _hashtags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['createDate'] = _createDate;
    map['date'] = _date;
    map['title'] = _title;
    map['description'] = _description;
    map['image'] = _image;
    map['sourceID'] = _sourceID;
    map['sourceName'] = _sourceName;
    map['topicID'] = _topicID;
    map['topicName'] = _topicName;
    map['link'] = _link;
    map['sourceLink'] = _sourceLink;
    map['comment'] = _comment;
    map['hashtags']=_hashtags;
    return map;
  }

}