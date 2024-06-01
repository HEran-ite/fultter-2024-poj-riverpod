import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_booking/presentation/pages/feedback_page.dart';
import 'package:hotel_booking/presentation/pages/login_page.dart';
import 'package:hotel_booking/presentation/pages/settings_page.dart';
import 'package:hotel_booking/presentation/widgets/drawer.dart';

void main() {
  Widget createWidgetForTesting(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: child,
      ),
    );
  }
  testWidgets('SETTINGS navigation navigates properly.',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
        ),
      ),
    );

    ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    // Tap the SETTINGS item and verify navigation
    await tester.ensureVisible(find.text('SETTINGS'));
    await tester.tap(find.text('SETTINGS'));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);
  });
  testWidgets('FEEDBACK navigation navigates properly.',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
        ),
      ),
    );

    ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    // Tap the FEEDBACK item and verify navigation
    await tester.ensureVisible(find.text('FEEDBACK'));
    await tester.tap(find.text('FEEDBACK'));
    await tester.pumpAndSettle();
    expect(find.byType(FeedbackPage), findsOneWidget);
  });


}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Scaffold(
          drawer: AppDrawer(
              ),
          body: Container()),
    ),
    GoRoute(
      path: '/settings_page',
      builder: (context, state) => SettingsPage(),
    ),
    GoRoute(
      path: '/feedback_page',
      builder: (context, state) => FeedbackPage(),
    ),
    GoRoute(
      path: '/login_page',
      builder: (context, state) => LoginPage(),
    ),
  ],
);
