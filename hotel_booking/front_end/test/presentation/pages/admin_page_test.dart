import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/presentation/pages/admin_page.dart';
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

  testWidgets('admin page renders page correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(AdminPage()));
    expect(find.byType(AppAppBar), findsOneWidget);

    ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();
    expect(find.byType(AppDrawer), findsOneWidget);
    expect(find.byType(Card), findsWidgets);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
    expect(find.widgetWithText(ElevatedButton, 'Edit'), findsWidgets);
    expect(find.widgetWithText(ElevatedButton, 'Delete'), findsWidgets);

    // await tester.ensureVisible(find.byType(FloatingActionButton));
    // await tester.pumpAndSettle();

    // await tester.tap(find.byType(FloatingActionButton));
    // await tester.pumpAndSettle();

    // expect(find.byType(AlertDialog), findsOneWidget);
    // expect(find.text('Add New Room'), findsOneWidget);

    // await tester.ensureVisible(find.text('Edit').first);
    // await tester.pumpAndSettle();

    // await tester.tap(find.text('Edit').first);
    // await tester.pumpAndSettle();

    // // Assuming showEditDialog pops up a dialog
    // expect(find.byType(AlertDialog), findsOneWidget);
    // expect(find.text('Edit Room'), findsOneWidget);
  });
}
