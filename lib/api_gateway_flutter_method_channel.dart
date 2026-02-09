import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'api_gateway_flutter_platform_interface.dart';

/// An implementation of [ApiGatewayFlutterPlatform] that uses method channels.
class MethodChannelApiGatewayFlutter extends ApiGatewayFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('api_gateway_flutter');

  @override
  Future<Map<String, String>> getHeaders() async {
    final Map<dynamic, dynamic> headersMap =
    await methodChannel.invokeMethod('getHeaders');
    // Convert dynamic map to Map<String, String>
    return headersMap.map((key, value) => MapEntry(key.toString(), value.toString()));
  }
}
