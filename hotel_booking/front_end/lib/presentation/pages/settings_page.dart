import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/presentation/providers/user_provider.dart';
import 'package:hotel_booking/presentation/widgets/appbar.dart';
import 'package:hotel_booking/presentation/widgets/drawer.dart';
import 'package:hotel_booking/presentation/widgets/textfiels.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Retrieve the user information using Riverpod provider
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppAppBar(),
      drawer: AppDrawer(),
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Change your Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
              'Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFieldWidget(
              obscure: false,
              hintText: 'Enter new name',
              onChanged: (value) {
                // Update the user's name when input changes
                ref.read(userProvider.notifier).setName(value);
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Email',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFieldWidget(
              obscure: false,
              hintText: 'Enter new email',
              onChanged: (value) {
                // Update the user's email when input changes
                ref.read(userProvider.notifier).setEmail(value);
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Password',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFieldWidget(
              hintText: 'Enter new password',
              obscure: true,
              onChanged: (value) {
                // Update the user's password when input changes
                ref.read(userProvider.notifier).setPassword(value);
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment:MainAxisAlignment.center,
              
              children: [
                ElevatedButton(
                  onPressed: () {
                
              }, child: Text('Save changes',
                    style: TextStyle(fontSize: 20),
                  ))
              ],
            )
            
            
          ],
          
        ),
      ),
    );
  }
}
