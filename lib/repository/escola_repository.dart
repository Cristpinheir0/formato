import 'package:formato/config/database/db.dart';
import 'package:formato/entity/escola.dart';
import 'package:sqflite/sqflite.dart';

class EscolaRepository {
  late Database db;
  final tableName = 'escola';

  Future<Escola> salvar({required Escola escola}) async {
    db = await DB.instance.database;
    final idEscola = await db.insert(tableName, escola.toMap());
    escola.id = idEscola;
    return escola;
  }

  Future<List<Escola>> getAll() async {
    db = await DB.instance.database;
    final rows = await db.query(tableName);
    List<Escola> escolas = [];
    for (var row in rows) {
      escolas.add(Escola.fromMap(row));
    }
    return escolas;
  }

  Future<void> deletarById({required int idEscola}) async {
    db = await DB.instance.database;
    db.delete(tableName, where: 'id = ?', whereArgs: [idEscola]);
  }

  Future<List<Map<String, String>>> getAllIdNome() async {
    db = await DB.instance.database;
    List<Map<String, String>> listaIdNome = [];
    final rows = await db.query(tableName, columns: ['id', 'nome']);
    for (var row in rows) {
      listaIdNome.add({
        'id': row['id'].toString(),
        'nome': row['nome'].toString(),
      });
    }
    return listaIdNome;
  }

  Future<List<String>> getAllIdNomeByListId(List<int> listaId) async {
    db = await DB.instance.database;
    List<String> listaIdNome = [];
    final rows = await db.query(tableName,
        where: 'id in (${List.filled(listaId.length, '?').join(',')})',
        whereArgs: listaId);
    for (final row in rows) {
      listaIdNome.add(row['nome'].toString());
    }

    return listaIdNome;
  }
}
