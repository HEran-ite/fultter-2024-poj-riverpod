import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hotel_booking/presentation/providers/user_provider.dart';
import 'package:hotel_booking/presentation/widgets/appbar.dart';
import 'package:hotel_booking/presentation/widgets/drawer.dart';
import 'booking_page.dart';

final imageListProvider = Provider<List<String>>((ref) {
  return [
    'lib/images/entry.jpeg',
    'lib/images/entry2.jpeg',
    'lib/images/entry3.jpeg',
  ];
});

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size screenSize = MediaQuery.of(context).size;
    final imageList = ref.watch(imageListProvider);
    final user = ref.watch(userProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      appBar: AppAppBar(),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            width: screenSize.width,
            height: screenSize.height * 0.3,
            child: PageView(
              children: imageList
                  .map((image) =>
                      Image.asset(image, key: Key(image), fit: BoxFit.cover))
                  .toList(),
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'WELCOME  TO OASIS HOTEL!',
            style: TextStyle(
              color: Color.fromARGB(255, 95, 65, 65),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: const Text(
              '   Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
              style: TextStyle(
                color: Color.fromARGB(255, 95, 65, 65),
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              context.go('/booking_page');
            },
            child: Text(
              'B O O K',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 93, 64, 50)),
            ),
          ),
        ],
      )),
    );
  }
}


