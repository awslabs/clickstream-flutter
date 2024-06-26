// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:clickstream_analytics/clickstream_analytics.dart';
import 'package:clickstream_analytics/clickstream_analytics_item.dart';
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

  @override
  Future<void> disable() => Future.value();

  @override
  Future<void> enable() => Future.value();
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

  test('init SDK with global attributes', () async {
    var result = await analytics.init(
        appId: 'testApp',
        endpoint: "https://example.com/collect",
        globalAttributes: {
          Attr.APP_INSTALL_CHANNEL: "amazon_store",
          "Class": 5,
          "isTrue": true,
          "Score": 24.32
        });
    expect(result, true);
  });

  test('init SDK with traffic source using global attributes', () async {
    var result = await analytics.init(
        appId: 'testApp',
        endpoint: "https://example.com/collect",
        globalAttributes: {
          Attr.TRAFFIC_SOURCE_SOURCE: "amazon",
          Attr.TRAFFIC_SOURCE_MEDIUM: "cpc",
          Attr.TRAFFIC_SOURCE_CAMPAIGN: "summer_promotion",
          Attr.TRAFFIC_SOURCE_CAMPAIGN_ID: "summer_promotion_01",
          Attr.TRAFFIC_SOURCE_TERM: "running_shoes",
          Attr.TRAFFIC_SOURCE_CONTENT: "banner_ad_1",
          Attr.TRAFFIC_SOURCE_CLID: "amazon_ad_123",
          Attr.TRAFFIC_SOURCE_CLID_PLATFORM: "amazon_ads",
          Attr.APP_INSTALL_CHANNEL: "amazon_store",
          "Class": 5,
          "isTrue": true,
          "Score": 24.32
        });
    expect(result, true);
  });

  test('init SDK with all configuration', () async {
    var result = await analytics.init(
        appId: 'testApp',
        endpoint: "https://example.com/collect",
        isLogEvents: true,
        isCompressEvents: false,
        sessionTimeoutDuration: 150000,
        sendEventsInterval: 60000,
        authCookie: 'test auth cookie',
        isTrackScreenViewEvents: false,
        isTrackUserEngagementEvents: false,
        isTrackAppExceptionEvents: true,
        globalAttributes: {
          Attr.APP_INSTALL_CHANNEL: "amazon_store",
        });
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

  test('record event with item', () async {
    var itemBook = ClickstreamItem(
        id: "123",
        name: "Nature",
        category: "book",
        currency: "CNY",
        price: 99,
        attributes: {"book_publisher": "Nature Research"});
    var itemShoes = ClickstreamItem(
        id: "124",
        name: "Nike",
        category: "shoes",
        price: 65,
        currency: "USD",
        attributes: {"place_of_origin": "USA"});
    var result = analytics.record(name: "cart_view", attributes: {
      Attr.TRAFFIC_SOURCE_CAMPAIGN: "Summer promotion",
      Attr.VALUE: 164,
      Attr.CURRENCY: "USD"
    }, items: [
      itemBook,
      itemShoes
    ]);
    expect(result, isNotNull);
  });

  test('record custom screen view event', () async {
    var result = analytics.recordScreenView(
        screenName: "MainPage",
        screenUniqueId: 'a13cfe',
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
        {Attr.APP_INSTALL_CHANNEL: "amazon_store", "level": 5.1, "class": 6});
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

  test('disable', () async {
    var result = analytics.disable();
    expect(result, isNotNull);
  });

  test('enable', () async {
    var result = analytics.enable();
    expect(result, isNotNull);
  });
}
