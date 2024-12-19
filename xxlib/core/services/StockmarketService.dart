import 'package:dio/dio.dart';
import 'package:reidsc/data/model/Indicators/IndCategory.dart';
import 'package:reidsc/data/model/Indicators/IndChartData.dart';
import 'package:reidsc/data/model/Indicators/LocalIndSubCategory.dart';
import 'dart:async';
import 'DioBaseService.dart';

class StockmarketService {
  Future<List<IndCategory>> getCategories() async {
    List<IndCategory> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "stockmarket/cat/");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      // print(response.data['content']);
      for (Map m in response.data['content']) {
        IndCategory c = IndCategory.fromJson(m);

        list.add(c);
        print(c.name);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<IndCategory>> getSubCategories(int id) async {
    List<IndCategory> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response = await _dio.get(
          DioBaseService().BASE_URL + "stockmarket/subcat/" + id.toString());

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

  Future<IndChartData> getChartData(int indID, int duration) async {
    IndChartData data = IndChartData();
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response = await _dio.post(
          DioBaseService().BASE_URL + "stockmarket/chart/",
          data: {"IndID": indID, "Duration": duration});

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
