import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'clickstream_flutter_platform_interface.dart';

/// An implementation of [ClickstreamFlutterPlatform] that uses method channels.
class MethodChannelClickstreamFlutter extends ClickstreamFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('clickstream_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
