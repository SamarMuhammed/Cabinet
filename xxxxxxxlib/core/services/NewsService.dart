import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'dart:convert';

import 'package:reidsc/data/model/News.dart';
import 'package:reidsc/data/model/news/NewsVM.dart';

class NewsService {
  Future<List<NewsVM>> getNews({required int page}) async {
    //  print("New topicID "+topicID);
    List<NewsVM> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      //   print(DioBaseService().BASE_URL);
      print("api");
      Response response = await _dio.get(DioBaseService().Cap_BASE_URL +
          "GetNews?pagenumber=" +
          page.toString() +
          "&pagesize=10");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      print("response");
      print(response);

      //  print(response.data['content']);
      for (Map m in response.data) {
        NewsVM c = NewsVM.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<NewsVM>> getBookmarkedNews(
      {required String bookmarkedNews, required int page}) async {
    //var data= {"bookmarkedNews":bookmarkedNews,"page":page};

    //  print("New topicID "+topicID);
    List<NewsVM> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      //   print(DioBaseService().BASE_URL);
      print("api");
      print("bookmarkedNews" + bookmarkedNews.toString());
      Response response = await _dio.get(DioBaseService().Cap_BASE_URL +
          "GetNews?ids=" +
          bookmarkedNews +
          "&pagenumber=" +
          page.toString() +
          "&pagesize=10");
      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      print("response");
      print(response);

      //  print(response.data['content']);
      for (Map m in response.data) {
        NewsVM c = NewsVM.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<NewsVM?> getNewsByID({required int id}) async {
    NewsVM news;

    Dio _dio = DioBaseService().getDio();
    print(DioBaseService()..Cap_BASE_URL);

    Response response =
        await _dio.get(DioBaseService().Cap_BASE_URL + "GetNewsbyid/$id");

    // var json = jsonDecode(response.data.toString());
    //  print(json);
    //  var content = json['content'];
    //  print(content);

    // print(response.data);
    //news = NewsVM.fromJson(response.data);

    final Map parsed = json.decode(response.toString());

    news = NewsVM.fromJson(parsed);

    return news;
    //  for (Map m in response.data['content']) {

    //  News c = News.fromJson(m);

    //list.add(c);
    //print(c);
    //}

    return news;
  }
}
