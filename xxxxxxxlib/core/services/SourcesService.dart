import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/data/model/setting/Source.dart';




class SourcesService{

  Future<List<Sources>> getSource()async{
    List<Sources> list=[];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response = await _dio.get(
          DioBaseService().BASE_URL + "more/impsources");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);
      for (Map m in response.data['content']) {

        Sources a = Sources.fromJson(m);

        list.add(a);

      }

      return list;
    }
    catch(e){
      print(e);
      return [];
    }
  }

}
