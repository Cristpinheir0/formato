import 'package:formato/entity/produto.dart';
import 'package:formato/repository/produto_repository.dart';

class ProdutoService {
  late final ProdutoRepository _produtoRepository;

  ProdutoService({required ProdutoRepository produtoRepository}) {
    _produtoRepository = produtoRepository;
  }

  Future<Produto> salvar({required Produto produto}) async {
    return await _produtoRepository.salvar(produto: produto);
  }

  Future<List<Produto>> getAll() async {
    return await _produtoRepository.getAll();
  }

  Future<void> deletarById({required int idProduto}) async {
    return await _produtoRepository.deletarById(idProduto: idProduto);
  }
}