import 'package:hotel_booking/domain/entities/feedback.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FeedbackRemoteDataSource {
  final String baseUrl;

  FeedbackRemoteDataSource(this.baseUrl);

  Future<List<AppFeedback>> fetchFeedback() async {
    final response = await http.get(Uri.parse('$baseUrl/feedback'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => AppFeedback.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load feedback');
    }
  }

  Future<void> postFeedback(AppFeedback feedback) async {
    final response = await http.post(
      Uri.parse('$baseUrl/feedback'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(feedback.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to post feedback');
    }
  }

  Future<void> updateFeedback(AppFeedback feedback) async {
    final response = await http.put(
      Uri.parse('$baseUrl/feedback/${feedback.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(feedback.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update feedback');
    }
  }

  Future<void> deleteFeedback(String feedbackId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/feedback/$feedbackId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete feedback');
    }
  }
}

