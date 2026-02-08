import 'tnmap_flutter_plugin_platform_interface.dart';

class TnmapFlutterPlugin {
  /// Fetch API Gateway headers
  static Future<Map<String, String>> getHeaders() {
    return TnmapFlutterPluginPlatform.instance.getHeaders();
  }
}