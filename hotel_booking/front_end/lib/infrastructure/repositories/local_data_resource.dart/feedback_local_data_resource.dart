import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/feedback.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class FeedbackLocalDataSource {
  static final FeedbackLocalDataSource _instance = FeedbackLocalDataSource._internal();
  factory FeedbackLocalDataSource() => _instance;
  FeedbackLocalDataSource._internal();

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
          CREATE TABLE feedbacks (
            id TEXT PRIMARY KEY,
            customerName TEXT,
            message TEXT,
            rating INTEGER
          )
        ''');
      },
    );
  }

  Future<void> createFeedback(AppFeedback feedback) async {
    final db = await database;
    await db.insert('feedbacks', feedback.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<AppFeedback?> fetchFeedback(String id) async {
    final db = await database;
    final maps = await db.query(
      'feedbacks',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return AppFeedback.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<void> updateFeedback(AppFeedback feedback) async {
    final db = await database;
    await db.update(
      'feedbacks',
      feedback.toJson(),
      where: 'id = ?',
      whereArgs: [feedback.id],
    );
  }

  Future<void> deleteFeedback(String id) async {
    final db = await database;
    await db.delete(
      'feedbacks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

final feedbackLocalDataSourceProvider = Provider<FeedbackLocalDataSource>((ref) {
  return FeedbackLocalDataSource();
});