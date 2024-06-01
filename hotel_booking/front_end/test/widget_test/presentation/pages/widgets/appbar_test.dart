import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_booking/presentation/pages/login_page.dart';
import 'package:hotel_booking/presentation/widgets/appbar.dart';

void main() {
  Widget createWidgetForTesting(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('AppAppBar displays title and logout button',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(AppAppBar()));

    // Verify the title text is displayed
    expect(find.text('Oasis Hotel'), findsOneWidget);

    // Verify the logout button is displayed
    expect(find.byIcon(Icons.logout), findsOneWidget);
  });

  // testWidgets('AppAppBar logout button navigates to login page',
  //     (WidgetTester tester) async {
  //   final GoRouter router = GoRouter(
  //     routes: [
  //       GoRoute(
  //         path: '/',
  //         builder: (context, state) => AppAppBar(),
  //       ),
  //       GoRoute(
  //         path: '/login_page',
  //         builder: (context, state) => const LoginPage(),
  //       ),
  //     ],
  //   );

  //     await tester.pumpWidget(
  //           ProviderScope(
  //             child: MaterialApp.router(
  //               routerDelegate: router.routerDelegate,
  //               routeInformationParser: router.routeInformationParser,
  //               routeInformationProvider: router.routeInformationProvider,
  //             ),
  //           ),
  //         );


  //   // Tap the logout button
  //   await tester.tap(find.byIcon(Icons.logout));
  //   await tester.pumpAndSettle();

  //   // Verify navigation to login page
  //   expect(find.byType(LoginPage), findsOneWidget);
  // });
}
