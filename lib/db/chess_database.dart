import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/chess_piece.dart';

class ChessDatabase {
  static final ChessDatabase instance = ChessDatabase._init();
  static Database? _database;
  static const String _tableName = 'chess_pieces';

  ChessDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('chess.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2, // version 2 เพราะเราเพิ่ม column ใหม่
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // เพิ่ม column ใหม่โดยไม่ลบข้อมูลเก่า
          await db.execute(
              "ALTER TABLE $_tableName ADD COLUMN material TEXT DEFAULT 'Unknown'");
          await db.execute(
              "ALTER TABLE $_tableName ADD COLUMN year INTEGER DEFAULT 2023");
          print('Table $_tableName upgraded with material and year');
        }
      },
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        type TEXT,
        color TEXT,
        value REAL,
        material TEXT DEFAULT 'Unknown',
        year INTEGER DEFAULT 2023
      )
    ''');
  }

  Future<int> insertPiece(ChessPiece piece) async {
    final db = await instance.database;
    return await db.insert(
      _tableName,
      piece.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ChessPiece>> getPieces() async {
    final db = await instance.database;
    final result = await db.query(_tableName, orderBy: 'id DESC');
    return result.map((e) => ChessPiece.fromMap(e)).toList();
  }

  Future<int> updatePiece(ChessPiece piece) async {
    final db = await instance.database;
    return await db.update(
      _tableName,
      piece.toMap(),
      where: 'id = ?',
      whereArgs: [piece.id],
    );
  }

  Future<int> deletePiece(int id) async {
    final db = await instance.database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
