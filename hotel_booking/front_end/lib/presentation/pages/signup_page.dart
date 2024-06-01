import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/signup.dart';
import 'package:hotel_booking/presentation/providers/signup_provider.dart';
import 'package:hotel_booking/presentation/widgets/textfiels.dart';
import 'package:hotel_booking/presentation/providers/user_provider.dart';

final signupNotifierProvider =
    StateNotifierProvider<SignupNotifier, SignupState>((ref) => SignupNotifier());

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupNotifierProvider);
    final signupNotifier = ref.read(signupNotifierProvider.notifier);

    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: screenSize.width,
              height: screenSize.height * 0.325,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/bgc_hotel.jpeg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(400),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Sign Up',
              style: TextStyle(
                color: Color.fromARGB(255, 95, 65, 65),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ToggleButtons(
                isSelected: [signupState.isAdmin, !signupState.isAdmin],
                onPressed: (int index) {
                  signupNotifier.setIsAdmin(index == 0);
                },
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('ADMIN'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('User'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              hintText: "Full Name",
              obscure: false,
              onChanged: (value) {
                signupNotifier.setFullName(value);
              },
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              hintText: "Email",
              obscure: false,
              onChanged: (value) {
                signupNotifier.setEmail(value);
              },
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              hintText: "Password",
              obscure: true,
              onChanged: (value) {
                signupNotifier.setPassword(value);
              },
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              hintText: "Confirm Password",
              obscure: true,
              onChanged: (value) {
                signupNotifier.setConfirmPassword(value);
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an Account?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 95, 65, 65),
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.go('/login_page');
                  },
                  child: const Text(
                    'LOG IN',
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(userProvider.notifier).signup(signupState);
                  final userRole = ref.read(userProvider).role;
                  if (userRole == 'admin') {
                    context.go('/admin_page');
                  } else {
                    context.go('/home_page');
                  }
                } catch (e) {
                  print('Sign-up failed: $e');
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 93, 64, 50)),
              ),
              child: const Text(
                'SIGN UP',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}