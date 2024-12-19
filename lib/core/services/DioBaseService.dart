import 'package:dio/dio.dart';

class DioBaseService{
  static final DioBaseService _instance = DioBaseService._internal();
  final Dio _dio= Dio();

  final String BASE_URL="http://new.idscapp.gov.eg/en/api/";
  final String IBASE_URL="http://new.idscapp.gov.eg/api/";

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
  String getIBaseURL(){
    return IBASE_URL;
  }
  DioBaseService._internal();
}


class SingleTone{

  SingleTone();
}

