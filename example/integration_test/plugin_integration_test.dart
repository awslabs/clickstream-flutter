// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:clickstream_analytics/clickstream_analytics.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test init SDK success', (WidgetTester tester) async {
    final ClickstreamAnalytics analytics = ClickstreamAnalytics();
    final bool result = await analytics.init(
        appId: "testAppId", endpoint: "https://example.com/collect");
    expect(result, true);
  });
}
