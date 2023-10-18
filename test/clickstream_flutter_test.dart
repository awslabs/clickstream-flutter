// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:clickstream_analytics/clickstream_analytics.dart';
import 'package:clickstream_analytics/clickstream_analytics_method_channel.dart';
import 'package:clickstream_analytics/clickstream_analytics_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockClickstreamFlutterPlatform
    with MockPlatformInterfaceMixin
    implements ClickstreamInterface {
  @override
  Future<bool> init(Map<String, Object?> configure) => Future.value(true);

  @override
  Future<void> record(Map<String, Object?> params) => Future.value();

  @override
  Future<void> flushEvents() => Future.value();

  @override
  Future<void> addGlobalAttributes(Map<String, Object?> attributes) =>
      Future.value();

  @override
  Future<void> setUserAttributes(Map<String, Object?> attributes) =>
      Future.value();

  @override
  Future<void> setUserId(Map<String, Object?> userId) => Future.value();

  @override
  Future<void> updateConfigure(Map<String, Object?> configure) =>
      Future.value();

  @override
  Future<void> deleteGlobalAttributes(Map<String, Object?> attributes) =>
      Future.value();
}

void main() {
  final ClickstreamInterface initialPlatform = ClickstreamInterface.instance;
  late ClickstreamAnalytics analytics;

  setUp(() {
    analytics = ClickstreamAnalytics();
    MockClickstreamFlutterPlatform fakePlatform =
        MockClickstreamFlutterPlatform();
    ClickstreamInterface.instance = fakePlatform;
  });

  test('$ClickstreamAnalyticsMethodChannel is the default instance', () {
    expect(initialPlatform, isInstanceOf<ClickstreamAnalyticsMethodChannel>());
  });

  test('initSDK', () async {
    var result = await analytics.init(
        appId: 'testApp', endpoint: "https://example.com/collect");
    expect(result, true);
  });

  test('record event', () async {
    var result = analytics.record(name: "testEvent");
    expect(result, isNotNull);
  });

  test('record event with attributes', () async {
    var result = analytics.record(
        name: "testEvent",
        attributes: {"category": "shoes", "currency": "CNY", "value": 279.9});
    expect(result, isNotNull);
  });
  test('setUserId', () async {
    var result = analytics.setUserId("11234");
    expect(result, isNotNull);
  });

  test('setUserAttributes', () async {
    var result =
        analytics.setUserAttributes({"_user_age": 21, "_user_name": "carl"});
    var result1 = analytics.setUserAttributes({});
    expect(result, isNotNull);
    expect(result1, isNotNull);
  });

  test('setGlobalAttributes', () async {
    var result = analytics.addGlobalAttributes(
        {"channel": "Play Store", "level": 5.1, "class": 6});
    var result1 = analytics.addGlobalAttributes({});
    expect(result, isNotNull);
    expect(result1, isNotNull);
  });

  test('deleteGlobalAttributes', () async {
    var result = analytics.deleteGlobalAttributes(["attr1", "attr2"]);
    var result1 = analytics.deleteGlobalAttributes([]);
    expect(result, isNotNull);
    expect(result1, isNotNull);
  });

  test('updateConfigure', () async {
    var result = analytics.updateConfigure(
        appId: "testApp1",
        endpoint: "https://example.com/collect",
        isLogEvents: true,
        isCompressEvents: false,
        isTrackScreenViewEvents: false,
        isTrackUserEngagementEvents: false,
        isTrackAppExceptionEvents: false,
        sessionTimeoutDuration: 18000,
        authCookie: "your auth cookie");
    expect(result, isNotNull);
  });

  test('flushEvents', () async {
    var result = analytics.flushEvents();
    expect(result, isNotNull);
  });
}
