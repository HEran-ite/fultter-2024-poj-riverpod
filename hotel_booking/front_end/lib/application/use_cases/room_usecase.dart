import 'package:hotel_booking/domain/entities/room.dart';
import 'package:hotel_booking/domain/repositories/room_repository.dart';

class RoomUseCase {
  final RoomRepository roomRepository;

  RoomUseCase(this.roomRepository);

  Future<List<RoomCategory>> getAllRooms() async {
    return await roomRepository.getAllRooms();
  }

  Future<RoomCategory> getRoomById(String id) async {
    return await roomRepository.getRoomById(id);
  }

  Future<void> addRoom(RoomCategory room) async {
    await roomRepository.addRoom(room);
  }

  Future<void> updateRoom(RoomCategory room) async {
    await roomRepository.updateRoom(room);
  }

  Future<void> deleteRoom(String id) async {
    await roomRepository.deleteRoom(id);
  }
}