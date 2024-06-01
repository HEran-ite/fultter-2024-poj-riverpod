import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
}
