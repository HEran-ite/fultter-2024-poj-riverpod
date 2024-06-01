import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_booking/presentation/pages/login_page.dart';
import 'package:hotel_booking/presentation/pages/signup_page.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'login_page_test.mocks.dart';

class UserService {
  Future<String> fetchUserName(int userId) async {
    // Simulates a network call
    await Future.delayed(const Duration(seconds: 1));
    return 'User_$userId';
  }
}



@GenerateMocks([UserService])
void main() {
  testWidgets('LoginPage sign up link navigates to SignUpPage',
      (WidgetTester tester) async {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/signup_page',
          builder: (context, state) =>
              const SignUpPage(),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );
    await tester.ensureVisible(find.text('SIGN UP'));
    await tester.pumpAndSettle();
    // Tap the sign-up link
    await tester.tap(find.text('SIGN UP'));
    await tester.pumpAndSettle();

    // Verify navigation to SignUpPage
    expect(find.byType(SignUpPage), findsOneWidget);
  });

  group('UserService', () {
    MockUserService mockUserService = MockUserService();

    setUp(() {
      mockUserService = MockUserService();
    });

    test('fetchUserName returns correct username', () async {
      // Arrange: Set up the mock to return a specific value when called
      when(mockUserService.fetchUserName(1)).thenAnswer((_) async => 'Mocked_User_1');

      // Act: Call the method on the mock object
      final userName = await mockUserService.fetchUserName(1);

      // Assert: Verify the result
      expect(userName, equals('Mocked_User_1'));
    });

    test('fetchUserName throws an exception', () async {
      // Arrange: Set up the mock to throw an exception when called
      when(mockUserService.fetchUserName(1)).thenThrow(Exception('Network error'));

      // Act & Assert: Verify that the exception is thrown
      expect(() => mockUserService.fetchUserName(1), throwsException);
    });
  });
  // testWidgets('LoginPage login button navigates to HomePage',
  //     (WidgetTester tester) async {
  //   final GoRouter router = GoRouter(
  //     routes: [
  //       GoRoute(
  //         path: '/',
  //         builder: (context, state) => const LoginPage(),
  //       ),
  //       GoRoute(
  //         path: '/home_page',
  //         builder: (context, state) =>
  //             const HomePage(),
  //       ),
  //     ],
  //   );

  //   await tester.pumpWidget(
  //     ProviderScope(
  //       child: MaterialApp.router(
  //         routerConfig: router,
  //       ),
  //     ),
  //   );

  //   // Tap the login button
  //   await tester.tap(find.text('L O G I N'));
  //   await tester.pumpAndSettle();

  //   // Verify navigation to HomePage
  //   expect(find.byType(HomePage), findsOneWidget);
  // });
}
