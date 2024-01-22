import 'package:flutter/material.dart';
import 'package:formato/entity/produto.dart';
import 'package:formato/pages/home_page.dart';

class ProdutoDashPage extends StatefulWidget {
  final Produto produto;
  final String nomeEscola;

  const ProdutoDashPage(
      {super.key, required this.produto, required this.nomeEscola});

  @override
  State<ProdutoDashPage> createState() => _ProdutoDashPageState();
}

class _ProdutoDashPageState extends State<ProdutoDashPage> {
  late Produto _produto;
  late String _nomeEscola;

  @override
  void initState() {
    super.initState();
    _produto = widget.produto;
    _nomeEscola = widget.nomeEscola;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Flexible(
                                        flex: 1,
                                        child: Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 65,
                                                backgroundColor: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Produto: ${_produto.nome}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 26,
                                              ),
                                            ),
                                            Text(
                                              'Escola: $_nomeEscola',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 26,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Flexible(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                child: Center(
                                    child: Text(
                                        'ESTATISTICAS DE VENDA DO PRODUTO')),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Flexible(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                child: Center(
                                  /// TODO Implementar estoque no app
                                    child: Text('INFORMAÇÕES DE ESTOQUE')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HomePage(currentPageIndex: 0),
                        ),
                      );
                    },
                    child: const Text('Voltar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
