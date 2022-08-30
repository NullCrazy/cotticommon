import 'package:dio/dio.dart';

import '../interface/header_povider.dart';

class HeaderInterceptor extends Interceptor {
  late HeaderProvider _provider;

  HeaderInterceptor(HeaderProvider provider) {
    _provider = provider;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = _provider.headers;
    handler.next(options);
  }
}
