// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:clickstream_analytics/clickstream_analytics.dart';
import 'package:clickstream_analytics/clickstream_analytics_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String testEndpoint = "https://example.com/collect";
  final analytics = ClickstreamAnalytics();

  @override
  void initState() {
    super.initState();
    initClickstream();
  }

  void log(String message) {
    if (kDebugMode) {
      print(message);
    }
  }

  Future<void> initClickstream() async {
    bool result = await analytics.init(
        appId: "shopping",
        endpoint: testEndpoint,
        isLogEvents: true,
        isTrackScreenViewEvents: true,
        isCompressEvents: false,
        sessionTimeoutDuration: 30000,
        globalAttributes: {
          "channel": "Samsung",
          "Class": 5,
          "isTrue": true,
          "Score": 24.32
        });
    log("init SDK result is:$result");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Clickstream Flutter SDK API'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.not_started_outlined),
              title: const Text('initSDK'),
              onTap: () async {
                initClickstream();
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.circle),
              title: const Text('recordEventWithName'),
              onTap: () async {
                analytics.record(name: "testEventWithName");
                log("recorded testEvent with testEventWithName");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.touch_app),
              title: const Text('recordEventWithAttributes'),
              onTap: () async {
                analytics.record(name: "testEvent", attributes: {
                  "category": 'shoes',
                  "currency": 'CNY',
                  "intValue": 13,
                  "longValue": 9999999913991919,
                  "doubleValue": 11.1234567890121213,
                  "boolValue": true,
                  "value": 279.9
                });
                log("recorded testEvent and attributes");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.remove_red_eye_outlined),
              title: const Text('recordCustomScreenViewEvents'),
              onTap: () async {
                analytics.recordScreenView(
                    screenName: 'Main',
                    screenUniqueId: '123adf',
                    attributes: {'screenClass': "example/lib/main.dart"});
                log("recorded an custom screen view event");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.touch_app_outlined),
              title: const Text('recordEventWithItem'),
              onTap: () async {
                var testItem1 = ClickstreamItem(
                    id: "1",
                    name: "testName1",
                    brand: "Google",
                    currency: "CNY",
                    category: "book",
                    locationId: "1",
                    attributes: {
                      "intValue": 21,
                      "longValue": 888888888813991919,
                      "doubleValue": 11.1234567890121213,
                      "boolValue": true,
                      "value": 279.9
                    });
                var testItem2 = ClickstreamItem(
                    id: "2",
                    name: "testName2",
                    brand: "Sumsang",
                    currency: "USD",
                    category: "shoes",
                    locationId: "2",
                    attributes: {
                      "intValue": 13,
                      "longValue": 9999999913991919,
                      "doubleValue": 22.1234567890121213,
                      "boolValue": true,
                      "value": 379.9
                    });
                analytics.record(
                    name: "testRecordItem",
                    attributes: {"testKey": "testValue"},
                    items: [testItem1, testItem2]);
                log("recorded testEvent with item");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('setUserId'),
              onTap: () async {
                analytics.setUserId("12345");
                log("setUserId");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.no_accounts),
              title: const Text('setUserIdToNull'),
              onTap: () async {
                analytics.setUserId(null);
                log("setUserId");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.manage_accounts),
              title: const Text('setUserAttributes'),
              onTap: () async {
                analytics.setUserAttributes(
                    {"category": 'shoes', "currency": 'CNY', "value": 279.9});
                analytics.setUserAttributes({});
                analytics.setUserAttributes({"testNull": null});
                log("setUserAttributes");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text('addGlobalAttributes'),
              onTap: () async {
                analytics.addGlobalAttributes({
                  "channel": "Samsung",
                  "Class": 5,
                  "isTrue": true,
                  "Score": 24.32
                });
                log("addGlobalAttributes");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.delete_rounded),
              title: const Text('deleteGlobalAttributes'),
              onTap: () async {
                analytics.deleteGlobalAttributes(["Score", "channel"]);
                log("deleteGlobalAttributes Score and channel");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.update),
              title: const Text('updateConfigure'),
              onTap: () async {
                analytics.updateConfigure(
                    isLogEvents: true,
                    isCompressEvents: false,
                    isTrackUserEngagementEvents: false,
                    isTrackAppExceptionEvents: false,
                    authCookie: "test cookie",
                    isTrackScreenViewEvents: false);
                analytics.updateConfigure();
                log("updateConfigure");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.send),
              title: const Text('flushEvents'),
              onTap: () async {
                analytics.flushEvents();
                log("flushEvents");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.disabled_by_default),
              title: const Text('disable'),
              onTap: () async {
                analytics.disable();
                log("disable");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.check),
              title: const Text('enable'),
              onTap: () async {
                analytics.enable();
                log("enable");
              },
              minLeadingWidth: 0,
            ),
          ],
        ),
      ),
    );
  }
}
