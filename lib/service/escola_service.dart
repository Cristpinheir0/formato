import 'package:formato/entity/escola.dart';
import 'package:formato/repository/escola_repository.dart';

class EscolaService {
  late final EscolaRepository _escolaRepository;

  EscolaService({required EscolaRepository escolaRepository}) {
    _escolaRepository = escolaRepository;
  }

  Future<Escola> salvar({required Escola escola}) async {
    return await _escolaRepository.salvar(escola: escola);
  }

  Future<List<Escola>> getAll() async {
    return await _escolaRepository.getAll();
  }

  Future<void> deletarById({required int idEscola}) async {
    return await _escolaRepository.deletarById(idEscola: idEscola);
  }

  Future<List<Map<String, String>>> getAllIdNome() async {
    return await _escolaRepository.getAllIdNome();
  }

  Future<List<String>> getAllIdNomeByListId(List<int> listaId) async {
    return await _escolaRepository.getAllIdNomeByListId(listaId);
  }
}
