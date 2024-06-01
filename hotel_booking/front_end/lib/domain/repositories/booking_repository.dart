import 'package:hotel_booking/domain/entities/booking.dart';

abstract class BookingRepository {
  Future<List<Booking>> fetchBookings();
  Future<void> postBooking(Booking booking);
  Future<void> updateBooking(String id, Booking booking);
  Future<void> deleteBooking(String id);
}


