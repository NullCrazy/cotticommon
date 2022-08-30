import 'package:flutter_bloc/flutter_bloc.dart';

abstract class GlobalBlocs {
  static final Map<String, Bloc> _map = {};

  static add(Map<String, Bloc> map) {
    _map.addAll(map);
  }

  static T get<T extends Bloc>(String blocName) {
    return _map[blocName] as T;
  }
}
