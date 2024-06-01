import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/presentation/providers/user_provider.dart';
import 'package:hotel_booking/presentation/widgets/appbar.dart';
import 'package:hotel_booking/presentation/widgets/drawer.dart';
import 'package:hotel_booking/presentation/widgets/textfiels.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  String? newPassword;
  String? confirmPassword;
  String? newName;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _saveChanges() {
    if (newPassword != confirmPassword) {
      _showSnackBar("Passwords do not match!");
      return;
    }

    if (newName != null && newName!.isNotEmpty) {
      ref.read(userProvider.notifier).setName(newName!).then((_) {
        _showSnackBar("Name changed successfully");
      }).catchError((error) {
        _showSnackBar("Failed to change name");
      });
    }

    if (newPassword != null && newPassword!.isNotEmpty) {
      ref.read(userProvider.notifier).setPassword(newPassword!).then((_) {
        _showSnackBar("Password changed successfully");
      }).catchError((error) {
        _showSnackBar("Failed to change password");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                newName = value;
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
                newPassword = value;
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Confirm Password',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFieldWidget(
              hintText: 'Confirm new password',
              obscure: true,
              onChanged: (value) {
                confirmPassword = value;
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _saveChanges,
                  child: const Text(
                    'Save changes',
                    style: TextStyle(fontSize: 20),
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



