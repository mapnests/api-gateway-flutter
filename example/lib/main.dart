import 'dart:convert';

import 'package:api_gateway_flutter/api_gateway_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'logger.dart';
import 'network/api_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter SDK Sample',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Map<String, String>? headers;
  String? apiResponse;
  bool isLoading = false;
  String? errorMessage;

  late TabController _tabController;

  static const String apiUrl =
      'http://192.168.61.103:9880/load-test/api/auth-casbin-success-plugin-test';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Map<String, String> get dummyHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-App-Version': '1.0.0',
    'X-Platform': 'flutter',
  };

  Future<void> fetchHeaders() async {
    _setLoading(true);
    Logger.d('HomePage', 'Fetching SDK headers...');
    try {
      headers = await ApiGatewayFlutter.getHeaders();
      Logger.i('HomePage', 'Headers fetched: ${headers.toString()}');
      _tabController.animateTo(0);
    } catch (e) {
      Logger.e('HomePage', 'Error fetching headers: $e');
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> callApi() async {
    _setLoading(true);
    Logger.d('HomePage', 'Calling API: $apiUrl');
    try {
      final sdkHeaders = await ApiGatewayFlutter.getHeaders();
      Logger.d('HomePage', 'SDK Headers: ${sdkHeaders.toString()}');

      final mergedHeaders = {
        ...dummyHeaders,
        ...sdkHeaders,
      };
      Logger.d('HomePage', 'Merged Headers: $mergedHeaders');

      final response = await ApiClient.get(
        apiUrl,
        headers: mergedHeaders,
      );

      // Convert response data to JSON string if possible
      if (response.data is Map || response.data is List) {
        apiResponse = const JsonEncoder.withIndent('  ').convert(response.data);
      } else {
        apiResponse = response.data.toString();
      }

      Logger.i('HomePage', 'API Response: $apiResponse');
      _tabController.animateTo(1);
    } on DioError catch (e) {
      // Capture server error response (like {"error_msg":"invalid attempt to access"})
      if (e.response?.data != null) {
        if (e.response!.data is Map || e.response!.data is List) {
          apiResponse = const JsonEncoder.withIndent('  ')
              .convert(e.response!.data);
        } else {
          apiResponse = e.response!.data.toString();
        }
      } else {
        apiResponse = e.message;
      }
      Logger.e('HomePage', 'API call error: $apiResponse');
      _tabController.animateTo(1); // still show API Response tab
    } catch (e) {
      apiResponse = e.toString();
      Logger.e('HomePage', 'Unexpected error: $apiResponse');
      _tabController.animateTo(1);
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    setState(() {
      isLoading = value;
      errorMessage = null;
    });
  }

  void _setError(String message) {
    setState(() {
      errorMessage = message;
      apiResponse = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter SDK Sample App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Headers'),
            Tab(text: 'API Response'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// 🔘 Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : fetchHeaders,
                    child: const Text('Get API Headers'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : callApi,
                    child: const Text('Call API'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// ⏳ Loading
            if (isLoading) const LinearProgressIndicator(),

            /// ❌ Error
            if (errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],

            const SizedBox(height: 16),

            /// 📦 Content Area (Fixed height + Scroll inside)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: TabBarView(
                controller: _tabController,
                children: [
                  /// 🔹 Headers Tab
                  headers == null
                      ? const Center(child: Text('No headers loaded'))
                      : ListView.separated(
                    itemCount: headers!.length,
                    separatorBuilder: (_, __) =>
                    const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final entry =
                      headers!.entries.elementAt(index);
                      return ListTile(
                        dense: true,
                        title: Text(
                          entry.key,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(entry.value),
                      );
                    },
                  ),

                  /// 🔹 API Response Tab
                  apiResponse == null
                      ? const Center(child: Text('No API response'))
                      : Padding(
                    padding: const EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      child: SelectableText(
                        apiResponse!,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
