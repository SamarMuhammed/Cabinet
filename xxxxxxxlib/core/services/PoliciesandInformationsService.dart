import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/data/model/PoliciesAndInformations/GovYearlyReport.dart';
import 'package:reidsc/data/model/PoliciesAndInformations/GovernmentAgenda.dart';
import 'package:reidsc/data/model/PoliciesAndInformations/OwnerShipDocument.dart';
import 'package:reidsc/data/model/PoliciesAndInformations/Vision2030.dart';
import 'dart:convert';

class PoliciesandInformationsService {
  Future<Vision2030?> getVision() async {
    //  print("New topicID "+topicID);
    try {
      Dio _dio = DioBaseService().getDio();

      Response response =
          await _dio.get(DioBaseService().Cap_BASE_URL + "GetVision2030");
      print(response);
      final Map parsed = json.decode(response.toString());

      final vision = Vision2030.fromJson(parsed);

      return vision;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<GovernmentAgenda?> getGovAgenda() async {
    //  print("New topicID "+topicID);
    //  List<License> list = [];
    try {
      Dio _dio = DioBaseService().getDio();

      Response response = await _dio
          .get(DioBaseService().Cap_BASE_URL + "GetGovernmentProgram");
      //  print(response);
      final Map parsed = json.decode(response.toString());

      final agenda = GovernmentAgenda.fromJson(parsed);

      return agenda;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<GovYearlyReport?> getGovAnnualReport() async {
    //  print("New topicID "+topicID);
    //  List<License> list = [];
    try {
      Dio _dio = DioBaseService().getDio();

      Response response =
          await _dio.get(DioBaseService().Cap_BASE_URL + "GetGovernmentReport");
      //  print(response);
      final Map parsed = json.decode(response.toString());

      final report = GovYearlyReport.fromJson(parsed);

      return report;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<OwnerShipDocument?> getOwnershipDocument() async {
    //  print("New topicID "+topicID);
    //  List<License> list = [];
    try {
      Dio _dio = DioBaseService().getDio();

      Response response = await _dio
          .get(DioBaseService().Cap_BASE_URL + "GetOwnershipDocument");
      //  print(response);
      final Map parsed = json.decode(response.toString());

      final document = OwnerShipDocument.fromJson(parsed);

      return document;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
