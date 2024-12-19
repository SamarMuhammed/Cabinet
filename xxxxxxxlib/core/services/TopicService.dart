import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'dart:convert';

import 'package:reidsc/data/model/Topic.dart';
import 'package:reidsc/data/model/TopicPost.dart';


class TopicService{

  Future<List<Topic>> getTopics()async{
    List<Topic> list=[];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response = await _dio.get(
          DioBaseService().BASE_URL + "topics/");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      print(response.data['content']);
      for (Map m in response.data['content']) {

        Topic c = Topic.fromJson(m);

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

  Future<List<Topic>> getSavedTopics(id)async{
    print("hi$id");
    List<Topic> list=[];
    try {
      Dio _dio = DioBaseService().getDio();
     // print(DioBaseService().BASE_URL);

      Response response = await _dio.get(
          DioBaseService().BASE_URL + "topics/savedtopics/$id");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);
print("LOOP");
    //  print("Saved Topics "+response.data['content']);
      for (Map m in response.data['content']) {

        Topic c = Topic.fromJson(m);

print(c.name);
        list.add(c);
    //    print(c);
      }

      return list;
    }
    catch(e){
      print("errrror "+e.toString());
      return [];
    }
  }

//////////////post topic
  Future<bool> addUserTopic(TopicPost t) async{

    bool result=true;

    try{
      DioBaseService dioService= DioBaseService();
      Response response =await dioService.getDio().post(dioService.BASE_URL+'topics/save',data:t.toJson());

      if(response.statusCode==201)
        return true;
    } on DioError catch(e){

      print(e);
    }


    return result;
  }


}