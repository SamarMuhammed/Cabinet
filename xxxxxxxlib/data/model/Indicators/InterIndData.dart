import 'dart:convert';

/// id : 272
/// name : "مؤشر الانفتاح الاقتصادي\r\n"
/// noOfCountries : 157
/// source : "UNCTAD"
/// currentRank : 102
/// previousRank : 107
/// changeRank : 5.000
/// attachmentURL : null
/// date : "2019"

InterIndData interIndDataFromJson(String str) => InterIndData.fromJson(json.decode(str));
String interIndDataToJson(InterIndData data) => json.encode(data.toJson());
class InterIndData {
  InterIndData({
      int? id, 
      String? name, 
      int? noOfCountries, 
      String? source,
    String? currentRank,
    String? previousRank,
    String? changeRank,
    bool? changeRankCheck,
      dynamic attachmentURL, 
      String? date,}){
    _id = id;
    _name = name;
    _noOfCountries = noOfCountries;
    _source = source;
    _currentRank = currentRank;
    _previousRank = previousRank;
    _changeRank = changeRank;
    _attachmentURL = attachmentURL;
    _date = date;
    _changeRankCheck= changeRankCheck;
}

  InterIndData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _noOfCountries = json['noOfCountries'];
    _source = json['source'];
    _currentRank = json['currentRank'];
    _previousRank = json['previousRank'];
    _changeRank = json['changeRank'];
    _attachmentURL = json['attachmentURL'];
    _changeRankCheck =  json['changeRankCheck'];
    _date = json['date'];
  }
  int? _id;
  String? _name;
  int? _noOfCountries;
  String? _source;
  String? _currentRank;
  String? _previousRank;
  String? _changeRank;
  dynamic _attachmentURL;
  String? _date;
  bool? _changeRankCheck;

InterIndData copyWith({  int? id,
  String? name,
  int? noOfCountries,
  String? source,
  String? currentRank,
  String? previousRank,
  String? changeRank,
  bool?changeRankCheck,
  dynamic attachmentURL,
  String? date,
}) => InterIndData(  id: id ?? _id,
  name: name ?? _name,
  noOfCountries: noOfCountries ?? _noOfCountries,
  source: source ?? _source,
  currentRank: currentRank ?? _currentRank,
  previousRank: previousRank ?? _previousRank,
  changeRank: changeRank ?? _changeRank,
  changeRankCheck:changeRankCheck ??_changeRankCheck,
  attachmentURL: attachmentURL ?? _attachmentURL,
  date: date ?? _date,
);
  int? get id => _id;
  String? get name => _name;
  int? get noOfCountries => _noOfCountries;
  String? get source => _source;
  String? get currentRank => _currentRank;
  String? get previousRank => _previousRank;
  String? get changeRank => _changeRank;
  dynamic get attachmentURL => _attachmentURL;
  String? get date => _date;
  bool? get changeRankCheck => _changeRankCheck;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['noOfCountries'] = _noOfCountries;
    map['source'] = _source;
    map['currentRank'] = _currentRank;
    map['previousRank'] = _previousRank;
    map['changeRank'] = _changeRank;
    map['attachmentURL'] = _attachmentURL;
    map['date'] = _date;
    map['changeRankCheck'] = _changeRankCheck;
    return map;
  }

}