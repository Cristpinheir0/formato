import 'package:formato/config/database/db.dart';
import 'package:formato/entity/produto.dart';
import 'package:sqflite/sqflite.dart';

class ProdutoRepository {
  late Database db;
  final tableName = 'produto';

  Future<Produto> salvar({required Produto produto}) async {
    db = await DB.instance.database;
    final idProduto = await db.insert(tableName, produto.toMap());
    produto.id = idProduto;
    return produto;
  }

  Future<List<Produto>> getAll() async {
    db = await DB.instance.database;
    final rows = await db.query(tableName);
    List<Produto> produtos = [];
    for (var row in rows) {
      produtos.add(Produto.fromMap(row));
    }
    return produtos;
  }

  Future<void> deletarById({required int idProduto}) async {
    db = await DB.instance.database;
    db.delete(tableName, where: 'id = ?', whereArgs: [idProduto]);
  }
}
