import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'clickstream_flutter_method_channel.dart';

abstract class ClickstreamAnalytics extends PlatformInterface {
  /// Constructs a ClickstreamAnalytics.
  ClickstreamAnalytics() : super(token: _token);

  static final Object _token = Object();

  static ClickstreamAnalytics _instance = MethodChannelClickstreamAnalytics();

  /// The default instance of [ClickstreamAnalytics] to use.
  ///
  /// Defaults to [MethodChannelClickstreamAnalytics].
  static ClickstreamAnalytics get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ClickstreamAnalytics] when
  /// they register themselves.
  static set instance(ClickstreamAnalytics instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<void> record(String eventName) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
