import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:reidsc/data/model/setting/Settings.dart';
import 'package:reidsc/core/services/DioBaseService.dart';

class SettingsService {
  Future<List<Settings>> getSettings() async {
    List<Settings> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().Cap_BASE_URL + "getAppContent");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      print(json.decode(response.toString()));
      list = (json.decode(response.data) as List)
          .map((i) => Settings.fromJson(i))
          .toList();

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
