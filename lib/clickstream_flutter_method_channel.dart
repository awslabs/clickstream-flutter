import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'clickstream_flutter_platform_interface.dart';

/// An implementation of [ClickstreamFlutterPlatform] that uses method channels.
class ClickstreamAnalyticsMethodChannel extends ClickstreamInterface {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('clickstream_flutter');

  @override
  Future<bool> init(Map<String, Object?> configure) async {
    final result = await methodChannel.invokeMethod<bool>('init', configure);
    return result ?? false;
  }

  @override
  Future<void> record(Map<String, Object?> attributes) async {
    await methodChannel.invokeMethod<void>('record', attributes);
  }

  @override
  Future<void> setUserId(Map<String, Object?> userId) async {
    await methodChannel.invokeMethod<void>('setUserId', userId);
  }

  @override
  Future<void> setUserAttributes(Map<String, Object?> attributes) async {
    await methodChannel.invokeMethod<void>('setUserAttributes', attributes);
  }

  @override
  Future<void> addGlobalAttributes(Map<String, Object?> attributes) async {
    await methodChannel.invokeMethod<void>('addGlobalAttributes', attributes);
  }

  @override
  Future<void> deleteGlobalAttributes(Map<String, Object?> attributes) async {
    await methodChannel.invokeMethod<void>('deleteGlobalAttributes', attributes);
  }

  @override
  Future<void> updateConfigure(Map<String, Object?> configure) async {
    await methodChannel.invokeMethod<bool>('updateConfigure', configure);
  }

  @override
  Future<void> flushEvents() async {
    await methodChannel.invokeMethod<void>('flushEvents');
  }
}
