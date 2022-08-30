import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../global/global_route_manager.dart';

/// Description: fluro的路由跳转工具类
///
/// Author: xingguolei
/// Date: 2021/11/24
class NavigatorUtils {
  static Future push(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      TransitionType? transition,
      Duration? transitionDuration,
      Map<String, dynamic>? params,
      Object? arguments}) {
    unfocus();
    return GlobalRouterManager.router.navigateTo(
      context,
      _getParamsPath(path, params),
      replace: replace,
      clearStack: clearStack,
      transition: transition ?? TransitionType.cupertino,
      transitionDuration: transitionDuration,
      routeSettings: RouteSettings(
        arguments: arguments,
      ),
    );
  }

  /// 返回
  static void pop(BuildContext context, {Object? result}) {
    unfocus();
    Navigator.pop(context, result);
  }

  static String _getParamsPath(String path, Map<String, dynamic>? params) {
    if (params == null) {
      return path;
    }
    int index = 0;
    String query = "";
    for (var key in params.keys) {
      var value;
      if (params[key] is String) {
        value = Uri.encodeComponent(params[key]);
      } else {
        value = params[key];
      }
      if (index == 0) {
        query = "?";
      } else {
        query = query + "&";
      }
      query += "$key=$value";
      index++;
    }
    path = path + query;
    return path;
  }

  ///收起软键盘
  static void unfocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
