import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/data/model/Cabinet/Stackholder.dart';
import 'package:reidsc/data/model/Cabinet/FormerMinister.dart';

class CabinetService {
  Future<List<Stackholder>> getStakeholders(int page) async {
    //  print("New topicID "+topicID);
    List<Stackholder> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      //   print(DioBaseService().BASE_URL);
      print("api");
      Response response = await _dio.get(DioBaseService().Cap_BASE_URL +
          "GetStakeholder?pagenumber=" +
          page.toString() +
          "&pagesize=10");

      //  print(response.data['content']);
      for (Map m in response.data) {
        Stackholder c = Stackholder.fromJson(m);
        print(c);
        list.add(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<FormerMinister>> getFormerMinistries(int page) async {
    List<FormerMinister> list = [];

    try {
      Dio _dio = DioBaseService().getDio();
      Response response = await _dio.get(DioBaseService().Cap_BASE_URL +
          "GetMinistor?pagenumber=" +
          page.toString() +
          "&pagesize=10");

      //  print(response.data['content']);
      for (Map m in response.data) {
        FormerMinister c = FormerMinister.fromJson(m);

        list.add(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
