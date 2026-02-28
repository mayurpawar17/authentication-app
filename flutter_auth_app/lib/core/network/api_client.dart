import 'dart:convert';

import 'package:http/http.dart' as http;

import '../storage/secure_storage_service.dart';
import '../utils/logger.dart';

class ApiClient {
  final String baseUrl = "http://10.0.2.2:5000/api";
  final SecureStorageService storage;

  ApiClient(this.storage);

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final accessToken = await storage.getAccessToken();

    final response = await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: {
        "Content-Type": "application/json",
        if (accessToken != null) "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 401) {
      return await _refreshAndRetry(endpoint, body);
    }
    AppLogger.debug(response.body);
    return response;
  }

  Future<http.Response> _refreshAndRetry(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final refreshToken = await storage.getRefreshToken();

    final refreshResponse = await http.post(
      Uri.parse("$baseUrl/auth/refresh"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refreshToken}),
    );

    if (refreshResponse.statusCode == 200) {
      final data = jsonDecode(refreshResponse.body);
      final newAccessToken = data["accessToken"];

      await storage.saveTokens(
        accessToken: newAccessToken,
        refreshToken: refreshToken!,
      );

      return await post(endpoint, body);
    } else {
      await storage.clearTokens();
      throw Exception("Session expired");
    }
  }
}
