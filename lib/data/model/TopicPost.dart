import 'dart:convert';
/// userID : 50
/// topicsIds : "1,2,3"

TopicPost topicPostFromJson(String str) => TopicPost.fromJson(json.decode(str));
String topicPostToJson(TopicPost data) => json.encode(data.toJson());
class TopicPost {
  TopicPost({
      int? userID, 
      String? topicsIds,

  }){
    _userID = userID;
    _topicsIds = topicsIds;

}

  TopicPost.fromJson(dynamic json) {
    _userID = json['userID'];
    _topicsIds = json['topicsIds'];


  }
  int? _userID;
  String? _topicsIds;

  int? get userID => _userID;
  String? get topicsIds => _topicsIds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userID'] = _userID;
    map['topicsIds'] = _topicsIds;


    return map;
  }

}