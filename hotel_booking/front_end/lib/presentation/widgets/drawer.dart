import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/presentation/providers/user_provider.dart'; // Import the necessary package

class AppDrawer extends ConsumerWidget { // Change from StatelessWidget to ConsumerWidget
  @override
  Widget build(BuildContext context, WidgetRef ref) { // Change build method signature
    final user = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(),
            accountName: Text(
              user.name.isEmpty ? 'Loading...' : user.name,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              user.email.isEmpty ? '' : user.email,
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: const CircleAvatar(child: Icon(Icons.person)),
          ),

          // Customer-specific items
          if (user.role == 'customer') ...[
            ListTile(
              onTap: () {
                context.go('/home_page'); // Use context.go for navigation
              },
              leading: const Icon(Icons.home),
              title: const Text('HOME'),
            ),
            ListTile(
              onTap: () {
                context.go('/booking_page'); // Use context.go for navigation
              },
              leading: const Icon(Icons.book_online),
              title: const Text('BOOK'),
            ),
            ListTile(
              onTap: () {
                context.go('/status_page');
              },
              leading: const Icon(Icons.label),
              title: const Text('Status'),
            ),
          ],

          // Shared items for both admin and customer
          ListTile(
            onTap: () {
              context.go('/settings_page');
            },
            leading: const Icon(Icons.settings),
            title: const Text('SETTINGS'),
          ),
          ListTile(
            onTap: () {
              context.go('/feedback_page');
            },
            leading: const Icon(Icons.feedback),
            title: const Text('FEEDBACK'),
          ),

          // Admin-specific items
          if (user.role == 'admin') ...[
            ListTile(
              onTap: () {
                context.go('/admin_page');
              },
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text('EDIT'),
            ),
          ],

          // Shared logout item for both roles
          ListTile(
            onTap: () async {
              await userNotifier.logout();
              context.go('/login_page');
            },
            leading: const Icon(Icons.logout),
            title: const Text('LOGOUT'),
          ),
        ],
      ),
    );
  }
}