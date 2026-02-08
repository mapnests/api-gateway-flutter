import Flutter
import UIKit
import TNApiGetwaySDK

public class TnmapFlutterPlugin: NSObject, FlutterPlugin {

    private let headerProvider = ApiGatewayHeaderProvider.shared

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "tnmap_flutter_plugin",
            binaryMessenger: registrar.messenger()
        )
        let instance = TnmapFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getHeaders":
            getHeaders(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    // MARK: - getHeaders
    private func getHeaders(result: @escaping FlutterResult) {
        let headers = headerProvider.getHeaders()
        result(headers)
    }
}
