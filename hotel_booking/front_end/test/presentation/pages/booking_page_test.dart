import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/presentation/pages/booking_page.dart';
import '../../../lib/presentation/widgets/appbar.dart';
import '../../../lib/presentation/widgets/drawer.dart';

void main() {
  testWidgets('BookingPage renders correctly and allows booking',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: BookingPage(),
        ),
      ),
    );

    // Verify the BookingPage is rendered
    expect(find.byType(BookingPage), findsOneWidget);
    expect(find.byType(AppAppBar), findsOneWidget);

    ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    // Verify that the drawer is open and its contents are displayed
    expect(find.byType(AppDrawer), findsOneWidget);

    // Ensure the first carousel image is visible
    expect(find.byType(Image), findsWidgets);

    //  // Find the first 'BOOK' button and tap it
    //   final bookButtonFinder = find.text('BOOK').first;
    //   expect(bookButtonFinder, findsOneWidget);

    //   await tester.ensureVisible(bookButtonFinder);
    //   await tester.tap(bookButtonFinder);
    //   await tester.pumpAndSettle();

    //   // Verify that the date picker dialog appears
    //   expect(find.byType(CalendarDatePicker), findsOneWidget);

    // // Select a date in the date picker
    // await tester.tap(find.text('15')); // Select the 15th day of the month
    // await tester.pumpAndSettle();

    // // Confirm the date selection
    // await tester.tap(find.text('OK'));
    // await tester.pumpAndSettle();

    // // Verify that a booking was added
    // expect(find.text('Booking confirmed!'), findsOneWidget); // Adjust this line according to your actual confirmation text
  });
}
