
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/main.dart';
import 'package:hotel_booking/presentation/pages/onboarding_screen.dart';
import 'package:hotel_booking/presentation/pages/signup_page.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

  setUpAll(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'read':
          return ''; // return a mock value for read
        case 'write':
          return null; // return a mock value for write
        case 'delete':
          return null; // return a mock value for delete
        case 'deleteAll':
          return null; // return a mock value for deleteAll
        case 'readAll':
          return {}; // return a mock value for readAll
        default:
          return null;
      }
    });
  });

  tearDownAll(() {
    channel.setMockMethodCallHandler(null); // reset the handler after tests
  });

  testWidgets('Test navigation and presence of widgets on pages', (WidgetTester tester) async {
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(OnBoardingScreen), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.byType(SignUpPage), findsOneWidget);
  });
}
