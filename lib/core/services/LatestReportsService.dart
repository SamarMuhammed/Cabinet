import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'dart:convert';

import 'package:reidsc/data/model/AllReports.dart';

class LatestReportsService {
/*
  Future<List<Reports>> getLatestReports()async{
    List<Reports> list=[];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response = await _dio.get(
          DioBaseService().BASE_URL + "reports/latest");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      print(response.data['content']);
      for (Map m in response.data['content']) {

        Reports c = Reports.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    }
    catch(e){
      print(e);
      return [];
    }
  }*/

  Future<List<Reports>> getLatestReports({required String topics}) async {
    List<Reports> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "reports/latest/$topics");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      print(response.data['content']);
      for (Map m in response.data['content']) {
        Reports c = Reports.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
