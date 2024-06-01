import 'package:hotel_booking/application/use_cases/booking_api_provider.dart';
import 'package:hotel_booking/domain/entities/booking.dart';
import 'package:hotel_booking/domain/repositories/booking_repository.dart';


class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Booking>> fetchBookings() async {
    return await remoteDataSource.fetchBookings();
  }

  @override
  Future<void> postBooking(Booking booking) async {
    await remoteDataSource.postBooking(booking);
  }

  @override
  Future<void> updateBooking(String id, Booking booking) async {
    await remoteDataSource.updateBooking(id, booking);
  }

  @override
  Future<void> deleteBooking(String id) async {
    await remoteDataSource.deleteBooking(id);
  }
}