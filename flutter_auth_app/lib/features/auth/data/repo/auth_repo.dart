import 'dart:convert';

import '../../../../core/network/api_client.dart';
import '../../../../core/storage/secure_storage_service.dart';

class AuthRepository {
  final ApiClient apiClient;
  final SecureStorageService storage;

  AuthRepository(this.apiClient, this.storage);

  Future<void> login(String email, String password) async {
    final response = await apiClient.post("/auth/login", {
      "email": email,
      "password": password,
    });

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await storage.saveTokens(
        accessToken: data["accessToken"],
        refreshToken: data["refreshToken"],
      );
    } else {
      throw Exception(data["message"]);
    }
  }

  Future<void> signup(String email, String password) async {
    final response = await apiClient.post("/auth/signup", {
      "email": email,
      "password": password,
    });

    if (response.statusCode != 200) {
      throw Exception("Signup failed");
    }
  }

  Future<void> logout() async {
    await storage.clearTokens();
  }
}
