import 'package:dozens_advices/data/database/advice.dart';
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

  Future<Advice> getExistingAdvice(Advice advice) async {
    final Database db = await _flutterDao;
    List<Map> existing = await db.query(ADVICE_TABLE,
        where: '$REMOTE_ID_COLUMN = ? and $SOURCE_COLUMN = ?',
        whereArgs: [advice.remoteId, advice.source],
        limit: 1);
    if (existing.isNotEmpty) {
      return Advice.fromDatabaseMap(existing.first);
    } else {
      return null;
    }
  }

  Future<int> removeAdvice(int adviceId) async {
    return (await _flutterDao)
        .delete(ADVICE_TABLE, where: '$ID_COLUMN = ?', whereArgs: [adviceId]);
  }

  Future<int> insertOrUpdateAdvice(Advice advice) async {
    final Database db = await _flutterDao;
    var existing = await getExistingAdvice(advice);
    if (existing != null) {
      return db.update(ADVICE_TABLE, {CONTENT_COLUMN: advice.mainContent},
          where: '$ID_COLUMN = ?', whereArgs: [existing.id]);
    } else {
      return db.insert(ADVICE_TABLE, advice.toDatabaseMap(),
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

  Future<Advice> markAsFavourite(int id, bool isFavourite) async {
    final Database db = await _flutterDao;
    db.update(ADVICE_TABLE, {IS_FAVOURITE_COLUMN: isFavourite ? 1 : 0},
        where: '$ID_COLUMN = ?', whereArgs: [id]);
    return await getAdvice(id);
  }

  Future<Advice> getAdvice(int id) async {
    final Database db = await _flutterDao;
    List<Map> advice = await db.query(ADVICE_TABLE, where: '$ID_COLUMN = ?', whereArgs: [id], limit: 1);
    return Advice.fromDatabaseMap(advice.first);
  }
}
