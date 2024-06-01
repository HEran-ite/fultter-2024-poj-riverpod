import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/presentation/widgets/drawer.dart';

void main() {
  Widget createWidgetForTesting(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('drawer renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(AppDrawer(
        // userName: 'john',
        // userEmail: 'john@user.com',
        // userRole: 'User',
        )));

    // Verify user information is displayed
    // expect(find.text('john'), findsOneWidget);
    // expect(find.text('john@user.com'), findsOneWidget);

    // Verify the navigation items are displayed
    expect(find.text('SETTINGS'), findsOneWidget);
    expect(find.text('FEEDBACK'), findsOneWidget);
    expect(find.text('LOGOUT'), findsOneWidget);
  });
}
