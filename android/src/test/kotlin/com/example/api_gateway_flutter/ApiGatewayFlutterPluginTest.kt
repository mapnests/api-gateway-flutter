package com.example.api_gateway_flutter

import com.technonext.network.ApiGatewayHeaderProvider
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.junit.Test
import org.mockito.Mockito.*

class ApiGatewayFlutterPluginTest {

    @Test
    fun getHeaders_returnsExpectedHeaders() {
        // Arrange
        val mockHeaderProvider = mock(ApiGatewayHeaderProvider::class.java)
        val mockResult = mock(MethodChannel.Result::class.java)

        `when`(mockHeaderProvider.headers).thenReturn(
            mapOf(
                "Authorization" to "Bearer test-token",
                "X-App-Version" to "1.0.0"
            )
        )

        val plugin = ApiGatewayFlutterPlugin(mockHeaderProvider)
        val call = MethodCall("getHeaders", null)

        // Act
        plugin.onMethodCall(call, mockResult)

        // Assert
        val expected = mapOf(
            "Authorization" to "Bearer test-token",
            "X-App-Version" to "1.0.0"
        )
        verify(mockResult).success(expected)
    }

    @Test
    fun unknownMethod_callsNotImplemented() {
        val plugin = ApiGatewayFlutterPlugin()
        val mockResult = mock(MethodChannel.Result::class.java)
        val call = MethodCall("unknown_method", null)

        plugin.onMethodCall(call, mockResult)

        verify(mockResult).notImplemented()
    }
}
