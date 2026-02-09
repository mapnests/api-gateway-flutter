import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'api_gateway_flutter_method_channel.dart';

abstract class ApiGatewayFlutterPlatform extends PlatformInterface {
  ApiGatewayFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static ApiGatewayFlutterPlatform _instance = MethodChannelApiGatewayFlutter();

  static ApiGatewayFlutterPlatform get instance => _instance;

  static set instance(ApiGatewayFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<String, String>> getHeaders() {
    throw UnimplementedError('getHeaders() has not been implemented.');
  }
}
