import 'package:dio/dio.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/data/model/Indicators/InterIndData.dart';
import 'package:reidsc/data/model/Indicators/InterIndicatorData.dart';
import 'DioBaseService.dart';

class InterIndService {
  Future<List<IndCategory>> getInterIndCategories(String selectedTopics) async {
    List<IndCategory> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response = await _dio.get(DioBaseService().BASE_URL +
          "indcategories/inter/topic?topicsId=" +
          selectedTopics);

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      //  print(response.data['content']);
      for (Map m in response.data['content']) {
        IndCategory c = IndCategory.fromJson(m);

        list.add(c);
        //   print(c);
      }

      return list;
    } catch (e) {
      //  print(e);
      return [];
    }
  }

  Future<List<InterIndicatorData>> getInterIndData(int id) async {
    List<InterIndicatorData> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response = await _dio.get(DioBaseService().BASE_URL +
          "indcategories/inter/subcat/" +
          id.toString());

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      //  print(response.data['content']);
      for (Map m in response.data['content']) {
        InterIndicatorData c = InterIndicatorData.fromJson(m);

        list.add(c);
        //   print(c);
      }

      return list;
    } catch (e) {
      //  print(e);
      return [];
    }
  }
}
