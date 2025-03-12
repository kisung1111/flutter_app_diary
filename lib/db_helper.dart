import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'diary.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS diary (date TEXT PRIMARY KEY, content TEXT)",
        );
      },
    );
  }

  Future<void> saveDiary(String date, String content) async {
    final db = await database;
    await db.insert(
      'diary',
      {'date': date, 'content': content},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getDiaryContent(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
    await db.query('diary', where: 'date = ?', whereArgs: [date]);
    if (maps.isNotEmpty) {
      return maps.first['content'] as String?;
    }
    return null;
  }

  Future<void> deleteDiary(String date) async {
    final db = await database;
    await db.delete('diary', where: 'date = ?', whereArgs: [date]);
  }

  Future<List<String>> getAllDiaryDates() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('diary');
    return List.generate(maps.length, (i) => maps[i]['date'] as String);
  }

  Future<int> getDiaryCountForMonth(int month) async {
    final db = await database;
    String monthStr = month < 10 ? '0$month' : '$month';
    final List<Map<String, dynamic>> maps = await db
        .query('diary', where: "date LIKE ?", whereArgs: ['%-$monthStr-%']);
    return maps.length;
  }
}
