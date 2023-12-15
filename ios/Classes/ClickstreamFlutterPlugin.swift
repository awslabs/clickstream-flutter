//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Flutter
import UIKit

public class ClickstreamFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "clickstream_flutter", binaryMessenger: registrar.messenger())
        let instance = ClickstreamFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "init":
            result(initSDK(call.arguments as! [String: Any]))
        case "record":
            recordEvent(call.arguments as! [String: Any])
        case "setUserId":
            setUserId(call.arguments as! [String: Any])
        case "setUserAttributes":
            setUserAttributes(call.arguments as! [String: Any])
        case "addGlobalAttributes":
            addGlobalAttributes(call.arguments as! [String: Any])
        case "deleteGlobalAttributes":
            deleteGlobalAttributes(call.arguments as! [String: Any])
        case "updateConfigure":
            updateConfigure(call.arguments as! [String: Any])
        case "flushEvents":
            ClickstreamAnalytics.flushEvents()
        case "disable":
            ClickstreamAnalytics.disable()
        case "enable":
            ClickstreamAnalytics.enable()
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    func initSDK(_ arguments: [String: Any]) -> Bool {
        do {
            let plugins: [String: JSONValue] = [
                "awsClickstreamPlugin": [
                    "appId": JSONValue.string(arguments["appId"] as! String),
                    "endpoint": JSONValue.string(arguments["endpoint"] as! String),
                    "isCompressEvents": JSONValue.boolean(arguments["isCompressEvents"] as! Bool),
                    "autoFlushEventsInterval": JSONValue.number(arguments["sendEventsInterval"] as! Double),
                    "isTrackAppExceptionEvents": JSONValue.boolean(arguments["isTrackAppExceptionEvents"] as! Bool)
                ]
            ]
            let analyticsConfiguration = AnalyticsCategoryConfiguration(plugins: plugins)
            let config = AmplifyConfiguration(analytics: analyticsConfiguration)
            try Amplify.add(plugin: AWSClickstreamPlugin())
            try Amplify.configure(config)
            let configure = try ClickstreamAnalytics.getClickstreamConfiguration()
            configure.isLogEvents = arguments["isLogEvents"] as! Bool
            configure.isTrackScreenViewEvents = arguments["isTrackScreenViewEvents"] as! Bool
            configure.isTrackUserEngagementEvents = arguments["isTrackUserEngagementEvents"] as! Bool
            configure.sessionTimeoutDuration = arguments["sessionTimeoutDuration"] as! Int64
            configure.authCookie = arguments["authCookie"] as? String
            return true
        } catch {
            log.error("Fail to initialize ClickstreamAnalytics: \(error)")
            return false
        }
    }

    func recordEvent(_ arguments: [String: Any]) {
        let eventName = arguments["eventName"] as! String
        let attributes = arguments["attributes"] as! [String: Any]
        let items = arguments["items"] as! [[String: Any]]
        if attributes.count > 0 {
            if items.count > 0 {
                var clickstreamItems: [ClickstreamAttribute] = []
                for itemObject in items {
                    clickstreamItems.append(getClickstreamAttributes(itemObject))
                }
                ClickstreamAnalytics.recordEvent(eventName, getClickstreamAttributes(attributes), clickstreamItems)
            } else {
                ClickstreamAnalytics.recordEvent(eventName, getClickstreamAttributes(attributes))
            }
        } else {
            ClickstreamAnalytics.recordEvent(eventName)
        }
    }

    func setUserId(_ arguments: [String: Any]) {
        if arguments["userId"] is NSNull {
            ClickstreamAnalytics.setUserId(nil)
        } else {
            ClickstreamAnalytics.setUserId(arguments["userId"] as? String)
        }
    }

    func setUserAttributes(_ arguments: [String: Any]) {
        ClickstreamAnalytics.addUserAttributes(getClickstreamAttributes(arguments))
    }

    func addGlobalAttributes(_ arguments: [String: Any]) {
        ClickstreamAnalytics.addGlobalAttributes(getClickstreamAttributes(arguments))
    }

    func deleteGlobalAttributes(_ arguments: [String: Any]) {
        let attributes = arguments["attributes"] as! [String]
        for attribute in attributes {
            ClickstreamAnalytics.deleteGlobalAttributes(attribute)
        }
    }

    func updateConfigure(_ arguments: [String: Any]) {
        do {
            let configure = try ClickstreamAnalytics.getClickstreamConfiguration()
            if let appId = arguments["appId"] as? String {
                configure.appId = appId
            }
            if let endpoint = arguments["endpoint"] as? String {
                configure.endpoint = endpoint
            }
            if let isLogEvents = arguments["isLogEvents"] as? Bool {
                configure.isLogEvents = isLogEvents
            }
            if let isTrackScreenViewEvents = arguments["isTrackScreenViewEvents"] as? Bool {
                configure.isTrackScreenViewEvents = isTrackScreenViewEvents
            }
            if let isTrackUserEngagementEvents = arguments["isTrackUserEngagementEvents"] as? Bool {
                configure.isTrackUserEngagementEvents = isTrackUserEngagementEvents
            }
            if let isTrackAppExceptionEvents = arguments["isTrackAppExceptionEvents"] as? Bool {
                configure.isTrackAppExceptionEvents = isTrackAppExceptionEvents
            }
            if let sessionTimeoutDuration = arguments["sessionTimeoutDuration"] as? Int64 {
                configure.sessionTimeoutDuration = sessionTimeoutDuration
            }
            if let isCompressEvents = arguments["isCompressEvents"] as? Bool {
                configure.isCompressEvents = isCompressEvents
            }
            if let authCookie = arguments["authCookie"] as? String {
                configure.authCookie = authCookie
            }
        } catch {
            log.error("Failed to config ClickstreamAnalytics: \(error)")
        }
    }

    func getClickstreamAttributes(_ attrs: [String: Any]) -> ClickstreamAttribute {
        var attributes: ClickstreamAttribute = [:]
        for (key, value) in attrs {
            if value is String {
                attributes[key] = value as! String
            } else if value is NSNumber {
                let value = value as! NSNumber
                let objCType = String(cString: value.objCType)
                if objCType == "c" {
                    attributes[key] = value.boolValue
                } else if objCType == "d" {
                    attributes[key] = value.doubleValue
                } else if objCType == "i" {
                    attributes[key] = value.intValue
                } else if objCType == "q" {
                    attributes[key] = value.int64Value
                }
            }
        }
        return attributes
    }
}

extension ClickstreamFlutterPlugin: DefaultLogger {}
