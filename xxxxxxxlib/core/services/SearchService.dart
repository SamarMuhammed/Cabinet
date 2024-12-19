import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/data/model/news/NewsVM.dart';
import 'package:reidsc/data/model/selectedCategories/SelectedData.dart';
import 'package:reidsc/data/model/selectedCategories/selectedCat.dart';

class SearchService {
  Future<List<SelectedCat>> getCategories() async {
    List<SelectedCat> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response = await _dio
          .get(DioBaseService().BASE_URL + "maincategories/selected/");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      // print(response.data['content']);
      for (Map m in response.data['content']) {
        SelectedCat c = SelectedCat.fromJson(m);

        list.add(c);
        print(c.name);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }
  /////////adduser

  Future<List<NewsVM>> search(
      {required int page, required String searchItem}) async {
    print("namee=$searchItem");

    // print("mainCategoryy=$mainCatID");
    // print("mainCategoryy=$mainCatName");
    //print("selectedTopics=$selectedTopics");

    //print("userID=$userID");

    // print("page=$page");

    // var data= {"mainCatID":mainCatID,"mainCatName":mainCatName,"searchItem":searchItem,"selectedTopics":selectedTopics};
    List<NewsVM> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response = await _dio.get(DioBaseService().Cap_BASE_URL +
          "GetNews?pagenumber=" +
          page.toString() +
          "&pagesize=10&text=" +
          searchItem);

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      print(response.data);
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

    //  return result;
  }
}
