import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/signup.dart';
import 'package:hotel_booking/domain/entities/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserApi {
  final String baseUrl = 'http://localhost:3000'; // Replace with your backend URL
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    String? token = await storage.read(key: 'user_token');
    print('Retrieved token: $token'); // Debugging print statement
    return token;
  }

  Future<void> signup(SignupState signupState) async {
    if (signupState.password != signupState.confirmPassword) {
      throw Exception("Password confirmation doesn't match");
    }

    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': signupState.fullName,
        'email': signupState.email,
        'password': signupState.password,
        'role': signupState.isAdmin ? 'admin' : 'customer',
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to sign up');
    }
  }

  Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      await storage.write(key: 'user_token', value: data['token']);
      print('Stored token: ${data['token']}'); // Debugging print statement
      return data['token']; // Return the token
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<User> getUserById(String userId) async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to fetch user data');
    }
  }

  Future<void> updateUserName(String userId, String newName) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId/name'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'name': newName}),
    );

    if (response.statusCode != 200) {
      print('Failed to update name. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to update name');
    }
  }

  Future<void> updateUserPassword(String userId, String newPassword) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/users/$userId/password'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'password': newPassword}),
    );

    if (response.statusCode != 200) {
      print('Failed to update password. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to update password');
    }
  }
}

final userApiProvider = Provider<UserApi>((ref) {
  return UserApi();
});