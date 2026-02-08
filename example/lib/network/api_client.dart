import 'package:dio/dio.dart';

class ApiClient {
  ApiClient._();

  static final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
    ),
  );

  static Future<Response> get(
      String url, {
        required Map<String, String> headers,
      }) async {
    return dio.get(
      url,
      options: Options(headers: headers),
    );
  }
}
