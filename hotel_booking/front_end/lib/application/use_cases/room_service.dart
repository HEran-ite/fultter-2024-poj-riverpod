import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final roomServiceProvider = Provider<RoomService>((ref) {
  return RoomService();
});

class RoomService {
  final String baseUrl = 'http://localhost:3000/room'; // Ensure this URL is correct
  final storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await storage.read(key: 'user_token');
  }

  Future<List<Map<String, dynamic>>> fetchRooms() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic>? data = json.decode(response.body);
      if (data == null) {
        throw Exception('Failed to load rooms: Data is null');
      }
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load rooms: ${response.body}');
    }
  }

  Future<void> createRoom(Map<String, dynamic> room) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(room),
    );

    if (response.statusCode != 201) {
      print('Failed to create room: ${response.body}'); // Debugging print statement
      throw Exception('Failed to create room');
    }
  }

  Future<void> updateRoom(String id, Map<String, dynamic> room) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(room),
    );

    if (response.statusCode != 200) {
      print('Failed to update room: ${response.body}'); // Debugging print statement
      throw Exception('Failed to update room');
    }
  }

  Future<void> deleteRoom(String id) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      print('Failed to delete room: ${response.body}'); // Debugging print statement
      throw Exception('Failed to delete room');
    }
  }
}
