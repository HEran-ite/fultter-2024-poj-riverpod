import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hotel_booking/domain/entities/booking.dart';
import 'package:http/http.dart' as http;

class BookingRemoteDataSource {
  final String baseUrl = 'http://localhost:3000'; // Replace with your backend URL
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    String? token = await secureStorage.read(key: 'user_token');
    print('Retrieved token: $token'); // Debugging print statement
    return token;
  }

  Future<List<Booking>> fetchBookings() async {
    try {
      final token = await _getToken();
      if (token == null) throw 'No auth token found';

      final response = await http.get(
        Uri.parse('$baseUrl/bookings'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Fetched bookings JSON: $data'); // Debugging print statement
        return data.map((json) => Booking.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        print('Failed to fetch bookings. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch bookings');
      }
    } catch (e) {
      print('Failed to fetch bookings: $e');
      rethrow;
    }
  }

  Future<void> postBooking(Booking booking) async {
    try {
      final token = await _getToken();
      if (token == null) throw 'No auth token found';

      final response = await http.post(
        Uri.parse('$baseUrl/bookings'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(booking.toJson()),
      );

      if (response.statusCode != 201) {
        print('Failed to add booking. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to add booking');
      }
    } catch (e) {
      print('Failed to add booking: $e');
      rethrow;
    }
  }

  Future<void> updateBooking(String id, Booking booking) async {
    try {
      final token = await _getToken();
      if (token == null) throw 'No auth token found';

      final response = await http.put(
        Uri.parse('$baseUrl/bookings/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(booking.toJson()),
      );

      if (response.statusCode != 200) {
        print('Failed to update booking. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update booking');
      }
    } catch (e) {
      print('Failed to update booking: $e');
      rethrow;
    }
  }

  Future<void> deleteBooking(String id) async {
    try {
      final token = await _getToken();
      if (token == null) throw 'No auth token found';

      final response = await http.delete(
        Uri.parse('$baseUrl/bookings/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        print('Failed to delete booking. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to delete booking');
      }
    } catch (e) {
      print('Failed to delete booking: $e');
      rethrow;
    }
  }
}