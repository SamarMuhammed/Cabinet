import 'dart:convert';
/// id : 1
/// email : "test@test.com"
/// savedTopics : "1,2,3,4,5"
/// savedMedia : "1217,1220,1217"
/// savedNews : "29615,29612,29596,29587,1,3,30081,50081,5,30080,30080,30080,30080,30080,30080,30080,50081,30080,30080,30078,30076,30080,30076,30080,30080,1220,30079,30080"
/// savedReports : "1217,1220,1217"

UserInterest userInterestFromJson(String str) => UserInterest.fromJson(json.decode(str));
String userInterestToJson(UserInterest data) => json.encode(data.toJson());
class UserInterest {
  UserInterest({
      int? id, 
      String? email, 
      String? savedTopics, 
      String? savedMedia, 
      String? savedNews, 
      String? savedReports,}){
    _id = id;
    _email = email;
    _savedTopics = savedTopics;
    _savedMedia = savedMedia;
    _savedNews = savedNews;
    _savedReports = savedReports;
}

  UserInterest.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _savedTopics = json['savedTopics'];
    _savedMedia = json['savedMedia'];
    _savedNews = json['savedNews'];
    _savedReports = json['savedReports'];
  }
  int? _id;
  String? _email;
  String? _savedTopics;
  String? _savedMedia;
  String? _savedNews;
  String? _savedReports;
UserInterest copyWith({  int? id,
  String? email,
  String? savedTopics,
  String? savedMedia,
  String? savedNews,
  String? savedReports,
}) => UserInterest(  id: id ?? _id,
  email: email ?? _email,
  savedTopics: savedTopics ?? _savedTopics,
  savedMedia: savedMedia ?? _savedMedia,
  savedNews: savedNews ?? _savedNews,
  savedReports: savedReports ?? _savedReports,
);
  int? get id => _id;
  String? get email => _email;
  String? get savedTopics => _savedTopics;
  String? get savedMedia => _savedMedia;
  String? get savedNews => _savedNews;
  String? get savedReports => _savedReports;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['savedTopics'] = _savedTopics;
    map['savedMedia'] = _savedMedia;
    map['savedNews'] = _savedNews;
    map['savedReports'] = _savedReports;
    return map;
  }

}