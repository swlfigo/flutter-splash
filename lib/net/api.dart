import 'package:dio/dio.dart';
import 'package:splash/net/interceptors/header_interceptor.dart';
import './dao/dao_result.dart';
import './code.dart';

class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  final Dio _dio = Dio(); // 使用默认配置

  HttpManager() {
    //Header
    _dio.interceptors.add(HeaderInterceptors());
  }

  Future<DataResult?> netFetch(
      url, params, Map<String, dynamic>? header, Options? option) async {
    Map<String, dynamic> headers = Map();
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
      return DataResult(null, false);
    } catch (e) {
      return DataResult(null, false);
    }

    return DataResult(response.data, true);
  }
}

final HttpManager httpManager = HttpManager();
