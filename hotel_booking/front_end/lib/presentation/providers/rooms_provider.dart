import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/room.dart';
import 'package:hotel_booking/application/use_cases/room_service.dart';

final roomCategoriesProvider = StateNotifierProvider<RoomCategoriesNotifier, List<RoomCategory>>((ref) {
  return RoomCategoriesNotifier(ref);
});


class RoomCategoriesNotifier extends StateNotifier<List<RoomCategory>> {
  final Ref _ref;

  RoomCategoriesNotifier(this._ref) : super([]) {
    fetchRooms();
  }

  Future<void> fetchRooms() async {
    try {
      final roomService = _ref.read(roomServiceProvider);
      final response = await roomService.fetchRooms();

      print('Raw response: $response');

      if (response != null && response is List) {
        final rooms = List<Map<String, dynamic>>.from(response);
        state = rooms.map((room) => RoomCategory.fromJson(room)).toList();
      } else {
        print('Failed to fetch rooms: Response is null or not a list');
      }
    } catch (e) {
      print('Failed to fetch rooms: $e');
    }
  }

  Future<void> addCategory(String title, String base64Image, String description, int price, String category) async {
    final newRoom = {
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'image': base64Image,
    };

    try {
      final roomService = _ref.read(roomServiceProvider);
      await roomService.createRoom(newRoom);
      fetchRooms();
    } catch (e) {
      print('Failed to add room: $e');
    }
  }

  Future<void> updateCategory(String id, String title, String description, int price, String base64Image, String category) async {
    final updatedRoom = {
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'image': base64Image,
    };

    try {
      final roomService = _ref.read(roomServiceProvider);
      await roomService.updateRoom(id, updatedRoom);
      fetchRooms();
    } catch (e) {
      print('Failed to update room: $e');
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      final roomService = _ref.read(roomServiceProvider);
      await roomService.deleteRoom(id);
      fetchRooms();
    } catch (e) {
      print('Failed to delete room: $e');
    }
  }
}
