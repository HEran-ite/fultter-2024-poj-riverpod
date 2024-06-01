import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hotel_booking/domain/entities/room.dart';

class RoomLocalDataSource {
  static final RoomLocalDataSource _instance = RoomLocalDataSource._internal();
  factory RoomLocalDataSource() => _instance;
  RoomLocalDataSource._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'hotel_booking.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE rooms (
            id TEXT PRIMARY KEY,
            title TEXT,
            image TEXT,
            description TEXT,
            price INTEGER,
            category TEXT
          )
        ''');
      },
    );
  }

  Future<void> createRoom(RoomCategory room) async {
    final db = await database;
    await db.insert('rooms', room.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<RoomCategory?> fetchRoom(String id) async {
    final db = await database;
    final maps = await db.query(
      'rooms',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return RoomCategory.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<void> updateRoom(RoomCategory room) async {
    final db = await database;
    await db.update(
      'rooms',
      room.toJson(),
      where: 'id = ?',
      whereArgs: [room.id],
    );
  }

  Future<void> deleteRoom(String id) async {
    final db = await database;
    await db.delete(
      'rooms',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

final roomLocalDataSourceProvider = Provider<RoomLocalDataSource>((ref) {
  return RoomLocalDataSource();
});