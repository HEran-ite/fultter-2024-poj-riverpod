import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import '../../../lib/presentation/pages/booking_page.dart';
import '../../../lib/presentation/pages/feedback_page.dart';
import '../../../lib/presentation/pages/home_page.dart';
import '../../../lib/presentation/pages/login_page.dart';
import '../../../lib/presentation/pages/settings_page.dart';
import '../../../lib/presentation/pages/status_page.dart';
import '../../../lib/presentation/widgets/drawer.dart';

void main() {
  Widget createWidgetForTesting(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('drawer renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(AppDrawer()));

    // Verify user information is displayed
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('user@example.com'), findsOneWidget);

    // Verify the navigation items are displayed
    expect(find.text('HOME'), findsOneWidget);
    expect(find.text('BOOK'), findsOneWidget);
    expect(find.text('Status'), findsOneWidget);
    expect(find.text('SETTINGS'), findsOneWidget);
    expect(find.text('FEEDBACK'), findsOneWidget);
    expect(find.text('LOGOUT'), findsOneWidget);
  });
  testWidgets('AppDrawer navigation items navigate to respective pages',
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

    // Tap the HOME item and verify navigation
    await tester.ensureVisible(find.text('HOME'));
    await tester.tap(find.text('HOME'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
  });
  testWidgets('BOOK navigation navigates properly.',
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

    // Tap the BOOK item and verify navigation
    await tester.ensureVisible(find.text('BOOK'));
    await tester.tap(find.text('BOOK'));
    await tester.pumpAndSettle();
    expect(find.byType(BookingPage), findsOneWidget);
  });
  testWidgets('Status navigation navigates properly.',
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

    // Tap the Status item and verify navigation
    await tester.ensureVisible(find.text('Status'));
    await tester.tap(find.text('Status'));
    await tester.pumpAndSettle();
    expect(find.byType(StatusPage), findsOneWidget);
  });
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

  testWidgets('LOGOUT navigation navigates properly.',
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

    // Tap the LOGOUT item and verify navigation
    await tester.ensureVisible(find.text('LOGOUT'));
    await tester.tap(find.text('LOGOUT'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
  });
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          Scaffold(drawer: AppDrawer(), body: Container()),
    ),
    GoRoute(
      path: '/home_page',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/booking_page',
      builder: (context, state) => BookingPage(),
    ),
    GoRoute(
      path: '/status_page',
      builder: (context, state) => StatusPage(),
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
