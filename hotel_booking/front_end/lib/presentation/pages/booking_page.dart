// lib/presentation/pages/booking_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hotel_booking/core/utils/datas.dart';
import 'package:hotel_booking/presentation/providers/booking_provider.dart';
import 'package:hotel_booking/presentation/widgets/appbar.dart';
import 'package:hotel_booking/presentation/widgets/booking_card.dart';
import 'package:hotel_booking/presentation/widgets/drawer.dart';


class BookingPage extends ConsumerWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingList = ref.watch(bookingListProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      appBar: AppAppBar(),
      drawer: AppDrawer(),
      body: bookingList.when(
        data: (bookings) {
          return SingleChildScrollView(
            child: Column(
              children: categories.map((category) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      category['title'],
                      style: const TextStyle(
                        color: Color.fromARGB(255, 95, 65, 65),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 465,
                        enableInfiniteScroll: true,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                      ),
                      itemCount: category['images'].length,
                      itemBuilder: (BuildContext context, int index, int realIndex) {
                        return BookingCard(context: context, ref: ref, category: category, index: index);
                      },
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
