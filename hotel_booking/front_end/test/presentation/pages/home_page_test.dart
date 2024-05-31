import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import '../../../lib/presentation/pages/booking_page.dart';
import '../../../lib/presentation/pages/home_page.dart';
import 'package:hotel_booking/presentation/widgets/appbar.dart';
import 'package:hotel_booking/presentation/widgets/drawer.dart';

void main() {
  Widget createWidgetForTesting(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('Home Page renders widgets properly. ',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(HomePage()));

    await tester.pumpAndSettle();

    expect(find.text('WELCOME  TO OASIS HOTEL!'), findsOneWidget);

    expect(find.byType(AppAppBar), findsOneWidget);

    ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    // Verify that the drawer is open and its contents are displayed
    expect(find.byType(AppDrawer), findsOneWidget);

    expect(find.byType(ElevatedButton), findsOneWidget);

    expect(find.byType(PageView), findsOneWidget);

    expect(find.byType(Image), findsOneWidget);
  });

 testWidgets('HomePage navigates to BookingPage', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerDelegate: _router.routerDelegate,
            routeInformationParser: _router.routeInformationParser,
            routeInformationProvider: _router.routeInformationProvider,
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(BookingPage), findsOneWidget);
    });
  }


final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/booking_page',
      builder: (context, state) => BookingPage(), // Assuming you have a booking page
    ),
  ],
);


