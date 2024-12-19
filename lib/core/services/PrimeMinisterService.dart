import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'dart:convert';
import 'package:reidsc/data/model/primeMinister/Biography.dart';
import 'package:reidsc/data/model/primeMinister/Task.dart';
import 'package:reidsc/data/model/primeMinister/Appointment.dart';

class PrimeMinisterService {
  Future<Biography?> getBiography() async {
    //  print("New topicID "+topicID);
    //  List<License> list = [];
    try {
      Dio _dio = DioBaseService().getDio();

      Response response =
          await _dio.get(DioBaseService().Cap_BASE_URL + "GetResume");
      print(response);
      final Map parsed = json.decode(response.toString());

      final bio = Biography.fromJson(parsed);

      return bio;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Task?> getTasks() async {
    //  print("New topicID "+topicID);
    //  List<License> list = [];
    try {
      Dio _dio = DioBaseService().getDio();

      Response response =
          await _dio.get(DioBaseService().Cap_BASE_URL + "GetTasks");
      //  print(response);
      final Map parsed = json.decode(response.toString());

      final task = Task.fromJson(parsed);

      return task;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Appointment>> getAppointments(int page) async {
    //  print("New topicID "+topicID);
    List<Appointment> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      //   print(DioBaseService().BASE_URL);
      print("api");
      Response response = await _dio.get(DioBaseService().Cap_BASE_URL +
          "GetAppointment?pagenumber=" +
          page.toString() +
          "&pagesize=10");

      //  print(response.data['content']);
      for (Map m in response.data) {
        Appointment c = Appointment.fromJson(m);

        list.add(c);
        //  print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
