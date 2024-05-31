import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../lib/presentation/pages/feedback_page.dart';
import '../../../lib/presentation/widgets/appbar.dart';
import '../../../lib/presentation/widgets/drawer.dart';

void main() {
  Widget createWidgetForTesting(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('signup page renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(const FeedbackPage()));
    expect(find.byType(AppAppBar), findsOneWidget);

    ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    // Verify that the drawer is open and its contents are displayed
    expect(find.byType(AppDrawer), findsOneWidget);

    expect(find.byType(Icon), findsAtLeast(5));

    expect(find.byType(TextField), findsExactly(2));

    expect(find.widgetWithText(ElevatedButton, "Submit"), findsOneWidget);
  });
}
