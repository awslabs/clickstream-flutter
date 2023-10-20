import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clickstream_flutter/clickstream_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ClickstreamAnalyticsMethodChannel platform =
      ClickstreamAnalyticsMethodChannel();
  const MethodChannel channel = MethodChannel('clickstream_flutter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case "init":
            if (methodCall.arguments['endpoint'] == "") {
              return false;
            } else {
              return true;
            }
          case "record":
            return null;
          case "setUserId":
            return null;
          case "setUserAttributes":
            return null;
          case "setGlobalAttributes":
            return null;
          case "deleteGlobalAttributes":
            return null;
          case "updateConfigure":
            return null;
          case "flushEvents":
            return null;
        }
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('init failed', () async {
    Map<String, Object?> initConfig = {
      'appId': 'testApp',
      'endpoint': "",
    };
    expect(await platform.init(initConfig), false);
  });

  test('init success', () async {
    Map<String, Object?> initConfig = {
      'appId': 'testApp',
      'endpoint': "http://example.com/collect",
    };
    expect(await platform.init(initConfig), true);
  });

  test('record', () async {
    Map<String, Object?> attributes = {
      "category": "shoes",
      "currency": "CNY",
      "value": 279.9
    };
    var result = platform.record(attributes);
    expect(result, isNotNull);
  });

  test('setUserId', () async {
    Map<String, Object?> attributes = {
      "userId": "1234",
    };
    var result = platform.setUserId(attributes);
    expect(result, isNotNull);
  });

  test('setUserAttributes', () async {
    Map<String, Object?> attributes = {"_user_age": 21, "_user_name": "carl"};
    var result = platform.setUserAttributes(attributes);
    expect(result, isNotNull);
  });

  test('setGlobalAttributes', () async {
    Map<String, Object?> attributes = {
      "channel": "Play Store",
      "level": 5.1,
      "class": 6
    };
    var result = platform.addGlobalAttributes(attributes);
    expect(result, isNotNull);
  });

  test('deleteGlobalAttributes', () async {
    Map<String, Object?> attributes = {
      "attributes": ["attr1", "attr2"],
    };
    var result = platform.deleteGlobalAttributes(attributes);
    expect(result, isNotNull);
  });

  test('updateConfigure', () async {
    Map<String, Object?> attributes = {
      "appId": "newAppId",
      "endpoint": "https://example.com/collect",
    };
    var result = platform.updateConfigure(attributes);
    expect(result, isNotNull);
  });

  test('setGlobalAttributes', () async {
    var result = platform.flushEvents();
    expect(result, isNotNull);
  });
}
