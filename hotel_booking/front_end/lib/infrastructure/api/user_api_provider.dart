import 'dart:convert';
import 'package:hotel_booking/domain/entities/signup.dart';
import 'package:hotel_booking/domain/entities/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';

const String baseUrl = 'http://localhost:3000'; // Replace with your backend URL

class UserApi {
  Future<void> signup(SignupState signupState) async {
    // Check if the password and confirmed password match
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
    print(email + password);
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');
    
    if (response.statusCode == 200 || response.statusCode == 201) {  // Handle both 200 and 201 status codes
      final data = jsonDecode(response.body);
      print('Response Data: $data');
      return data['token']; // Return the token
    } else {
      throw Exception('Failed to log in');
    }
  }

  Future<User> getUserById(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to fetch user data');
    }
  }
}

final userApiProvider = Provider<UserApi>((ref) {
  return UserApi();
});
