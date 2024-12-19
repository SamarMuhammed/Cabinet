import 'package:dio/dio.dart';
import 'package:reidsc/data/model/media/Media.dart';
import 'package:reidsc/data/model/media/MediaCategory.dart';

import 'DioBaseService.dart';

class MediaService {
  Future<List<MediaCategory>> getMainMediaCategories() async {
    List<MediaCategory> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "media/cat");

      for (Map m in response.data['content']) {
        print(response.data['content']);

        MediaCategory c = MediaCategory.fromJson(m);
        print(m);
        print(response.data['content']);

        list.add(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Media>> getAllMedia(
      {required String topicID, required int catID, required int page}) async {
    var data = {"topicID": topicID, "catID": catID, "page": page};
    List<Media> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response = await _dio
          .post(DioBaseService().BASE_URL + "media/media/", data: data);

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);

      print(response.data['content']);
      for (Map m in response.data['content']) {
        Media c = Media.fromJson(m);

        list.add(c);
        print(c);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Media?> getMediaByID(int id) async {
    Media media;
    try {
      Dio _dio = DioBaseService().getDio();

      Response response = await _dio
          .get(DioBaseService().BASE_URL + "media/byid/" + id.toString());

      media = Media.fromJson(response.data['content']);
      print(response.data['content']);
      return media;
    } catch (e) {
      print(e);
      return null;
    }
  }

////////bookmark news///////////////////
  Future<dynamic> bookmarkMedia(
      {required int userID, required int parentID}) async {
    var data = {"userID": userID, "parentID": parentID};
    //bool result=false;
    String result = "";
    try {
      DioBaseService dioService = DioBaseService();
      Response response = await dioService
          .getDio()
          .post(dioService.BASE_URL + 'media/bookmark/', data: data);
      if (response.statusCode == 200) return result = response.data['message'];
      print(response.data['message']);
    } on DioError catch (e) {
      print(e);
    }
    return result;
  }

////////unbookmark news///////////////////
  Future<dynamic> unBookmarkMedia(
      {required int userID, required int parentID}) async {
    var data = {"userID": userID, "parentID": parentID};
    //bool result=false;
    String result = "";
    try {
      DioBaseService dioService = DioBaseService();
      Response response = await dioService
          .getDio()
          .post(dioService.BASE_URL + 'media/unbookmark/', data: data);
      if (response.statusCode == 200) return result = response.data['message'];
      print(response.data['message']);
    } on DioError catch (e) {
      print(e);
    }
    return result;
  }
}
