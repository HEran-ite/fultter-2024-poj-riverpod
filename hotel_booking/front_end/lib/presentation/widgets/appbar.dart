
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_booking/application/use_cases/user_api_provider.dart';
import 'package:hotel_booking/presentation/providers/user_provider.dart';

class AppAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) { // Add WidgetRef parameter
    final userNotifier = ref.read(userProvider.notifier);
    return AppBar(
      title: const Text(
        'Oasis Hotel',
        style: TextStyle(
          color: Color.fromARGB(255, 95, 65, 65),
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await userNotifier.logout();
            context.go('/login_page');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}