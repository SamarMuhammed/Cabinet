import 'package:dio/dio.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/data/model/Indicators/IndChartData.dart';
import 'package:reidsc/data/model/Indicators/LocalIndSubCategory.dart';

import 'DioBaseService.dart';

class LocalIndService {
  Future<List<IndCategory>> getMainIndCategories() async {
    List<IndCategory> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "indcategories/");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      // print(response.data['content']);
      for (Map m in response.data['content']) {
        IndCategory c = IndCategory.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<IndCategory>> getLocIndCategories(String topicIDs) async {
    List<IndCategory> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response = await _dio.get(DioBaseService().BASE_URL +
          "indcategories/local/topic?topicsId=" +
          topicIDs);

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      //  print(response.data['content']);
      for (Map m in response.data['content']) {
        IndCategory c = IndCategory.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<LocalIndSubCategory>> getLocIndSubCategories(int id) async {
    List<LocalIndSubCategory> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response = await _dio.get(DioBaseService().BASE_URL +
          "indcategories/local/subcat/" +
          id.toString());

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      //  print(response.data['content']);
      for (Map m in response.data['content']) {
        LocalIndSubCategory c = LocalIndSubCategory.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<IndChartData> getLocIndChartData(int subCatID) async {
    IndChartData data = IndChartData();
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response = await _dio.get(DioBaseService().BASE_URL +
          "indcategories/local/chart/" +
          subCatID.toString());

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      print("indcategories/local/chart/" + subCatID.toString());

      print(response.data['content']);
      Map m = response.data['content'];
      IndChartData c = IndChartData.fromJson(m);

      return c;
    } catch (e) {
      print("Error " + e.toString());
      return data;
    }
  }
}
