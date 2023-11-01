// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'clickstream_analytics_method_channel.dart';

abstract class ClickstreamInterface extends PlatformInterface {
  /// Constructs a ClickstreamAnalytics.
  ClickstreamInterface() : super(token: _token);

  static final Object _token = Object();

  static ClickstreamInterface _instance = ClickstreamAnalyticsMethodChannel();

  /// The default instance of [ClickstreamInterface] to use.
  ///
  /// Defaults to [ClickstreamAnalyticsMethodChannel].
  static ClickstreamInterface get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ClickstreamInterface] when
  /// they register themselves.
  static set instance(ClickstreamInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> init(Map<String, Object?> configure) {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<void> record(Map<String, Object?> attributes) {
    throw UnimplementedError('record() has not been implemented.');
  }

  Future<void> setUserId(Map<String, Object?> userId) {
    throw UnimplementedError('setUserId() has not been implemented.');
  }

  Future<void> setUserAttributes(Map<String, Object?> attributes) {
    throw UnimplementedError('setUserAttributes() has not been implemented.');
  }

  Future<void> addGlobalAttributes(Map<String, Object?> attributes) {
    throw UnimplementedError('addGlobalAttributes() has not been implemented.');
  }

  Future<void> deleteGlobalAttributes(Map<String, Object?> attributes) {
    throw UnimplementedError('deleteGlobalAttributes() has not been implemented.');
  }

  Future<void> updateConfigure(Map<String, Object?> configure) {
    throw UnimplementedError('updateConfigure() has not been implemented.');
  }

  Future<void> flushEvents() {
    throw UnimplementedError('flushEvents() has not been implemented.');
  }

  Future<void> disable() {
    throw UnimplementedError('disable() has not been implemented.');
  }

  Future<void> enable() {
    throw UnimplementedError('enable() has not been implemented.');
  }
}
