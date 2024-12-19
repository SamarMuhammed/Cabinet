import 'package:reidsc/data/model/cashMarkets/CashMarkets.dart';
import 'package:reidsc/data/model/cashMarkets/CashMarketsCat.dart';
import 'package:dio/dio.dart';

import 'DioBaseService.dart';

class CashService {
  Future<List<CashMarketsCat>> getMainCashCategories() async {
    List<CashMarketsCat> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "cashmarkets/cat/");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      // print(response.data['content']);
      for (Map m in response.data['content']) {
        CashMarketsCat c = CashMarketsCat.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<CashMarkets>> getCashSubCategories(int id) async {
    List<CashMarkets> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response = await _dio
          .get(DioBaseService().BASE_URL + "cashmarkets/ind/" + id.toString());

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      //  print(response.data['content']);
      for (Map m in response.data['content']) {
        CashMarkets c = CashMarkets.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<CashMarketsCat>> getCashMarketsCategories() async {
    List<CashMarketsCat> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "cashmarkets/cat/");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      //  print(response.data['content']);
      for (Map m in response.data['content']) {
        CashMarketsCat c = CashMarketsCat.fromJson(m);

        list.add(c);
        //   print(c);
      }

      return list;
    } catch (e) {
      //  print(e);
      return [];
    }
  }

  Future<List<CashMarkets>> getCashMarketsData(int id) async {
    List<CashMarkets> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response = await _dio
          .get(DioBaseService().BASE_URL + "cashmarkets/ind/" + id.toString());

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      //  print(response.data['content']);
      for (Map m in response.data['content']) {
        CashMarkets c = CashMarkets.fromJson(m);

        list.add(c);
        //   print(c);
      }

      return list;
    } catch (e) {
      //  print(e);
      return [];
    }
  }
}
