// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:clickstream_analytics/clickstream_analytics_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An implementation of [ClickstreamFlutterPlatform] that uses method channels.
class MockMethodChannel extends ClickstreamInterface {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('clickstream_flutter');

  @override
  Future<bool> init(Map<String, Object?> configure) async {
    return super.init(configure);
  }

  @override
  Future<void> record(Map<String, Object?> attributes) async {
    return super.record(attributes);
  }

  @override
  Future<void> setUserId(Map<String, Object?> userId) async {
    return super.setUserId(userId);
  }

  @override
  Future<void> setUserAttributes(Map<String, Object?> attributes) async {
    return super.setUserAttributes(attributes);
  }

  @override
  Future<void> addGlobalAttributes(Map<String, Object?> attributes) async {
    return super.addGlobalAttributes(attributes);
  }

  @override
  Future<void> deleteGlobalAttributes(Map<String, Object?> attributes) async {
    return super.deleteGlobalAttributes(attributes);
  }

  @override
  Future<void> updateConfigure(Map<String, Object?> configure) async {
    return super.updateConfigure(configure);
  }

  @override
  Future<void> flushEvents() async {
    return super.flushEvents();
  }

  @override
  Future<void> disable() async {
    return super.disable();
  }

  @override
  Future<void> enable() async {
    return super.enable();
  }
}
