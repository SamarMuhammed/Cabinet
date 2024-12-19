import 'package:dio/dio.dart';

class DioBaseService{
  static final DioBaseService _instance = DioBaseService._internal();
  final Dio _dio= Dio();
  //final String BASE_URL="http://new.idscapp.gov.eg/api/";
  final String BASE_URL="http://41.128.217.181/api/";
  final String Cap_BASE_URL="http://cabinet.gov.eg/CabApp/";
  final String Cap_Upload_URL="http://cabinet.gov.eg";

  factory DioBaseService(){
    return _instance;
  }

  Dio getDio(){

    _dio.options.baseUrl=BASE_URL;
    return _dio;
  }

  String getBaseURL(){
    return BASE_URL;
  }

  String getCapBaseURL(){
    return Cap_BASE_URL;
  }
  DioBaseService._internal();
}


class SingleTone{

  SingleTone();
}

