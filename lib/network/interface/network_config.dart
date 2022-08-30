/// Description:
/// Author: xingguo.lei@abite.com
/// Date: 2022/8/25 4:49 下午
abstract class NetWorkConfig {
  String? get baseUrl;

  String? get signKey;

  String? get appKey;

  String? get version;

  String? get apiVersion;

  int get connectTimeout => 5000;

  int get receiveTimeout => 5000;

  int get sendTimeout => 5000;

  ///是否输出网络日志？ 默认输出
  bool get logger => true;
}
