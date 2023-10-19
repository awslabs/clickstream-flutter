import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'clickstream_flutter_platform_interface.dart';

/// An implementation of [ClickstreamFlutterPlatform] that uses method channels.
class MethodChannelClickstreamAnalytics extends ClickstreamAnalytics {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('clickstream_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> init() async {
    final result = await methodChannel.invokeMethod<bool>('init');
    return result ?? false;
  }

  @override
  Future<bool> record(String eventName) async {
    final result = await methodChannel.invokeMethod<bool>('record', eventName);
    return result ?? false;
  }
}
