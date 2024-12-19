import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'dart:convert';

import 'package:reidsc/data/model/News.dart';

class NewsService {
  Future<List<News>> getAllNews(
      {required String topicID, required int page}) async {
    var data = {"topicID": topicID, "page": page};
    //  print("New topicID "+topicID);
    List<News> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response =
          await _dio.post(DioBaseService().BASE_URL + "news/all/", data: data);

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      print(response.data['content']);
      for (Map m in response.data['content']) {
        News c = News.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

////////bookmark news///////////////////
  Future<dynamic> bookmarkNews(
      {required int userID, required int parentID}) async {
    var data = {"userID": userID, "parentID": parentID};
    //bool result=false;
    String result = "";
    try {
      DioBaseService dioService = DioBaseService();
      Response response = await dioService
          .getDio()
          .post(dioService.BASE_URL + 'news/bookmark/', data: data);
      // if(response.statusCode==200)
      return result = response.data['message'];
      print(response.data['message']);
    } on DioError catch (e) {
      print(e);
    }
    return result;
  }

  ////////////////check Bookmark//////////////
  Future<dynamic> checkBookmarkNews(
      {required int userID, required int parentID}) async {
    var data = {"userID": userID, "parentID": parentID};
    bool result = false;
    //bool result;
    try {
      DioBaseService dioService = DioBaseService();
      Response response = await dioService.getDio().post(
            dioService.BASE_URL + 'news/checkbookmark/',
            data: data,
          );
      print(response);
      // if(response.statusCode==200)
      return result = response.data['content'];
    } on DioError catch (e) {
      print(e);
    }
    return result;
  }

////////unbookmark news///////////////////
  Future<dynamic> unBookmarkNews(
      {required int userID, required int parentID}) async {
    var data = {"userID": userID, "parentID": parentID};
    //bool result=false;
    String result = "";
    try {
      DioBaseService dioService = DioBaseService();

      Response response = await dioService
          .getDio()
          .post(dioService.BASE_URL + 'news/unbookmark/', data: data);
      //if(response.statusCode==200)
      return result = response.data['message'];
      print(response.data['message']);
    } on DioError catch (e) {
      print(e);
    }
    return result;
  }
}
