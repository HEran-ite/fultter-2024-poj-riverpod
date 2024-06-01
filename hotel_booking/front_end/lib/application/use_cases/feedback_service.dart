import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hotel_booking/domain/entities/feedback.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackService {
  final String baseUrl = 'http://localhost:3000/feedback'; // Ensure this URL is correct
  final storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await storage.read(key: 'user_token');
  }

  Future<List<AppFeedback>> fetchFeedback() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => AppFeedback.fromJson(json)).toList();
    } else {
      print('Failed to load feedback: ${response.statusCode} ${response.body}');
      throw Exception('Failed to load feedback');
    }
  }

  Future<void> postFeedback(AppFeedback feedback) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(feedback.toJson()),
    );

    print('Post feedback response status: ${response.statusCode}');
    print('Post feedback response body: ${response.body}');

    if (response.statusCode != 201) {
      throw Exception('Failed to post feedback');
    }
  }

  Future<void> updateFeedback(AppFeedback feedback) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/${feedback.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(feedback.toJson()),
    );

    print('Update feedback response status: ${response.statusCode}');
    print('Update feedback response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update feedback');
    }
  }

  Future<void> deleteFeedback(String feedbackId) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/$feedbackId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print('Delete feedback response status: ${response.statusCode}');
    print('Delete feedback response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete feedback');
    }
  }
}

final feedbackServiceProvider = Provider<FeedbackService>((ref) {
  return FeedbackService();
});