
import 'clickstream_flutter_platform_interface.dart';

class ClickstreamFlutter {
  Future<String?> getPlatformVersion() {
    return ClickstreamFlutterPlatform.instance.getPlatformVersion();
  }
}
