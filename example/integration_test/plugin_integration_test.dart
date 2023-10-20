// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://docs.flutter.dev/cookbook/testing/integration/introduction


import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:clickstream_flutter/clickstream_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test init SDK success', (WidgetTester tester) async {
    final ClickstreamAnalytics analytics = ClickstreamAnalytics();
    final bool result = await analytics.init(
        appId: "testAppId", endpoint: "https://example.com/collect");
    expect(result, true);
  });
}
