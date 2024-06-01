import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/booking.dart';
import 'package:hotel_booking/domain/entities/user_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class BookingLocalDataSource {
  Future<List<Booking>> fetchBookings();
  Future<void> postBooking(Booking booking);
  Future<void> updateBooking(String id, Booking booking);
  Future<void> deleteBooking(String id);
}





class UserLocalDataSource {
  static final UserLocalDataSource _instance = UserLocalDataSource._internal();
  factory UserLocalDataSource() => _instance;
  UserLocalDataSource._internal();

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
          CREATE TABLE users (
            id TEXT PRIMARY KEY,
            name TEXT,
            email TEXT,
            password TEXT,
            role TEXT
          )
        ''');
      },
    );
  }

  Future<void> createUser(User user) async {
    final db = await database;
    await db.insert('users', user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<User?> fetchUser(String id) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      'users',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(String id) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSource();
});