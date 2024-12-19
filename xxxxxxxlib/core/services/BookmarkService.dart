import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/data/model/selectedCategories/SelectedData.dart';
import 'package:reidsc/data/model/selectedCategories/selectedCat.dart';

class BookmarkService{


  Future<List<SelectedCat>> getCategories()async{
    List<SelectedCat> list=[];
    try {
      Dio _dio = DioBaseService().getDio();
      // print(DioBaseService().BASE_URL);

      Response response = await _dio.get(
          DioBaseService().BASE_URL + "maincategories/selected/");

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
    }
    catch(e){
      print(e);
      return [];
    }
  }

  /////////getbookmark
  Future<List<SelectedData>> getBookmark({required  int mainCatID,required  String mainCatName,required  int userID} ) async{

    print("mainCategoryy=$mainCatID");
    print("mainCategoryy=$mainCatName");
    print("userID=$userID");

   // print("page=$page");


    var data= {"mainCatID":mainCatID,"mainCatName":mainCatName,"userID":userID};
    List<SelectedData> list=[];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response = await _dio.post(
          DioBaseService().BASE_URL + "bookmark/",data:data);

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      print(response.data['content']);
      for (Map m in response.data['content']) {

        SelectedData c = SelectedData.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    }
    catch(e){
      print(e);
      return [];
    }



    //  return result;
  }


  /////////searchbookmark
  Future<List<SelectedData>> searchBookmark({required  int mainCatID,required  String mainCatName,
    required  String searchItem,required  int userID} ) async{

    var data= {"mainCatID":mainCatID,"mainCatName":mainCatName,"searchItem":searchItem,"userID":userID};
    List<SelectedData> list=[];

    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);
      Response response = await _dio.post(
        DioBaseService().BASE_URL +'bookmark/search/',data: data,);

    print(response.data['content']);
    for (Map m in response.data['content']) {

      SelectedData c = SelectedData.fromJson(m);

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

}