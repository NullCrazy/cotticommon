import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import '../interface/network_config.dart';

/// Description:
/// Author: xingguo.lei@abite.com
/// Date: 2022/8/25 4:42 下午
class SignatureInterceptor extends Interceptor {
  late NetWorkConfig _netWordConfig;

  SignatureInterceptor(NetWorkConfig netWordConfig) {
    _netWordConfig = netWordConfig;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Map<String, dynamic> headers = {};
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    headers['timestamp'] = timestamp;
    headers['path'] = options.path;
    headers['version'] = _netWordConfig.version;
    headers['sign'] = _getSign(headers, _netWordConfig.signKey ?? '');
    headers['appKey'] = _netWordConfig.appKey;
    headers['api-version'] = _netWordConfig.apiVersion;
    options.headers.addAll(headers);
    handler.next(options);
  }

  //获取签名
  String _getSign(Map parameter, String signKey) {
    List keyArray = parameter.keys.toList();
    keyArray.sort();
    // 存储所有键值对
    List<String> pairs = [];
    for (var key in keyArray) {
      pairs.add('$key${parameter[key]}');
    }
    // 数组转string
    String sign = pairs.join('') + signKey;
    // hash
    sign = _generateMd5(sign).toUpperCase();
    return sign;
  }

  String _generateMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return digest.toString();
  }
}
