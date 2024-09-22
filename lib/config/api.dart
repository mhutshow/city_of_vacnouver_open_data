import 'package:dio/dio.dart';

const baseUrl = "https://opendata.vancouver.ca/";

class Api {
  //creating a singleton dio instance for api calls
  final Dio dio = createDio();
  Api._internal();
  static final _singleton = Api._internal();
  factory Api() => _singleton;

  //Configuring the dio instance
  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      validateStatus: (status) {
        return status! < 500;
      },
      receiveTimeout: const Duration(seconds: 120),
      connectTimeout: const Duration(seconds: 120),
    ));
    return dio;
  }
}