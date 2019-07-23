import 'package:dozens_advices/data/database/Advice.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseImpl {
  static DatabaseImpl _database;
  Future<Database> _flutterDao;

  DatabaseImpl._internal() {
    _flutterDao = _openDatabase();
  }

  factory DatabaseImpl.getInstance() {
    if (_database == null) {
      _initDatabase();
    }
    return _database;
  }

  static _initDatabase() {
    _database = DatabaseImpl._internal();
  }

  Future<Database> _openDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $ADVICE_TABLE("
              "$ID_COLUMN INTEGER PRIMARY KEY AUTOINCREMENT, "
              "$REMOTE_ID_COLUMN TEXT, "
              "$CONTENT_COLUMN TEXT, "
              "$VIEWS_COLUMN INTEGER, "
              "$IS_FAVOURITE_COLUMN INTEGER, "
              "$TYPE_COLUMN TEXT, "
              "$CREATED_AT_COLUMN INTEGER, "
              "$VIEWED_AT_COLUMN INTEGER, "
              "$AUTHOR_COLUMN TEXT, "
              "$SOURCE_COLUMN TEXT"
              ")",
        );
      },
      version: 1,
    );
  }

  Future<bool> isAdviceExists() {
    final Database db = await _flutterDao;
  }

  Future<int> removeAdvice(int adviceId) async {
    return await (await _flutterDao)
        .delete(ADVICE_TABLE, where: '$ID_COLUMN = ?', whereArgs: [adviceId]);
  }

  Future<int> insertOrUpdateAdvice(Advice advice) async {
    final Database db = await _flutterDao;
    var existing = await db.query(ADVICE_TABLE,
        where: '$REMOTE_ID_COLUMN = ?, $SOURCE_COLUMN = ?', whereArgs: [advice.remoteId, advice.source]);
    if (existing != null) {
      Advice existingAdvice = existing as Advice;
      return await db
          .update(ADVICE_TABLE, {CONTENT_COLUMN: advice.mainContent},
          where: '$ID_COLUMN = ?', whereArgs: [existingAdvice.id]);
    } else {
      return await db.insert(ADVICE_TABLE, advice.toDatabaseMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<Advice>> getAdvices() async {
    final Database db = await _flutterDao;
    final List<Map<String, dynamic>> maps = await db.query(ADVICE_TABLE);
    return List.generate(maps.length, (i) {
      return Advice.fromDatabaseMap(maps[i]);
    });
  }

  Future<List<Advice>> getFavouriteAdvices() async {
    final Database db = await _flutterDao;
    final List<Map<String, dynamic>> maps = await db
        .query(ADVICE_TABLE, where: '$IS_FAVOURITE_COLUMN = ?', whereArgs: [1]);
    return List.generate(maps.length, (i) {
      return Advice.fromDatabaseMap(maps[i]);
    });
  }
}
