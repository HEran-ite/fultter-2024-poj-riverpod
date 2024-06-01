import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_booking/presentation/providers/user_provider.dart';
import 'presentation/pages/admin_page.dart';
import 'presentation/pages/booking_page.dart';
import 'presentation/pages/feedback_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/onboarding_screen.dart';
import 'presentation/pages/settings_page.dart';
import 'presentation/pages/signup_page.dart';
import 'presentation/pages/status_page.dart';

void main() {
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: 'intro',
          builder: (context, state) => const OnBoardingScreen(),
        ),
        GoRoute(
          path: '/home_page',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/admin_page',
          name: 'admin',
          builder: (context, state) => const AdminPage(),
        ),
        GoRoute(
          path: '/status_page',
          name: 'status',
          builder: (context, state) => const StatusPage(),
        ),
        GoRoute(
          path: '/signup_page',
          name: 'signup',
          builder: (context, state) => const SignUpPage(),
        ),
        GoRoute(
          path: '/login_page',
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/booking_page',
          name: 'booking',
          builder: (context, state) => const BookingPage(),
        ),
        GoRoute(
          path: '/settings_page',
          name: 'settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: '/feedback_page',
          name: 'feedback',
          builder: (context, state) => FeedbackPage(),
        ),
      ],
      initialLocation: '/',
    );
    final userNotifier = ref.read(userProvider.notifier);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
       colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 69, 54, 50),),
       useMaterial3: true,
     ),

    );
  }
}
