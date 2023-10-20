import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:clickstream_flutter/clickstream_flutter.dart';

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
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
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
                var result = await analytics.init(
                    appId: "shopping",
                    endpoint: testEndpoint,
                    isLogEvents: true,
                    isCompressEvents: false);
                print("init SDK result is:$result");
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
                print("recorded testEvent and testEventWithName");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('setUserId'),
              onTap: () async {
                analytics.setUserId("12345");
                analytics.setUserId(null);
                print("setUserId");
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
                print("setUserAttributes");
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
                print("addGlobalAttributes");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.delete_rounded),
              title: const Text('deleteGlobalAttributes'),
              onTap: () async {
                analytics.deleteGlobalAttributes(["Score", "_channel"]);
                print("deleteGlobalAttributes Score and _channel");
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
                print("updateConfigure");
              },
              minLeadingWidth: 0,
            ),
            ListTile(
              leading: const Icon(Icons.send),
              title: const Text('flushEvents'),
              onTap: () async {
                analytics.flushEvents();
                print("flushEvents");
              },
              minLeadingWidth: 0,
            ),
          ],
        ),
      ),
    );
  }
}
