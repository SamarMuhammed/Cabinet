import 'dart:convert';

/// genderID : 1
/// ageID : 2
/// jobID : 1
/// name : "test"
/// email : "Test@test.com"
User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
    int? genderID,
    int? ageID,
    int? jobID,
    String? name,
    String? deviceId,
    String? email,}){
    _genderID = genderID;
    _ageID = ageID;
    _jobID = jobID;
    _name = name;
    _email = email;
    _deviceId = deviceId;
  }

  User.fromJson(dynamic json) {
    _genderID = json['genderID'];
    _ageID = json['ageID'];
    _jobID = json['jobID'];
    _name = json['name'];
    _email = json['email'];
    _deviceId = json['deviceId'];
  }
  int? _genderID;
  int? _ageID;
  int? _jobID;
  String? _name;
  String? _email;
  String? _deviceId;

  int? get genderID => _genderID;
  int? get ageID => _ageID;
  int? get jobID => _jobID;
  String? get name => _name;
  String? get email => _email;
  String? get deviceId => _deviceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['genderID'] = _genderID;
    map['ageID'] = _ageID;
    map['jobID'] = _jobID;
    map['name'] = _name;
    map['email'] = _email;
    map['deviceId'] = _deviceId;
    return map;
  }

}