import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hotel_booking/domain/entities/room.dart';
import 'package:hotel_booking/presentation/providers/rooms_provider.dart';
import 'package:hotel_booking/presentation/providers/user_provider.dart';
import 'package:hotel_booking/presentation/widgets/appbar.dart';
import 'package:hotel_booking/presentation/widgets/drawer.dart';
import 'package:hotel_booking/presentation/widgets/editroom.dart';
import 'package:hotel_booking/presentation/widgets/newroom.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomCategories = ref.watch(roomCategoriesProvider);
    final user = ref.watch(userProvider);

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 252, 241, 230),
        tooltip: 'Add New Room',
        onPressed: () {
          showAddNewDialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

Widget _buildCard(BuildContext context, WidgetRef ref, RoomCategory category) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 40),
    color: const Color.fromARGB(255, 244, 229, 212),
    elevation: 5.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.memory(
            base64Decode(category.image),
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const Divider(color: Color.fromARGB(255, 208, 188, 188)),
          Text(
            category.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color.fromARGB(255, 95, 65, 65),
            ),
          ),
          Text(
            'Price: \$${category.price}',
            style: const TextStyle(
              color: Color.fromARGB(255, 95, 65, 65),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => showEditDialog(context, ref, category),
                child: const Text(
                  'Edit',
                  style: TextStyle(color: Colors.blue),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 231, 228, 226),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  ref.read(roomCategoriesProvider.notifier).deleteCategory(category.id);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Color.fromARGB(255, 243, 33, 33)),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 231, 228, 226),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}

