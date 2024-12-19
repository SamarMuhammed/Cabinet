import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'dart:convert';

import 'package:reidsc/data/model/Hierarchy/Minister.dart';
import 'package:reidsc/data/model/license/License.dart';

class LicenseService {
  Future<License?> getLicense() async {
    //  print("New topicID "+topicID);
    //  List<License> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      //   print(DioBaseService().BASE_URL);
      print("api");
      Response response =
          await _dio.get(DioBaseService().Cap_BASE_URL + "GetgoldenLicense");
      print(response);
      final Map parsed = json.decode(response.toString());

      print(parsed);
      final license = License.fromJson(parsed);

      // License c= response as License;
      print(license);

      return license;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
