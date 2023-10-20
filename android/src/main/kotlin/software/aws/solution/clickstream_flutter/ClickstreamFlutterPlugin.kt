package software.aws.solution.clickstream_flutter

import android.app.Activity
import com.amazonaws.logging.Log
import com.amazonaws.logging.LogFactory
import com.amplifyframework.AmplifyException
import com.amplifyframework.core.Amplify
import com.amplifyframework.core.AmplifyConfiguration
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject
import software.aws.solution.clickstream.AWSClickstreamPlugin
import software.aws.solution.clickstream.ClickstreamAnalytics
import software.aws.solution.clickstream.ClickstreamAttribute
import software.aws.solution.clickstream.ClickstreamEvent
import software.aws.solution.clickstream.ClickstreamUserAttribute
import software.aws.solution.clickstream.client.util.ThreadUtil
import java.util.Objects
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors


/** ClickstreamFlutterPlugin */
class ClickstreamFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity

    private val cachedThreadPool: ExecutorService by lazy { Executors.newCachedThreadPool() }

    private val log: Log = LogFactory.getLog(
        ClickstreamFlutterPlugin::class.java
    )
    private lateinit var channel: MethodChannel

    private var mActivity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "clickstream_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val arguments = call.arguments() as HashMap<String, Any>?
        when (call.method) {
            "init" -> {
                result.success(initSDK(arguments!!))
            }

            "record" -> {
                recordEvent(arguments)
            }

            "setUserId" -> {
                setUserId(arguments)
            }

            "setUserAttributes" -> {
                setUserAttributes(arguments)
            }

            "setGlobalAttributes" -> {
                setGlobalAttributes(arguments)
            }

            "deleteGlobalAttributes" -> {
                deleteGlobalAttributes(arguments)
            }

            "updateConfigure" -> {
                updateConfigure(arguments)
            }

            "flushEvents" -> {
                ClickstreamAnalytics.flushEvents()
            }

            else -> {
                result.notImplemented()
            }
        }
    }


    private fun initSDK(arguments: HashMap<String, Any>): Boolean {
        if (getIsInitialized()) return false
        if (mActivity != null) {
            val context = mActivity!!.applicationContext
            if (ThreadUtil.notInMainThread()) {
                log.error("Clickstream SDK initialization failed, please initialize in the main thread")
                return false
            }
            val amplifyObject = JSONObject()
            val analyticsObject = JSONObject()
            val pluginsObject = JSONObject()
            val awsClickstreamPluginObject = JSONObject()
            awsClickstreamPluginObject.put("appId", arguments["appId"])
            awsClickstreamPluginObject.put("endpoint", arguments["endpoint"])
            pluginsObject.put("awsClickstreamPlugin", awsClickstreamPluginObject)
            analyticsObject.put("plugins", pluginsObject)
            amplifyObject.put("analytics", analyticsObject)
            val configure = AmplifyConfiguration.fromJson(amplifyObject)
            try {
                Amplify.addPlugin<AWSClickstreamPlugin>(AWSClickstreamPlugin(context))
                Amplify.configure(configure, context)
            } catch (exception: AmplifyException) {
                log.error("Clickstream SDK initialization failed with error: " + exception.message)
                return false
            }
            val sessionTimeoutDuration = arguments["sessionTimeoutDuration"]
                .let { (it as? Int)?.toLong() ?: (it as Long) }
            val sendEventsInterval = arguments["sendEventsInterval"]
                .let { (it as? Int)?.toLong() ?: (it as Long) }
            ClickstreamAnalytics.getClickStreamConfiguration()
                .withLogEvents(arguments["isLogEvents"] as Boolean)
                .withTrackScreenViewEvents(arguments["isTrackScreenViewEvents"] as Boolean)
                .withTrackUserEngagementEvents(arguments["isTrackUserEngagementEvents"] as Boolean)
                .withTrackAppExceptionEvents(arguments["isTrackAppExceptionEvents"] as Boolean)
                .withSendEventsInterval(sendEventsInterval)
                .withSessionTimeoutDuration(sessionTimeoutDuration)
                .withCompressEvents(arguments["isCompressEvents"] as Boolean)
                .withAuthCookie(arguments["authCookie"] as String)
            return true
        } else {
            return false
        }
    }

    private fun recordEvent(arguments: HashMap<String, Any>?) {
        cachedThreadPool.execute {
            arguments?.let {
                val eventName = it["eventName"] as String
                val attributes = it["attributes"] as HashMap<*, *>
                val eventBuilder = ClickstreamEvent.builder().name(eventName)
                for ((key, value) in attributes) {
                    if (value is String) {
                        eventBuilder.add(key.toString(), value)
                    } else if (value is Double) {
                        eventBuilder.add(key.toString(), value)
                    } else if (value is Boolean) {
                        eventBuilder.add(key.toString(), value)
                    } else if (value is Int) {
                        eventBuilder.add(key.toString(), value)
                    } else if (value is Long) {
                        eventBuilder.add(key.toString(), value)
                    }
                }
                ClickstreamAnalytics.recordEvent(eventBuilder.build())
            }
        }
    }


    private fun setUserId(arguments: java.util.HashMap<String, Any>?) {
        arguments?.let {
            val userId = arguments["userId"]
            if (userId == null) {
                ClickstreamAnalytics.setUserId(null)
            } else {
                ClickstreamAnalytics.setUserId(userId.toString())
            }
        }
    }

    private fun setUserAttributes(arguments: java.util.HashMap<String, Any>?) {
        arguments?.let {
            val builder = ClickstreamUserAttribute.Builder()
            for ((key, value) in arguments) {
                if (value is String) {
                    builder.add(key, value)
                } else if (value is Double) {
                    builder.add(key, value)
                } else if (value is Boolean) {
                    builder.add(key, value)
                } else if (value is Int) {
                    builder.add(key, value)
                } else if (value is Long) {
                    builder.add(key, value)
                }
            }
            ClickstreamAnalytics.addUserAttributes(builder.build())
        }
    }

    private fun setGlobalAttributes(arguments: java.util.HashMap<String, Any>?) {
        arguments?.let {
            val builder = ClickstreamAttribute.Builder()
            for ((key, value) in arguments) {
                if (value is String) {
                    builder.add(key, value)
                } else if (value is Double) {
                    builder.add(key, value)
                } else if (value is Boolean) {
                    builder.add(key, value)
                } else if (value is Int) {
                    builder.add(key, value)
                } else if (value is Long) {
                    builder.add(key, value)
                }
            }
            ClickstreamAnalytics.addGlobalAttributes(builder.build())
        }
    }

    private fun deleteGlobalAttributes(arguments: java.util.HashMap<String, Any>?) {
        arguments?.let {
            @Suppress("UNCHECKED_CAST")
            val attributes = arguments["attributes"] as ArrayList<String>
            ClickstreamAnalytics.deleteGlobalAttributes(*attributes.toTypedArray())
        }
    }

    private fun updateConfigure(arguments: java.util.HashMap<String, Any>?) {
        arguments?.let {
            val configure = ClickstreamAnalytics.getClickStreamConfiguration()
            arguments["appId"]?.let {
                configure.withAppId(it as String)
            }
            arguments["endpoint"]?.let {
                configure.withEndpoint(it as String)
            }
            arguments["isLogEvents"]?.let {
                configure.withLogEvents(it as Boolean)
            }
            arguments["isTrackScreenViewEvents"]?.let {
                configure.withTrackScreenViewEvents(it as Boolean)
            }
            arguments["isTrackUserEngagementEvents"]?.let {
                configure.withTrackUserEngagementEvents(it as Boolean)
            }
            arguments["isTrackAppExceptionEvents"]?.let {
                configure.withTrackAppExceptionEvents(it as Boolean)
            }
            arguments["sessionTimeoutDuration"]?.let {
                val sessionTimeoutDuration = arguments["sessionTimeoutDuration"]
                    .let { (it as? Int)?.toLong() ?: (it as Long) }
                configure.withSessionTimeoutDuration(sessionTimeoutDuration)
            }
            arguments["isCompressEvents"]?.let {
                configure.withCompressEvents(it as Boolean)
            }
            arguments["authCookie"]?.let {
                configure.withAuthCookie(it as String)
            }
        }
    }

    private fun getIsInitialized(): Boolean {
        return invokeSuperMethod(Amplify.Analytics, "isConfigured") as Boolean
    }

    @Throws(Exception::class)
    fun invokeSuperMethod(`object`: Any, methodName: String): Any? {
        val method =
            Objects.requireNonNull(`object`.javaClass.superclass).getDeclaredMethod(methodName)
        method.isAccessible = true
        return method.invoke(`object`)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        mActivity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        mActivity = binding.activity
    }

    override fun onDetachedFromActivity() {
        mActivity = null
    }
}
