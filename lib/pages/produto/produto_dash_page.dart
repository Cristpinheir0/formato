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
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _produto.nome,
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
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Card(
                              child: Column(
                        children: [
                          Text('Teste'),
                        ],
                      ))),
                      Expanded(child: Card(child: Column(
                        children: [
                          Text('Teste'),
                        ],
                      ))),
                    ]),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(currentPageIndex: 0),
                    ),
                  );
                },
                child: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
