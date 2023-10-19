import 'package:flutter_test/flutter_test.dart';
import 'package:clickstream_flutter/clickstream_flutter.dart';
import 'package:clickstream_flutter/clickstream_flutter_platform_interface.dart';
import 'package:clickstream_flutter/clickstream_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockClickstreamFlutterPlatform
    with MockPlatformInterfaceMixin
    implements ClickstreamAnalytics {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool> init() => Future.value(true);

  @override
  Future<void> record(String name) => Future.value();
}

void main() {
  final ClickstreamAnalytics initialPlatform = ClickstreamAnalytics.instance;

  test('$MethodChannelClickstreamAnalytics is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelClickstreamAnalytics>());
  });

  test('getPlatformVersion', () async {
    ClickstreamFlutter clickstreamFlutterPlugin = ClickstreamFlutter();
    MockClickstreamFlutterPlatform fakePlatform =
        MockClickstreamFlutterPlatform();
    ClickstreamAnalytics.instance = fakePlatform;

    expect(await clickstreamFlutterPlugin.getPlatformVersion(), '42');
  });
}
