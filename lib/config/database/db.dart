import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  /// Constutor privado para que a classe seja do tipo sigleton
  DB._();

  /// Criação da instancia do database
  static final DB instance = DB._();

  /// Instancia do SQLITE
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'formato.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    await db.execute(_escola);
    await db.execute(_produto);
  }

  String get _escola => '''
    CREATE TABLE Escola (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      endereco TEXT
  );
  ''';

  String get _produto => '''
    CREATE TABLE Produto (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idEscola INTEGER,
      nome TEXT
  );
  ''';
}
