import 'dart:convert';
/// id : 30080
/// title : "رئيس الوزراء يستعرض مقترحات نظم الإدارة والتشغيل لمدينة الفنون والثقافة بالعاصمة الإدارية الجديدة"
/// image : "https://idscapp.gov.eg/public/upload/news/images/30080/NewsImg.jpg"
/// createDate : "Apr 18 2022  7:17PM"
/// hashtags : ""
/// route : ""

SelectedData selectedDataFromJson(String str) => SelectedData.fromJson(json.decode(str));
String selectedDateToJson(SelectedData data) => json.encode(data.toJson());
class SelectedData {
  SelectedData({
      int? id, 
      String? title, 
      String? image, 
      String? createDate, 
      String? hashtags, 
      String? route,}){
    _id = id;
    _title = title;
    _image = image;
    _createDate = createDate;
    _hashtags = hashtags;
    _route = route;
}

  SelectedData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _image = json['image'];
    _createDate = json['createDate'];
    _hashtags = json['hashtags'];
    _route = json['route'];
  }
  int? _id;
  String? _title;
  String? _image;
  String? _createDate;
  String? _hashtags;
  String? _route;
SelectedData copyWith({  int? id,
  String? title,
  String? image,
  String? createDate,
  String? hashtags,
  String? route,
}) => SelectedData(  id: id ?? _id,
  title: title ?? _title,
  image: image ?? _image,
  createDate: createDate ?? _createDate,
  hashtags: hashtags ?? _hashtags,
  route: route ?? _route,
);
  int? get id => _id;
  String? get title => _title;
  String? get image => _image;
  String? get createDate => _createDate;
  String? get hashtags => _hashtags;
  String? get route => _route;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image'] = _image;
    map['createDate'] = _createDate;
    map['hashtags'] = _hashtags;
    map['route'] = _route;
    return map;
  }

}