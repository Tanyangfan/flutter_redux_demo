import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_redux_demo/data/beans/restful_response.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

/// 请求拦截器 >> 请求转换器 >> 发起请求 >> 响应转换器 >> 响应拦截器 >> 最终结果
class DemoTransformer extends DefaultTransformer {
  @override
  Future<String> transformRequest(Options options) {
    return super.transformRequest(options);
  }

  @override
  Future transformResponse(Options options, HttpClientResponse response) {
    return super.transformResponse(options, response);
  }
}

class DemoService {
  static final DemoService _singleton = new DemoService._internal();

  factory DemoService() {
    return _singleton;
  }

  Dio _dio;
  Logger _logger;

  DemoService._internal() {
    _logger = Logger(
      "demo service",
    );
    _dio = _createDio();
  }

  Dio _createDio() {
    _logger.log(Level.INFO, 'create _createDio');

    Options options = new Options(
      baseUrl: "http://api.mushi.tech",
      receiveTimeout: 20000,
      responseType: ResponseType.PLAIN,
    );

    Dio dio = new Dio(options);
    getApplicationDocumentsDirectory().then((dir) {
      dio.cookieJar = new PersistCookieJar(dir.path + "/cookies");
    });

    dio.interceptor.request.onSend = (Options options) {
//      _logger.log(Level.INFO, 'create _createDio');
      print('=== Request method = ${options.method} ===');
      print('Url = ${options.baseUrl}${options.path}');
      print('Header = ${options.headers}');
      print('Data = ${options.data}');
      print('=== Request end ===');
      return options;
    };

    dio.interceptor.response.onSuccess = (Response response) async {
      print('=== Response method = ${response.request.method} ===');
      print('Url = ${response.request.baseUrl}${response.request.path}');
      print('Header = ${response.headers}');
      print('StatusCode = ${response.statusCode}');
      return _parseResponse(response).then((response) {
        print('Data = ${response.data.toString()}');
        print('=== Response end ===');

        if (response.statusCode == -1) {
          return new DioError();
        }

        return response;
      }).catchError((e) {
        print('_parseResponse error = ${e.toString()}');
        print('=== Response end ===');
        return response;
      });
    };

    dio.interceptor.response.onError = (DioError e) {
      print('=== Request error ===');
      if (e.response != null) {
        print('Method = ${e.response.request.method}');
        print('Url = ${e.response.request.baseUrl}${e.response.request.path}');
        print('Header = ${e.response.headers}');
        print('StatusCode = ${e.response.statusCode}');
      }
      print('Error = ${e.toString()}');

      print('=== Request error end ===');

      if (e.message.contains('SocketException')) {
        print('网络连接错误！');
      }

      return e;
    };

    dio.transformer = new DemoTransformer();

    return dio;
  }

  Future<Response> _parseResponse(Response response) async {
    try {
      response.data = RestfulResponse.fromJson(json.decode(response.data));
    } catch (e) {
      print('_parseResponse exception = ${e.toString()}');
    }

    return response;
  }

  Future<RestfulResponse> fetchPoem() async {
    var response = await _dio.get('/ts/randomPoem');
    return response.data;
  }
}
