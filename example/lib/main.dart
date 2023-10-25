// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'package:clickstream_analytics/clickstream_analytics.dart';
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
  }

  void log(String message) {
    if (kDebugMode) {
      print(message);
    }
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
                bool result = await analytics.init(
                    appId: "shopping",
                    endpoint: testEndpoint,
                    isLogEvents: true,
                    isCompressEvents: false);
                log("init SDK result is:$result");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.touch_app),
              title: const Text('recordEvent'),
              onTap: () async {
                analytics.record(name: "testEventWithName");
                analytics.record(name: "testEvent", attributes: {
                  "category": 'shoes',
                  "currency": 'CNY',
                  "intValue": 13,
                  "longValue": 9999999913991919,
                  "doubleValue": 11.1234567890121213,
                  "boolValue": true,
                  "value": 279.9
                });
                log("recorded testEvent and testEventWithName");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('setUserId'),
              onTap: () async {
                analytics.setUserId("12345");
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
                  "_channel": "Samsung",
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
                analytics.deleteGlobalAttributes(["Score", "_channel"]);
                log("deleteGlobalAttributes Score and _channel");
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
                    sessionTimeoutDuration: 100000,
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
          ],
        ),
      ),
    );
  }
}
