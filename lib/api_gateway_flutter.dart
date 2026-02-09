
import 'api_gateway_flutter_platform_interface.dart';

class ApiGatewayFlutter {
  static Future<Map<String, String>> getHeaders() {
    return ApiGatewayFlutterPlatform.instance.getHeaders();
  }
}
