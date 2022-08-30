import 'package:fluro/fluro.dart';

import '../router/route_entry.dart';

abstract class GlobalRouterManager {
  static final FluroRouter _router = FluroRouter();

  static FluroRouter get router => _router;

  static registerRoutes(Iterable<RouteEntry> entries) {
    for (var element in entries) {
      _router.define(element.name,
          handler: element.handler, transitionType: element.transitionType);
    }
  }
}
