import 'dart:developer';

import 'package:logger/logger.dart';

/// Description:
/// Author: xingguo.lei@abite.com
/// Date: 2022/8/26 3:47 下午
var _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
  ),
);

logV(dynamic msg) {
  _logger.v(msg);
}

logD(dynamic msg) {
  _logger.d(msg);
}

logI(dynamic msg) {
  _logger.i(msg);
}

logW(dynamic msg) {
  _logger.w(msg);
}

logE(dynamic msg) {
  _logger.e(msg);
}

logAll(String msg) {
  log(msg);
}
