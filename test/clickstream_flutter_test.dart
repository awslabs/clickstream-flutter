import 'package:flutter_test/flutter_test.dart';
import 'package:clickstream_flutter/clickstream_flutter.dart';
import 'package:clickstream_flutter/clickstream_flutter_platform_interface.dart';
import 'package:clickstream_flutter/clickstream_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockClickstreamFlutterPlatform
    with MockPlatformInterfaceMixin
    implements ClickstreamFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ClickstreamFlutterPlatform initialPlatform = ClickstreamFlutterPlatform.instance;

  test('$MethodChannelClickstreamFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelClickstreamFlutter>());
  });

  test('getPlatformVersion', () async {
    ClickstreamFlutter clickstreamFlutterPlugin = ClickstreamFlutter();
    MockClickstreamFlutterPlatform fakePlatform = MockClickstreamFlutterPlatform();
    ClickstreamFlutterPlatform.instance = fakePlatform;

    expect(await clickstreamFlutterPlugin.getPlatformVersion(), '42');
  });
}
