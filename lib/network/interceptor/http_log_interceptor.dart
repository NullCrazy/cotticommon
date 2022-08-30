import 'package:dio/dio.dart';

import '../../utils/log_util.dart';

/// Description:
/// Author: xingguo.lei@abite.com
/// Date: 2022/8/26 11:18 上午
class HttpLogInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      Map<String, dynamic> responseLog = {'Request': _requestMessage(response.requestOptions)};
      responseLog.addAll({'Response': response.data});
      logI(responseLog);
    } finally {
      handler.next(response);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    try {
      Map<String, dynamic> errLog = {'Request': _requestMessage(err.requestOptions)};
      errLog.addAll({'Error': err});
      logE(errLog);
    } finally {
      handler.next(err);
    }
  }

  Map<String, dynamic> _requestMessage(RequestOptions options) {
    Map<String, dynamic> requestInfo = {
      'method': options.method,
      'api_url': options.baseUrl + options.path,
      'sign': options.headers['sign'],
    };
    if (options.method == 'POST') {
      requestInfo.addAll({'params': options.data});
    }
    if (options.method == 'GET') {
      requestInfo.addAll({'params': options.queryParameters});
    }
    return requestInfo;
  }
}
