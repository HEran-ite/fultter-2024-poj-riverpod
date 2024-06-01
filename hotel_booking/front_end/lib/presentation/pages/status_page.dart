import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/booking.dart';
import 'package:hotel_booking/presentation/providers/booking_provider.dart';
import 'package:hotel_booking/presentation/providers/user_provider.dart';
import 'package:hotel_booking/presentation/widgets/appbar.dart';
import 'package:hotel_booking/presentation/widgets/drawer.dart';

class StatusPage extends ConsumerWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final bookings = ref.watch(bookingProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      appBar: AppAppBar(),
      drawer: user != null
          ? AppDrawer()
          : null,
      body: bookings.isEmpty
          ? Center(child: Text('No bookings found'))
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Card(
                  color: const Color.fromARGB(255, 244, 229, 212),
                  margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.memory(
                          base64Decode(booking.image),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          booking.title,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 95, 65, 65),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Date: ${booking.bookingDate?.toString().split(' ')[0]}',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 95, 65, 65),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _showEditDialog(context, ref, booking);
                              },
                              child: const Text(
                                'Edit',
                                style: TextStyle(color: Colors.blue),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 231, 228, 226),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                _confirmDelete(context, ref, booking);
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Color.fromARGB(255, 243, 33, 33)),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 231, 228, 226),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Booking booking) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: booking.bookingDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      final updatedBooking = booking.copyWith(bookingDate: selectedDate);
      try {
        await ref.read(bookingProvider.notifier).updateBooking(booking.id!, updatedBooking);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking updated successfully')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update booking: $e')));
      }
    }
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, Booking booking) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this booking?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () async {
                try {
                  await ref.read(bookingProvider.notifier).deleteBooking(booking.id!);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking deleted successfully')));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete booking: $e')));
                } finally {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}