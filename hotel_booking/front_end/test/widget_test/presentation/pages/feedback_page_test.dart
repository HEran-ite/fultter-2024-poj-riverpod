import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/presentation/pages/feedback_page.dart';
import 'package:hotel_booking/presentation/pages/home_page.dart';
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
    await tester.pumpWidget(createWidgetForTesting(FeedbackPage()));
    await tester.pumpAndSettle();

    expect(find.byType(AppAppBar), findsOneWidget);
    expect(find.byType(IconButton), findsWidgets);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
