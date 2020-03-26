import 'dart:io';
import 'package:dio/dio.dart';

/// http 工具类
class HttpUtils {
  /// global dio instance
  static Dio dio;

  /// default options
  static const String API_PREFIX = 'http://192.168.0.111:7001';
  static const String FILE_UPLOAD_URL = "/upload";
  static const int CONNECT_TIMEOUT = 15000;
  static const int RECEIVE_TIMEOUT = 5000;

  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  /// 上传文件
  static Future<dynamic> uploadFile({data, callback}) async {
    var result;
    data = data ?? {};
    callback = callback ?? {};

    var dio = getInstance();
    var optionsParams = new Options(method: 'POST');

    try {
      Response response = await dio.request(FILE_UPLOAD_URL,
          data: data, options: optionsParams, onSendProgress: callback);
      result = response.data;
    } on DioError catch (e) {
      throw e;
    }

    return result;
  }

  /// 基于dio封装的http请求
  static Future<dynamic> request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';

    Dio dio = getInstance();
    var result;
    var optionsParams = new Options(method: method);

    try {
      Response response =
          await dio.request(url, data: data, options: optionsParams);
      result = response.data;
    } on DioError catch (e) {
      /// 打印请求失败相关信息
      print('请求出错：' + e.toString());
    }

    return result;
  }

  /// 创建 dio 实例对象
  static Dio getInstance() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      BaseOptions option = new BaseOptions(
          baseUrl: API_PREFIX,
          connectTimeout: CONNECT_TIMEOUT,
          receiveTimeout: RECEIVE_TIMEOUT,
          headers: {'Content-Type': 'application/json'},
          contentType: ContentType.json.toString(),
          responseType: ResponseType.plain);

      dio = new Dio(option);
    }

    return dio;
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }

  void test(int a, int b) {
    print(a);
    print(b);
  }
}
