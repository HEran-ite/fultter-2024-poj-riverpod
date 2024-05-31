import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final roomServiceProvider = Provider<RoomService>((ref) {
  return RoomService();
});

class RoomService {
  final String baseUrl = 'http://localhost:3000/room'; // Your backend URL

  Future<List<Map<String, dynamic>>> fetchRooms() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  Future<void> createRoom(Map<String, dynamic> room) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(room),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create room');
    }
  }

  Future<void> updateRoom(String id, Map<String, dynamic> room) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(room),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update room');
    }
  }

  Future<void> deleteRoom(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete room');
    }
  }
}
