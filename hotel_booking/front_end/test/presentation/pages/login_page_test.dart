import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import '../../../lib/presentation/pages/home_page.dart';
import '../../../lib/presentation/pages/login_page.dart';
import '../../../lib/presentation/pages/signup_page.dart';
import '../../../lib/presentation/widgets/textfiels.dart';

void main() {
  testWidgets('LoginPage has Email and Password TextFields and Login Button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: LoginPage(),
        ),
      ),
    );

    // Verify the presence of email and password text fields
    expect(find.byType(TextFieldWidget), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Verify the presence of login button
    expect(find.text('L O G I N'), findsOneWidget);

    // Verify the presence of sign up link
    expect(find.text('SIGN UP'), findsOneWidget);
  });

  testWidgets('LoginPage can enter email and password',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: LoginPage(),
        ),
      ),
    );

    // Enter email
    await tester.enterText(
        find.widgetWithText(TextFieldWidget, 'Email'), 'test@example.com');
    await tester.pump();

    // Enter password
    await tester.enterText(
        find.widgetWithText(TextFieldWidget, 'Password'), 'password123');
    await tester.pump();

    // Verify entered text
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('password123'), findsOneWidget);
  });

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

  testWidgets('LoginPage login button navigates to HomePage',
      (WidgetTester tester) async {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/home_page',
          builder: (context, state) =>
              const HomePage(),
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

    // Tap the login button
    await tester.tap(find.text('L O G I N'));
    await tester.pumpAndSettle();

    // Verify navigation to HomePage
    expect(find.byType(HomePage), findsOneWidget);
  });
}
