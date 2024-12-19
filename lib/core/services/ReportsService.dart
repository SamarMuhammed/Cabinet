import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/data/model/AllReports.dart';
import 'dart:convert';

class ReportsService {
  Future<AllReports> getChainDet({required int id}) async {
    AllReports list = new AllReports();
    // var data={"ID": id};

    Dio _dio = DioBaseService().getDio();
    // print(DioBaseService().BASE_URL);

    Response response =
        await _dio.get(DioBaseService().BASE_URL + "reports/cat/$id");
    // print("fshjjfdjhdfjhdfhj");
    //   var json = jsonDecode(response.data.toString());
    //Map<String, dynamic> userdata = new Map<String, dynamic>.from(json.decode(response.data.toString()));

    // print(json);
    //var content = json['content'];

    //print(response.data['content']);
    //print(response.data['content'].toString());
    // print(response.data['content'].toString());
    Map m = response.data['content'];

    AllReports c = AllReports.fromJson(m);
    // for (Map m in response.data['content']) {
    //      print(response.data['content'].toString());
    //    Rep c = Rep.fromJson(m);

    // list.add(c);
    //  print(c);
    //print(c.name);
    //print(c.reports!.length);
//        print(response.data['content']['status']);

    // print(list);

    //  }
    //print(list[0].name);

    return c;
  }

//////////////////////////Reports Grid List
  Future<List<Reports>> getAllReports(
      {required String topicID, required int page}) async {
    List<Reports> list = [];
    var data = {"topicID": topicID, "page": page};
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response = await _dio
          .post(DioBaseService().BASE_URL + "reports/all/", data: data);

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      print(response.data['content'].toString());

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

///////////////POST
////////bookmark news///////////////////
  Future<dynamic> bookmarkReports(
      {required int userID, required int parentID}) async {
    var data = {"userID": userID, "parentID": parentID};
    //bool result=false;
    String result = "";
    try {
      DioBaseService dioService = DioBaseService();
      Response response = await dioService
          .getDio()
          .post(dioService.BASE_URL + 'reports/bookmark/', data: data);
      if (response.statusCode == 200) return result = response.data['message'];
      print(response.data['message']);
    } on DioError catch (e) {
      print(e);
    }
    return result;
  }

  ////////////////////////////// By ID ///////////////////////////////////////////////

  Future<Reports?> getReportByID(int id) async {
    Reports report;

    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response = await _dio
          .get(DioBaseService().BASE_URL + "reports/byid/" + id.toString());

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      print(response.data['content'].toString());

      report = Reports.fromJson(response.data['content']);

      return report;
    } catch (e) {
      print(e);
      return null;
    }
  }

  ////////////////check Bookmark//////////////
  Future<dynamic> checkBookmarkNews(
      {required int userID, required int parentID}) async {
    var data = {"userID": userID, "parentID": parentID};
    bool result = false;
    //bool result;
    try {
      DioBaseService dioService = DioBaseService();
      Response response = await dioService
          .getDio()
          .post(dioService.BASE_URL + 'reports/checkbookmark/', data: data);
      print(response);
      if (response.statusCode == 200) return result = response.data['content'];
    } on DioError catch (e) {
      print(e);
    }

    return result;
  }

  ////////////////////////////////unbookmark news//////////////////////////
  Future<dynamic> unBookmarkReports(
      {required int userID, required int parentID}) async {
    var data = {"userID": userID, "parentID": parentID};
    //bool result=false;
    String result = "";
    try {
      DioBaseService dioService = DioBaseService();
      Response response = await dioService
          .getDio()
          .post(dioService.BASE_URL + 'reports/unbookmark/', data: data);
      if (response.statusCode == 200) return result = response.data['message'];
      print(response.data['message']);
    } on DioError catch (e) {
      print(e);
    }
    return result;
  }
}
