import 'package:dio/dio.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/data/model/user/User.dart';
import 'package:reidsc/data/model/user/UserAge.dart';
import 'package:reidsc/data/model/user/UserGender.dart';
import 'package:reidsc/data/model/user/UserInterest.dart';
import 'package:reidsc/data/model/user/UserJob.dart';

class UserService {
  Future<List<UserAge>> getUserAge() async {
    List<UserAge> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "user/age");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);
      for (Map m in response.data['content']) {
        UserAge a = UserAge.fromJson(m);

        list.add(a);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  ///////////getusergender
  Future<List<UserGender>> getUserGender() async {
    List<UserGender> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "user/gender");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);
      for (Map m in response.data['content']) {
        UserGender g = UserGender.fromJson(m);

        list.add(g);
      }

      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

/////////////getuserjob
  Future<List<UserJob>> getUserJob() async {
    List<UserJob> list = [];
    try {
      Dio _dio = DioBaseService().getDio();
      print(DioBaseService().BASE_URL);

      Response response =
          await _dio.get(DioBaseService().BASE_URL + "user/job");

      // var json = jsonDecode(response.data.toString());
      //  print(json);
      //  var content = json['content'];
      //  print(content);
      for (Map m in response.data['content']) {
        UserJob j = UserJob.fromJson(m);

        list.add(j);
      }

      return list;
    } catch (e) {
      print(list);
      print(e);
      return [];
    }
  }

/////////////////////

  Future<Response> deleteUser(
      {required int userId, required String email}) async {
    Dio _dio = DioBaseService().getDio();

    Response response = await _dio
        .get(DioBaseService().BASE_URL + "user/delete/$userId/$email");

    return response;
  }
  ///////////getuserbuID

  Future<UserInterest> getUserById({required int userId}) async {
    UserInterest list = new UserInterest();
    // var data={"ID": id};

    Dio _dio = DioBaseService().getDio();
    // print(DioBaseService().BASE_URL);

    Response response =
        await _dio.get(DioBaseService().BASE_URL + "user/data/$userId");
    // print("fshjjfdjhdfjhdfhj");
    //   var json = jsonDecode(response.data.toString());
    //Map<String, dynamic> userdata = new Map<String, dynamic>.from(json.decode(response.data.toString()));

    // print(json);
    //var content = json['content'];

    //print(response.data['content']);
    //print(response.data['content'].toString());
    // print(response.data['content'].toString());
    Map m = response.data['content'];

    UserInterest c = UserInterest.fromJson(m);
    // for (Map m in response.data['content']) {
    //      print(response.data['content'].toString());
    //    Rep c = Rep.fromJson(m);

    // list.add(c);
    //  print(c);
    //print(c.name);
    //print(c.reports!.length);
//        print(response.data['content']['status']);

    // print(c.savedNews);

    //  }
    //print(list[0].name);

    return c;
  }
///////////////////////////////////////////

  Future<UserInterest?> getUserByDeviceId({required String deviceId}) async {
    UserInterest list = new UserInterest();
    // var data={"ID": id};

    Dio _dio = DioBaseService().getDio();
    // print(DioBaseService().BASE_URL);

    Response response = await _dio
        .get(DioBaseService().BASE_URL + "user/data/deviceId/$deviceId");
    // print("fshjjfdjhdfjhdfhj");
    //   var json = jsonDecode(response.data.toString());
    //Map<String, dynamic> userdata = new Map<String, dynamic>.from(json.decode(response.data.toString()));

    // print(json);
    //var content = json['content'];

    //print(response.data['content']);
    //print(response.data['content'].toString());
    print("DDDDDD" + response.data['content'].toString());

    // print("DDe"+m.isEmpty.toString());
    if (response.data['content'].toString() != "null") {
      Map m = response.data['content'];
      UserInterest c = UserInterest.fromJson(m);
      return c;
    } else
      return null;
    // for (Map m in response.data['content']) {
    //      print(response.data['content'].toString());
    //    Rep c = Rep.fromJson(m);

    // list.add(c);
    //  print(c);
    //print(c.name);
    //print(c.reports!.length);
//        print(response.data['content']['status']);

    //  }
    //print(list[0].name);
  }

  /////////adduser
  Future<Response> addUser(User u) async {
    DioBaseService dioService = DioBaseService();
    Response response = await dioService
        .getDio()
        .post(dioService.BASE_URL + 'user', data: u.toJson());

    return response;

    //  return result;
  }
}
