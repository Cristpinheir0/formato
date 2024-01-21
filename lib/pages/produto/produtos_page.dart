import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formato/config/injetor_dependencia.dart';
import 'package:formato/entity/produto.dart';
import 'package:formato/pages/produto/form_produto.dart';
import 'package:formato/pages/produto/produto_dash_page.dart';
import 'package:formato/service/escola_service.dart';
import 'package:formato/service/produto_service.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  final _produtoService = getIt<ProdutoService>();
  final _escolaService = getIt<EscolaService>();
  late Future<List<Produto>> _produtos;
  late Future<List<String>> _nomesEscolas;
  List<String> nomesEscolas = [];

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
    _carregarNomesEscolas();
  }

  Future<void> _carregarProdutos() async {
    _produtos = _produtoService.getAll();
  }

  Future<void> _carregarNomesEscolas() async {
    final produtos = await _produtos;
    List<int> listaId = [];
    for (final produto in produtos) {
      listaId.add(produto.id!);
    }
    _nomesEscolas = _escolaService.getAllIdNomeByListId(listaId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                  future: _produtos,
                  builder: (context, snapshot) {
                    List<Produto> produtos = snapshot.data ?? [];
                    return Text(
                      'Produtos cadastrados: ${produtos.length}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                      ),
                    );
                  },
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FormProduto(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_box_outlined),
                  selectedIcon: const Icon(Icons.add_box),
                )
              ],
            ),
          ),
          const Divider(height: 50),
          Expanded(
            child: FutureBuilder(
              future: _produtos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Text(
                    'Erro ao carregar os produtos',
                  );
                } else {
                  final List<Produto> produtos = snapshot.data!;
                  return ListView.builder(
                    itemCount: produtos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(produtos[index].nome),
                          subtitle: FutureBuilder(
                              future: _nomesEscolas,
                              builder: (context, escolasSnapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text('');
                                } else if (snapshot.hasError) {
                                  return const Text(
                                    'Erro ao carregar o nome da escola',
                                  );
                                } else {
                                  nomesEscolas = escolasSnapshot.data ?? [];
                                  if (nomesEscolas.isNotEmpty) {
                                    return Text(nomesEscolas[index]);
                                  }
                                  return const Text('');
                                }
                              }),
                          onTap: () async {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProdutoDashPage(
                                    produto: produtos[index],
                                    nomeEscola: nomesEscolas[index]),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
