import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:splash/net/interceptors/header_interceptor.dart';
import 'package:splash/net/interceptors/request_interceptor.dart';
import './dao/dao_result.dart';
import './code.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  final Dio _dio = Dio(); // 使用默认配置

  HttpManager() {
    //Header
    _dio.interceptors.add(HeaderInterceptors());
    //For Debug
    // _dio.interceptors.add(RequestInterceptor());
    _dio.interceptors.add(CurlLoggerDioInterceptor());
  }

  Future<DataResult?> netFetch(
      url, params, Map<String, dynamic>? header, Options? option) async {
    Map<String, dynamic> headers = {};
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: "get");
      option.headers = headers;
    }

    Response response;
    try {
      if (option.method == "get") {
        response =
            await _dio.request(url, options: option, queryParameters: params);
      } else {
        response = await _dio.request(url, data: params, options: option);
      }
      // response = await _dio.get(url, queryParameters: params);
    } on DioException catch (e) {
      print("Dio Exception:${e.response ?? e}");
      return DataResult(null, false, e);
    } catch (e) {
      print(" Exception:$e");
      return DataResult(null, false, e);
    }

    return DataResult(response.data, true, null);
  }
}

final HttpManager httpManager = HttpManager();
