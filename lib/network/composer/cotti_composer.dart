import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Description:
/// Author: xingguo.lei@abite.com
/// Date: 2022/8/29 9:35 上午
class CottiComposer {
  static Future<T> composer<T>(Future requestFuture, bool showToast) async {
    Completer<T> completer = Completer<T>();
    Response response = await requestFuture.catchError((e) {
      print("cottiDio: $e");
      if (showToast) {
        Fluttertoast.showToast(msg: '网络连接失败，请检查网络后重试');
      }
      completer.completeError(e);
    });

    if (isSuccessful(response)) {
      if (response.data['data'] == null) {
        completer.completeError('error data is NULL!');
      } else {
        completer.complete(response.data['data']);
      }
    } else {
      String? errorMessage;
      if (response.data != null) {
        errorMessage = response.data['busMessage'];
      }
      if ((errorMessage?.isNotEmpty ?? false) && showToast) {
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
    return completer.future;
  }

  static bool isSuccessful(Response response) {
    return response.statusCode == 200 &&
        response.data != null &&
        [200, 0].contains(response.data['code']) &&
        response.data['busCode'] == "1";
  }
}
