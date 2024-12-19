import 'package:dio/dio.dart';
import 'package:reidsc/data/model/setting/Settings.dart';
import 'package:reidsc/core/services/DioBaseService.dart';

class SettingsService {
  Future<List<Settings>> getSettings() async {
    List<Settings> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "more/pages");

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
}
