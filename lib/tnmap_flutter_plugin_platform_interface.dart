import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tnmap_flutter_plugin_method_channel.dart';

abstract class TnmapFlutterPluginPlatform extends PlatformInterface {
  TnmapFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static TnmapFlutterPluginPlatform _instance = MethodChannelTnmapFlutterPlugin();

  static TnmapFlutterPluginPlatform get instance => _instance;

  static set instance(TnmapFlutterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<String, String>> getHeaders() {
    throw UnimplementedError('getHeaders() has not been implemented.');
  }
}
