import 'package:hotel_booking/domain/entities/room.dart';

abstract class RoomRepository {
  Future<List<RoomCategory>> getAllRooms();
  Future<RoomCategory> getRoomById(String id);
  Future<void> addRoom(RoomCategory room);
  Future<void> updateRoom(RoomCategory room);
  Future<void> deleteRoom(String id);
}