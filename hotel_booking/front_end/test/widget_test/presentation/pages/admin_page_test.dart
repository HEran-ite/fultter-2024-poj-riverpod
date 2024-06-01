import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_booking/domain/entities/user_data.dart';
import 'package:hotel_booking/presentation/pages/admin_page.dart';
import 'package:hotel_booking/presentation/providers/rooms_provider.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([RoomCategoriesNotifier, User])
void main() {
  Widget createWidgetForTesting(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('admin page renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(const AdminPage()));
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
  });
  
  }
