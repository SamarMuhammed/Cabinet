
import 'package:dio/dio.dart';
import 'package:reidsc/data/model/Notifications/Notification.dart';

import 'DioBaseService.dart';

class NotificationService{

  Future<List<IDSCNotification>> getNotifications()async{
    List<IDSCNotification> list=[];
    try {
      Dio _dio = DioBaseService().getDio();
       //print(DioBaseService().BASE_URL);

      Response response = await _dio.get(
          DioBaseService().BASE_URL + "notification/latest");

      for (Map m in response.data['content']) {
     //   print(response.data['content']);

        IDSCNotification c = IDSCNotification.fromJson(m);
     //   print(m);
       // print(response.data['content']);

        list.add(c);
      }

      return list;
    }
    catch(e){
      print(e);
      return [];
    }
  }




}