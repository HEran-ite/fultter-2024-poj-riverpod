import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/presentation/pages/admin_page.dart';
import 'package:hotel_booking/presentation/pages/home_page.dart';
import 'package:hotel_booking/presentation/pages/login_page.dart';
import 'package:hotel_booking/presentation/pages/signup_page.dart';
import 'package:hotel_booking/presentation/widgets/textfiels.dart';

void main() {
  Widget createWidgetForTesting(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('signup page renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(const SignUpPage()));
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('ADMIN'), findsOneWidget);
    expect(find.text('User'), findsOneWidget);
    expect(find.byType(TextFieldWidget), findsNWidgets(4));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('SIGN UP'), findsOneWidget);
  });
  testWidgets('Toggling between admin and user', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(SignUpPage()));

    expect(find.byType(ToggleButtons), findsOneWidget);
    await tester.tap(find.text('User'));
    await tester.pump();
    // Check the state change
    expect(find.text('ADMIN'), findsOneWidget);
    expect(find.text('User'), findsOneWidget);
  });

  testWidgets('SignupPage navigates to LoginPage', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
          routeInformationProvider: _router.routeInformationProvider,
        ),
      ),
    );

    expect(find.byKey(const Key('login_text')), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('login_link')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('login_link')));
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
  });

  // testWidgets('SignupPage navigates to HomePage for normal user',
  //     (WidgetTester tester) async {
  //   await tester.pumpWidget(
  //     ProviderScope(
  //       child: MaterialApp.router(
  //         routerDelegate: _router.routerDelegate,
  //         routeInformationParser: _router.routeInformationParser,
  //         routeInformationProvider: _router.routeInformationProvider,
  //       ),
  //     ),
  //   );

  //   // Ensure the SignUpPage is displayed
  //   expect(find.byType(SignUpPage), findsOneWidget);

  //   // Toggle to 'Admin'
  //   await tester.tap(find.text('User'));
  //   await tester.pumpAndSettle();

  //   // Ensure 'Admin' is selected
  //   // expect(find.widgetWithText(ToggleButtons, 'User'), findsOneWidget);

  //   // Ensure the ElevatedButton is visible
  //   await tester.ensureVisible(find.byType(ElevatedButton));
  //   await tester.pumpAndSettle();

  //   // Tap on the 'SIGN UP' button
  //   await tester.tap(find.byType(ElevatedButton));
  //   await tester.pumpAndSettle();

  //   // Verify navigation to AdminPage
  //   expect(find.byType(HomePage), findsOneWidget);
  // });

  // testWidgets('SignupPage navigates to Admin for admin user',
  //     (WidgetTester tester) async {
  //   await tester.pumpWidget(
  //     ProviderScope(
  //       child: MaterialApp.router(
  //         routerDelegate: _router.routerDelegate,
  //         routeInformationParser: _router.routeInformationParser,
  //         routeInformationProvider: _router.routeInformationProvider,
  //       ),
  //     ),
  //   );

  //   // Ensure the ElevatedButton is visible
  //   await tester.ensureVisible(find.byType(ElevatedButton));
  //   await tester.pumpAndSettle();

  //   // Tap on the 'SIGN UP' button
  //   await tester.tap(find.byType(ElevatedButton));
  //   await tester.pumpAndSettle();

  //   // Verify navigation to HomePage
  //   expect(find.byType(AdminPage), findsOneWidget);
  // });
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/login_page',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/admin_page',
      builder: (context, state) => const AdminPage(),
    ),
    GoRoute(
      path: '/home_page',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
