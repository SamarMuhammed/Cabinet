import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:reidsc/data/model/setting/Settings.dart';
import 'package:reidsc/core/services/DioBaseService.dart';

class SettingsService {
  Future<List<Settings>> getAppSettings() async {
    List<Settings> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().IBASE_URL);

      Response response =
      await _dio.get(DioBaseService().IBASE_URL + "more/getAppcontent");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);
      for (Map m in response.data['content']) {
        Settings a = Settings.fromJson(m);

        list.add(a);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }
  Future<List<Settings>> getSettings() async {
    List<Settings> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      Response response = await _dio.get(DioBaseService().Cap_BASE_URL + "getAppContent");

      // Print the raw response for debugging
      print('Raw Response: ${response.data}');

      // Check if the response is a List (already parsed JSON)
      if (response.data is List) {
        list = (response.data as List)
            .map((i) => Settings.fromJson(i))
            .toList();
      }
      // If the response is a String (already escaped JSON)
      else if (response.data is String) {
        try {
          // If response is a string, parse it as JSON
          var decodedData = json.decode(response.data);

          if (decodedData is List) {
            list = decodedData.map((i) => Settings.fromJson(i)).toList();
          } else if (decodedData is Map && decodedData['content'] != null) {
            list = (decodedData['content'] as List)
                .map((i) => Settings.fromJson(i))
                .toList();
          }
        } catch (e) {
          print("Error decoding JSON: $e");
          print("Response Data: ${response.data}");
        }
      }

      print('Parsed List: $list');
      return list;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }


}
