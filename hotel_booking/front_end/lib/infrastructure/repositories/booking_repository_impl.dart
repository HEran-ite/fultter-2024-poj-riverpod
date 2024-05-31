// lib/infrastructure/repositories/booking_repository_impl.dart

import 'package:hotel_booking/domain/entities/booking.dart';
import 'package:hotel_booking/domain/repositories/booking_repository.dart';
import 'package:hotel_booking/infrastructure/api/booking_api_provider.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Booking>> fetchBookings() async {
    try {
      return await remoteDataSource.fetchBookings();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> postBooking(Booking booking) async {
    try {
      await remoteDataSource.postBooking(booking);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateBooking(String id, Booking booking) async {
    try {
      await remoteDataSource.updateBooking(id, booking);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteBooking(String id) async {
    try {
      await remoteDataSource.deleteBooking(id);
    } catch (e) {
      rethrow;
    }
  }
}
