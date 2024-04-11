// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter_test/flutter_test.dart';

import 'mock_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MockMethodChannel platform = MockMethodChannel();

  test('init method for UnimplementedError', () async {
    Map<String, Object?> initConfig = {
      'appId': 'testApp',
      'endpoint': "",
    };
    expect(() async {
      await platform.init(initConfig);
    }, throwsA(isInstanceOf<UnimplementedError>()));
  });

  test('record method for UnimplementedError', () async {
    Map<String, Object?> attributes = {
      "category": "shoes",
      "currency": "CNY",
      "value": 279.9
    };
    expect(platform.record(attributes),
        throwsA(isInstanceOf<UnimplementedError>()));
  });

  test('setUserId method for UnimplementedError', () async {
    Map<String, Object?> attributes = {
      "userId": "1234",
    };
    expect(platform.setUserId(attributes),
        throwsA(isInstanceOf<UnimplementedError>()));
  });

  test('setUserAttributes method for UnimplementedError', () async {
    Map<String, Object?> attributes = {"_user_age": 21, "_user_name": "carl"};
    expect(platform.setUserAttributes(attributes),
        throwsA(isInstanceOf<UnimplementedError>()));
  });

  test('addGlobalAttributes method for UnimplementedError', () async {
    Map<String, Object?> attributes = {
      "channel": "Play Store",
      "level": 5.1,
      "class": 6
    };
    expect(platform.addGlobalAttributes(attributes),
        throwsA(isInstanceOf<UnimplementedError>()));
  });

  test('deleteGlobalAttributes method for UnimplementedError', () async {
    Map<String, Object?> attributes = {
      "attributes": ["attr1", "attr2"],
    };
    expect(platform.deleteGlobalAttributes(attributes),
        throwsA(isInstanceOf<UnimplementedError>()));
  });

  test('updateConfigure method for UnimplementedError', () async {
    Map<String, Object?> attributes = {
      "appId": "newAppId",
      "endpoint": "https://example.com/collect",
    };
    expect(platform.updateConfigure(attributes),
        throwsA(isInstanceOf<UnimplementedError>()));
  });

  test('flushEvents method for UnimplementedError', () async {
    expect(platform.flushEvents(), throwsA(isInstanceOf<UnimplementedError>()));
  });

  test('disable method for UnimplementedError', () async {
    expect(platform.disable(), throwsA(isInstanceOf<UnimplementedError>()));
  });

  test('enable method for UnimplementedError', () async {
    expect(platform.enable(), throwsA(isInstanceOf<UnimplementedError>()));
  });
}
