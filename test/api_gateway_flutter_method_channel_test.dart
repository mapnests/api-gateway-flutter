import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:api_gateway_flutter/api_gateway_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelApiGatewayFlutter platform = MethodChannelApiGatewayFlutter();
  const MethodChannel channel = MethodChannel('api_gateway_flutter');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

}
