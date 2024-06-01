import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/presentation/pages/feedback_page.dart';
import 'package:hotel_booking/presentation/pages/home_page.dart';
import 'package:hotel_booking/presentation/pages/settings_page.dart';
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
    await tester.pumpWidget(createWidgetForTesting(SettingsPage()));
    await tester.pumpAndSettle();

    expect(find.byType(AppAppBar), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm Password'), findsOneWidget);

    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
