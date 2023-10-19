import 'clickstream_flutter_platform_interface.dart';

class ClickstreamFlutter {
  Future<String?> getPlatformVersion() {
    return ClickstreamAnalytics.instance.getPlatformVersion();
  }

  Future<bool> init() {
    return ClickstreamAnalytics.instance.init();
  }

  Future<void> record(String eventName) {
    return ClickstreamAnalytics.instance.record(eventName);
  }
}
