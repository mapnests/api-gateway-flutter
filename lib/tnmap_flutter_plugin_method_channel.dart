import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'tnmap_flutter_plugin_platform_interface.dart';

/// An implementation of [TnmapFlutterPluginPlatform] that uses method channels.
class MethodChannelTnmapFlutterPlugin extends TnmapFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tnmap_flutter_plugin');

  @override
  Future<Map<String, String>> getHeaders() async {
    final Map<dynamic, dynamic> headersMap =
    await methodChannel.invokeMethod('getHeaders');
    // Convert dynamic map to Map<String, String>
    return headersMap.map((key, value) => MapEntry(key.toString(), value.toString()));
  }
}
