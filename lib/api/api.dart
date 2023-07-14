
import 'package:dio/dio.dart';

class Api {
  late final dio = Dio(options)..interceptors.addAll([_BasicInterceptor()]);
  final options = BaseOptions(
    baseUrl: 'https://api.polygon.io/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 5),
  );
}

class _BasicInterceptor implements Interceptor {

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler)async {
    options.headers = {
      "Accept": "application/json",
      "Authorization" :"Bearer 2_62JlSxNWLgNeJeQ71GfpM57ibnuwvT"
    };

    handler.next(options);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}