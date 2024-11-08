import 'dart:convert';

import 'package:dio/dio.dart';

class RequestInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest

    print(
        "\n================================= 请求数据 =================================");
    print("method = ${options.method.toString()}");
    print("url = ${options.uri.toString()}");
    print("headers = ${options.headers}");
    print("params = ${options.queryParameters}");
    print("params = ${options.data}");

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print(
        "\n================================= 响应数据开始 =================================");
    print("code = ${response.statusCode}");
    print("data = ${response.data}");
    print(
        "================================= 响应数据结束 =================================\n");

    super.onResponse(response, handler);
  }
}
