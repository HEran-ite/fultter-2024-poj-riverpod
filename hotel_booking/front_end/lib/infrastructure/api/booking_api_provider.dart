// lib/infrastructure/api/booking_api_provider.dart
import 'package:hotel_booking/domain/entities/booking.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingRemoteDataSource {
  final String baseUrl;

  BookingRemoteDataSource(this.baseUrl);

  Future<List<Booking>> fetchBookings() async {
    final response = await http.get(Uri.parse('$baseUrl/bookings'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Booking.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  Future<void> postBooking(Booking booking) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bookings'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(booking.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to post booking');
    }
  }

  Future<void> updateBooking(String id, Booking booking) async {
    final response = await http.put(
      Uri.parse('$baseUrl/bookings/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(booking.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update booking');
    }
  }

  Future<void> deleteBooking(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/bookings/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete booking');
    }
  }
}
