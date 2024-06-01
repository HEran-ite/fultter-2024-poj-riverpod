import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hotel_booking/domain/entities/room.dart';
import 'package:hotel_booking/domain/entities/booking.dart';
import 'package:hotel_booking/presentation/providers/rooms_provider.dart';
import 'package:hotel_booking/presentation/providers/user_provider.dart';
import 'package:hotel_booking/presentation/providers/booking_provider.dart';
import 'package:hotel_booking/presentation/widgets/appbar.dart';
import 'package:hotel_booking/presentation/widgets/booking_card.dart';
import 'package:hotel_booking/presentation/widgets/drawer.dart';

class BookingPage extends ConsumerWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomCategories = ref.watch(roomCategoriesProvider);
    final user = ref.watch(userProvider);
    final bookings = ref.watch(bookingProvider);

    Map<String, List<RoomCategory>> categorizedRooms = {
      'VIP': [],
      'Middle': [],
      'Economy': [],
    };

    for (var room in roomCategories) {
      categorizedRooms[room.category]?.add(room);
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      appBar: AppAppBar(),
      drawer: AppDrawer(),
      body: roomCategories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: categorizedRooms.entries.map((entry) {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        entry.key,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 95, 65, 65),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (entry.value.isNotEmpty)
                        CarouselSlider.builder(
                          options: CarouselOptions(
                            height: 465,
                            enableInfiniteScroll: true,
                            viewportFraction: 1.0,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                          ),
                          itemCount: entry.value.length,
                          itemBuilder: (BuildContext context, int index, int realIndex) {
                            return _buildCard(context, ref, entry.value[index]);
                          },
                        )
                      else
                        Text('No rooms available for this category'),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }

  void _showDatePickerDialog(BuildContext context, WidgetRef ref, RoomCategory category) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      final user = ref.read(userProvider);
      final booking = Booking(
        title: category.title,
        image: category.image,
        description: category.description,
        price: category.price,
        bookingDate: selectedDate,
        user: user!.email, // Assuming user has an email property
      );

      try {
        await ref.read(bookingProvider.notifier).addBooking(booking);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking added successfully')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add booking: $e')));
      }
    }
  }

  Widget _buildCard(BuildContext context, WidgetRef ref, RoomCategory category) {
    return BookingCard(
      category: category,
      showDatePickerCallback: () => _showDatePickerDialog(context, ref, category),
    );
  }
}