import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/application/use_cases/booking_api_provider.dart';
import 'package:hotel_booking/domain/entities/booking.dart';
import 'package:hotel_booking/domain/repositories/booking_repository.dart';
import 'package:hotel_booking/domain/repositories/booking_repository_impl.dart';

final bookingRemoteDataSourceProvider = Provider<BookingRemoteDataSource>((ref) {
  return BookingRemoteDataSource(); // Update URL if needed
});

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  final bookingRemoteDataSource = ref.watch(bookingRemoteDataSourceProvider);
  return BookingRepositoryImpl(bookingRemoteDataSource);
});

final bookingListProvider = FutureProvider<List<Booking>>((ref) async {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  return bookingRepository.fetchBookings();
});



class BookingNotifier extends StateNotifier<List<Booking>> {
  final BookingRepository bookingRepository;

  BookingNotifier(this.bookingRepository) : super([]) {
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    try {
      final bookings = await bookingRepository.fetchBookings();
      state = bookings;
    } catch (e) {
      print('Failed to fetch bookings: $e');
    }
  }

  Future<void> addBooking(Booking booking) async {
    try {
      await bookingRepository.postBooking(booking);
      await fetchBookings(); // Fetch updated list
    } catch (e) {
      print('Failed to add booking: $e');
    }
  }

  Future<void> updateBooking(String id, Booking booking) async {
    try {
      await bookingRepository.updateBooking(id, booking);
      await fetchBookings(); // Fetch updated list
    } catch (e) {
      print('Failed to update booking: $e');
    }
  }

  Future<void> deleteBooking(String id) async {
    try {
      await bookingRepository.deleteBooking(id);
      await fetchBookings(); // Fetch updated list
    } catch (e) {
      print('Failed to delete booking: $e');
    }
  }
}

final bookingProvider = StateNotifierProvider<BookingNotifier, List<Booking>>((ref) {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  return BookingNotifier(bookingRepository);
});