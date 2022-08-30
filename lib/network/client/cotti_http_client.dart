import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../composer/cotti_composer.dart';
import '../interceptor/http_log_interceptor.dart';
import '../interceptor/signature_interceptor.dart';
import '../interface/network_config.dart';

/// Description:
/// Author: xingguo.lei@abite.com
/// Date: 2022/8/25 4:57 下午
abstract class CottiHttpClient {
  late Dio _dio;

  CottiHttpClient() {
    BaseOptions options = BaseOptions(
      baseUrl: networkConfig.baseUrl ?? '',
      connectTimeout: networkConfig.connectTimeout,
      receiveTimeout: networkConfig.receiveTimeout,
      sendTimeout: networkConfig.sendTimeout,
    );
    _dio = Dio();
    _dio.options = options;
    _dio.interceptors.add(SignatureInterceptor(networkConfig));
    if (networkConfig.logger) {
      _dio.interceptors.add(HttpLogInterceptor());
    }
    _dio.interceptors.addAll(interceptors);
  }

  Dio get dio {
    return _dio;
  }

  @protected
  List<Interceptor> get interceptors;

  @protected
  NetWorkConfig get networkConfig;

  Future<T> get<T>(
    String path, {
    bool showToast = true,
    Map<String, dynamic>? queryParameters,
  }) {
    return CottiComposer.composer(_dio.get(path, queryParameters: queryParameters), showToast);
  }

  Future<T> post<T>(
    String path, {
    bool showToast = true,
    data,
    Map<String, dynamic>? queryParameters,
  }) {
    return CottiComposer.composer(
        _dio.post(path, data: data, queryParameters: queryParameters), showToast);
  }
}
