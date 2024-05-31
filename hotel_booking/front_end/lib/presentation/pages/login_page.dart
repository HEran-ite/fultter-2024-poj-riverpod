import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_booking/domain/entities/user_data.dart';
import 'package:hotel_booking/presentation/providers/login_provider.dart';
import 'package:hotel_booking/presentation/widgets/textfiels.dart';

import 'package:jwt_decode/jwt_decode.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginNotifierProvider);
    final loginNotifier = ref.read(loginNotifierProvider.notifier);

    // Determine screen size
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: screenSize.width,
              height: screenSize.height * 0.45,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/bgc_hotel.jpeg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(300),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Log in',
              style: TextStyle(
                color: Color.fromARGB(255, 95, 65, 65),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            TextFieldWidget(
              hintText: "Email",
              obscure: false,
              onChanged: (value) {
                loginNotifier.setEmail(value);
              },
            ),
            const SizedBox(height: 30),
            TextFieldWidget(
              hintText: 'Password',
              obscure: true,
              onChanged: (value) {
                loginNotifier.setPassword(value);
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account? ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 95, 65, 65),
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.go('/signup_page');
                  },
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(
                      color: Color.fromARGB(255, 95, 65, 65),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                try {
                  final result = await loginNotifier.login();
                  final token = result['token'] as String;
                  final user = result['user'] as User;

                  // Decode the token and access the user role
                  Map<String, dynamic> payload = Jwt.parseJwt(token);
                  String role = payload['role'];

                  print('Navigating based on role: $role');

                  if (role == 'admin') {
                    context.go('/admin_page');
                  } else if (role == 'customer') {
                    context.go('/home_page');
                  } else {
                    throw Exception('Unknown role');
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login failed: ${e.toString()}')),
                  );
                }
              },
              child: const Text(
                'L O G I N',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 93, 64, 50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
