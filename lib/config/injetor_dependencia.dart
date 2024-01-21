import 'package:formato/repository/escola_repository.dart';
import 'package:formato/repository/produto_repository.dart';
import 'package:formato/service/escola_service.dart';
import 'package:formato/service/produto_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUpInjetorDependencia() {
  getIt.registerLazySingleton<EscolaRepository>(() => EscolaRepository());
  getIt.registerLazySingleton<EscolaService>(
      () => EscolaService(escolaRepository: getIt<EscolaRepository>()));
  getIt.registerLazySingleton<ProdutoRepository>(() => ProdutoRepository());
  getIt.registerLazySingleton<ProdutoService>(
      () => ProdutoService(produtoRepository: getIt<ProdutoRepository>()));
}
