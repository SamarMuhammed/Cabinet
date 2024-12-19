import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'dart:convert';

import 'package:reidsc/data/model/Hierarchy/Minister.dart';

class HierarchyService {
  Future<List<Minister>> getMinisters(int page) async {
    //  print("New topicID "+topicID);
    List<Minister> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      //   print(DioBaseService().BASE_URL);
      print("api");
      Response response = await _dio.get(DioBaseService().Cap_BASE_URL +
          "GetHierarchy?pagenumber=" +
          page.toString() +
          "&pagesize=10");

      //  print(response.data['content']);
      for (Map m in response.data) {
        Minister c = Minister.fromJson(m);

        list.add(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Minister?> getMinisterID(int id) async {
    Minister minister;
    try {
      Dio _dio = DioBaseService().getDio();
      print("IIIIIIIIIIID" + id.toString());
      Response response = await _dio.get(DioBaseService().Cap_BASE_URL +
          "GetHierarchyProfile/" +
          id.toString());

      minister = Minister.fromJson(response.data);
      print(response.data);
      return minister;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
