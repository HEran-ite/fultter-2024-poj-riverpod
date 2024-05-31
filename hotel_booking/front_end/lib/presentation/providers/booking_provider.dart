// lib/presentation/providers/booking_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/booking.dart';
import 'package:hotel_booking/domain/repositories/booking_repository.dart';
import 'package:hotel_booking/infrastructure/api/booking_api_provider.dart';
import 'package:hotel_booking/infrastructure/repositories/booking_repository_impl.dart';

// Booking Remote Data Source Provider
final bookingRemoteDataSourceProvider = Provider<BookingRemoteDataSource>((ref) {
  return BookingRemoteDataSource('http://localhost:3000'); // Change to your backend URL
});

// Booking Repository Provider
final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  final bookingRemoteDataSource = ref.watch(bookingRemoteDataSourceProvider);
  return BookingRepositoryImpl(bookingRemoteDataSource);
});

// Booking List Provider
final bookingListProvider = FutureProvider<List<Booking>>((ref) async {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  return bookingRepository.fetchBookings();
});

// Booking Notifier
class BookingNotifier extends StateNotifier<List<Booking>> {
  final BookingRepository bookingRepository;

  BookingNotifier(this.bookingRepository) : super([]);

  Future<void> fetchBookings() async {
    state = await bookingRepository.fetchBookings();
  }

  Future<void> addBooking(Booking booking) async {
    await bookingRepository.postBooking(booking);
    state = [...state, booking];
  }

  Future<void> updateBooking(String id, Booking booking) async {
    await bookingRepository.updateBooking(id, booking);
    state = [
      for (final b in state)
        if (b.id == id) booking else b,
    ];
  }

  Future<void> deleteBooking(String id) async {
    await bookingRepository.deleteBooking(id);
    state = state.where((b) => b.id != id).toList();
  }

  void updateBookingDate(int index, DateTime selectedDate) {}
}

final bookingProvider = StateNotifierProvider<BookingNotifier, List<Booking>>((ref) {
  final bookingRepository = ref.watch(bookingRepositoryProvider);
  return BookingNotifier(bookingRepository);
});
