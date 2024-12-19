import 'dart:convert';
/// id : 3
/// name : "The New York Times"
/// email : "nytnews@nytimes.com"
/// link : "https://www.nytimes.com/"

Sources sourceFromJson(String str) => Sources.fromJson(json.decode(str));
String sourceToJson(Sources data) => json.encode(data.toJson());
class Sources {
  Sources({
    int? id,
    String? name,
    String? email,
    String? link,}){
    _id = id;
    _name = name;
    _email = email;
    _link = link;
  }

  Sources.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _link = json['link'];
  }
  int? _id;
  String? _name;
  String? _email;
  String? _link;

  int? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get link => _link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['link'] = _link;
    return map;
  }

}