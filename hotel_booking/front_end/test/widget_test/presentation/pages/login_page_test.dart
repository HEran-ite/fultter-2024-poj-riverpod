import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/presentation/pages/login_page.dart';
import 'package:hotel_booking/presentation/widgets/textfiels.dart';

void main() {
  testWidgets('LoginPage has Email and Password TextFields and Login Button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginPage(),
        ),
      ),
    );

    // Verify the presence of email and password text fields
    expect(find.byType(TextFieldWidget), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Verify the presence of login button
    expect(find.text('L O G I N'), findsOneWidget);

    // Verify the presence of sign up link
    expect(find.text('SIGN UP'), findsOneWidget);
  });

  testWidgets('LoginPage can enter email and password',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: LoginPage(),
        ),
      ),
    );

    // Enter email
    await tester.enterText(
        find.widgetWithText(TextFieldWidget, 'Email'), 'test@example.com');
    await tester.pump();

    // Enter password
    await tester.enterText(
        find.widgetWithText(TextFieldWidget, 'Password'), 'password123');
    await tester.pump();

    // Verify entered text
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('password123'), findsOneWidget);
  });
}
