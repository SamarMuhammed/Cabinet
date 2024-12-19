import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/data/model/AllReports.dart';
import 'package:reidsc/data/model/prices/PriceDataChart.dart';
import 'dart:convert';

import 'package:reidsc/data/model/prices/PricesCategory.dart';
import 'package:reidsc/data/model/prices/PricesDataall.dart';
import 'package:reidsc/data/model/prices/globalPriceChartData.dart';

class PricesService {
  Future<List<PricesCategory>> getMainPricesCategories() async {
    List<PricesCategory> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "prices/cat");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      // print(response.data['content']);
      for (Map m in response.data['content']) {
        PricesCategory c = PricesCategory.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

/////////////////////////get latest prices///////////////////////////
  Future<List<PricesDataall>> getLatestPrices() async {
    List<PricesDataall> list = [];
    //  var data={"topicID": topicID,"page": page};
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "prices/latest");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      print(response.data['content'].toString());

      for (Map m in response.data['content']) {
        PricesDataall c = PricesDataall.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

//////////////////////////get local prices///////////////////////////
  Future<List<PricesDataall>> getLocalPrices({required int id}) async {
    List<PricesDataall> list = [];
    //  var data={"topicID": topicID,"page": page};
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "prices/local/data/$id");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      print(response.data['content'].toString());

      for (Map m in response.data['content']) {
        PricesDataall c = PricesDataall.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  /////////////////////////get global prices///////////////////////////
  Future<List<PricesDataall>> getGlobalPrices({required int id}) async {
    List<PricesDataall> list = [];
    //  var data={"topicID": topicID,"page": page};
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "prices/global/data/$id");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      print(response.data['content'].toString());

      for (Map m in response.data['content']) {
        PricesDataall c = PricesDataall.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }
///////////////local charts///////////////////////////

  Future<PriceDataChart> getChartData(int subID, int duration) async {
    PriceDataChart data = PriceDataChart();
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response = await _dio.post(
          DioBaseService().BASE_URL + "prices/local/chart/",
          data: {"id": subID, "Duration": duration});

      print(response.data['content']);
      Map m = response.data['content'];
      PriceDataChart c = PriceDataChart.fromJson(m);

      return c;
    } catch (e) {
      print("ChartError " + e.toString());
      return data;
    }
  }

  Future<GlobalPriceChartData> getglobalChartData(
      int subID, int duration) async {
    GlobalPriceChartData data = GlobalPriceChartData();
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response = await _dio.post(
          DioBaseService().BASE_URL + "prices/global/chart/",
          data: {"id": subID, "Duration": duration});

      print(response.data['content']);
      Map m = response.data['content'];
      GlobalPriceChartData c = GlobalPriceChartData.fromJson(m);

      return c;
    } catch (e) {
      print("ChartError " + e.toString());
      return data;
    }
  }
}
