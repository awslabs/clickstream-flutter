// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'clickstream_analytics_item.dart';
import 'clickstream_analytics_platform_interface.dart';

class ClickstreamAnalytics {
  Future<bool> init({
    required String appId,
    required String endpoint,
    bool isLogEvents = false,
    bool isCompressEvents = true,
    bool isTrackScreenViewEvents = true,
    bool isTrackUserEngagementEvents = true,
    bool isTrackAppExceptionEvents = false,
    int sendEventsInterval = 10000,
    int sessionTimeoutDuration = 1800000,
    String authCookie = "",
    Map<String, Object?>? globalAttributes,
  }) {
    Map<String, Object?> initConfig = {
      'appId': appId,
      'endpoint': endpoint,
      'isLogEvents': isLogEvents,
      'isCompressEvents': isCompressEvents,
      'isTrackScreenViewEvents': isTrackScreenViewEvents,
      'isTrackUserEngagementEvents': isTrackUserEngagementEvents,
      'isTrackAppExceptionEvents': isTrackAppExceptionEvents,
      'sendEventsInterval': sendEventsInterval,
      'sessionTimeoutDuration': sessionTimeoutDuration,
      'authCookie': authCookie,
      'globalAttributes': globalAttributes
    };
    return ClickstreamInterface.instance.init(initConfig);
  }

  Future<void> record(
      {required String name,
      Map<String, Object?>? attributes,
      List<ClickstreamItem>? items}) {
    var itemArray = [];
    if (items != null) {
      for (ClickstreamItem item in items) {
        itemArray.add(item.toMap());
      }
    }
    return ClickstreamInterface.instance.record({
      "eventName": name,
      "attributes": attributes ?? {},
      "items": itemArray
    });
  }

  Future<void> recordScreenView(
      {required String screenName,
      String? screenUniqueId,
      Map<String, Object?>? attributes}) {
    return record(name: '_screen_view', attributes: {
      '_screen_name': screenName,
      if (screenUniqueId != null) '_screen_unique_id': screenUniqueId,
      if (attributes != null) ...attributes,
    });
  }

  Future<void> setUserId(String? userId) {
    return ClickstreamInterface.instance.setUserId({"userId": userId});
  }

  Future<void> setUserAttributes(Map<String, Object?> attributes) {
    if (attributes.isEmpty) return Future.value();
    return ClickstreamInterface.instance.setUserAttributes(attributes);
  }

  Future<void> addGlobalAttributes(Map<String, Object?> attributes) {
    if (attributes.isEmpty) return Future.value();
    return ClickstreamInterface.instance.addGlobalAttributes(attributes);
  }

  Future<void> deleteGlobalAttributes(List<String> attributes) {
    if (attributes.isEmpty) return Future.value();
    return ClickstreamInterface.instance
        .deleteGlobalAttributes({"attributes": attributes});
  }

  Future<void> updateConfigure({
    String? appId,
    String? endpoint,
    bool? isLogEvents,
    bool? isCompressEvents,
    bool? isTrackScreenViewEvents,
    bool? isTrackUserEngagementEvents,
    bool? isTrackAppExceptionEvents,
    int? sessionTimeoutDuration,
    String? authCookie,
  }) {
    Map<String, Object?> configure = {
      'appId': appId,
      'endpoint': endpoint,
      'isLogEvents': isLogEvents,
      'isCompressEvents': isCompressEvents,
      'isTrackScreenViewEvents': isTrackScreenViewEvents,
      'isTrackUserEngagementEvents': isTrackUserEngagementEvents,
      'isTrackAppExceptionEvents': isTrackAppExceptionEvents,
      'sessionTimeoutDuration': sessionTimeoutDuration,
      'authCookie': authCookie
    };
    return ClickstreamInterface.instance.updateConfigure(configure);
  }

  Future<void> flushEvents() {
    return ClickstreamInterface.instance.flushEvents();
  }

  Future<void> disable() {
    return ClickstreamInterface.instance.disable();
  }

  Future<void> enable() {
    return ClickstreamInterface.instance.enable();
  }
}

class Attr {
  static const String TRAFFIC_SOURCE_SOURCE = '_traffic_source_source';
  static const String TRAFFIC_SOURCE_MEDIUM = '_traffic_source_medium';
  static const String TRAFFIC_SOURCE_CAMPAIGN = '_traffic_source_campaign';
  static const String TRAFFIC_SOURCE_CAMPAIGN_ID =
      '_traffic_source_campaign_id';
  static const String TRAFFIC_SOURCE_TERM = '_traffic_source_term';
  static const String TRAFFIC_SOURCE_CONTENT = '_traffic_source_content';
  static const String TRAFFIC_SOURCE_CLID = '_traffic_source_clid';
  static const String TRAFFIC_SOURCE_CLID_PLATFORM =
      '_traffic_source_clid_platform';
  static const String APP_INSTALL_CHANNEL = '_app_install_channel';
  static const String VALUE = '_value';
  static const String CURRENCY = '_currency';
}
