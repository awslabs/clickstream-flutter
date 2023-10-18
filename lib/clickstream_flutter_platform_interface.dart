import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'clickstream_flutter_method_channel.dart';

abstract class ClickstreamFlutterPlatform extends PlatformInterface {
  /// Constructs a ClickstreamFlutterPlatform.
  ClickstreamFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static ClickstreamFlutterPlatform _instance = MethodChannelClickstreamFlutter();

  /// The default instance of [ClickstreamFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelClickstreamFlutter].
  static ClickstreamFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ClickstreamFlutterPlatform] when
  /// they register themselves.
  static set instance(ClickstreamFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
