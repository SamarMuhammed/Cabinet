import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'dart:convert';

import 'package:reidsc/data/model/News.dart';
import 'package:reidsc/data/model/news/NewsVM.dart';


class LatestNewsService{

  Future<List<News>> getLatestNews({required String topics})async{
    List<News> list=[];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response = await _dio.get(
          DioBaseService().BASE_URL + "news/top/$topics");

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
    }
    catch(e){
      print(e);
      return [];
    }
  }
  Future<NewsVM?> getNewsByID({required int id})async{
    NewsVM news;

      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response = await _dio.get(
          DioBaseService().BASE_URL + "news/byid/$id");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      print(response.data['content']);
      news = NewsVM.fromJson(response.data['content']);
    //  for (Map m in response.data['content']) {

      //  News c = News.fromJson(m);

        //list.add(c);
        //print(c);
      //}

      return news;

  }





}