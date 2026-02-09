package com.example.api_gateway_flutter

import android.content.Context
import androidx.annotation.NonNull
import com.technonext.network.ApiGatewayHeaderProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** ApiGatewayFlutterPlugin */
class ApiGatewayFlutterPlugin: FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var headerProvider: ApiGatewayHeaderProvider

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "api_gateway_flutter")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext

        // Initialize ApiGatewayHeaderProvider
        headerProvider = ApiGatewayHeaderProvider(context)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        when (call.method) {
            "getHeaders" -> getHeaders(result)
            else -> result.notImplemented()
        }
    }

    private fun getHeaders(result: MethodChannel.Result) {
        try {
            val headersMap = headerProvider.headers
            val headers = HashMap<String, String>()
            headersMap.forEach { (key, value) ->
                headers[key] = value.toString()
            }
            result.success(headers)
        } catch (e: Exception) {
            result.error("HEADER_ERROR", "Failed to get headers: ${e.message}", null)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
