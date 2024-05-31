// lib/presentation/widgets/booking_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/booking.dart';
import 'package:hotel_booking/presentation/providers/booking_provider.dart';

class BookingCard extends StatelessWidget {
  final BuildContext context;
  final WidgetRef ref;
  final Map<String, dynamic> category;
  final int index;

  BookingCard({
    required this.context,
    required this.ref,
    required this.category,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      color: const Color.fromARGB(255, 244, 229, 212),
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              category['images'][index],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const Divider(color: Color.fromARGB(255, 208, 188, 188)),
            Text(
              category['descriptions'][index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 95, 65, 65),
              ),
            ),
            Text(
              'Price: \$${category['prices'][index]}',
              style: const TextStyle(
                color: Color.fromARGB(255, 95, 65, 65),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showDatePickerDialog(context, ref, category, index);
              },
              child: const Text(
                'BOOK',
                style: TextStyle(color: Color.fromARGB(255, 99, 76, 76)),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 235, 231, 229)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePickerDialog(BuildContext context, WidgetRef ref, Map<String, dynamic> category, int index) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      final booking = Booking(
        title: category['title'],
        image: category['images'][index],
        description: category['descriptions'][index],
        price: category['prices'][index],
        bookingDate: selectedDate,
      );

      await ref.read(bookingProvider.notifier).addBooking(booking);
    }
  }
}
