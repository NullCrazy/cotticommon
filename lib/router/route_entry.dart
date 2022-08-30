import 'package:fluro/fluro.dart';

class RouteEntry {
  final String name;
  final Handler handler;
  final TransitionType? transitionType;

  RouteEntry(this.name, {required this.handler, this.transitionType});
}
