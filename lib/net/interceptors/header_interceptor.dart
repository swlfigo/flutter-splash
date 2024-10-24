import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HeaderInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, handler) async {
    ///超时
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 30);

    options.headers.addAll({
      "Content-Type": "application/json",
      "Authorization": "Client-ID ${dotenv.env["ClientID"]}"
    });

    return super.onRequest(options, handler);
  }
}
