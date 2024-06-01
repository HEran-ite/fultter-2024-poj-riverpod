import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/presentation/pages/booking_page.dart';
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
    await tester.pumpWidget(createWidgetForTesting(BookingPage()));

    expect(find.byType(AppAppBar), findsOneWidget);

    ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pump();

    // Verify that the drawer is open and its contents are displayed
    expect(find.byType(AppDrawer), findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
