import 'package:flutter/material.dart';
import 'package:formato/config/injetor_dependencia.dart';
import 'package:formato/entity/escola.dart';
import 'package:formato/pages/escola/form_escola.dart';
import 'package:formato/service/escola_service.dart';

class EscolasPage extends StatefulWidget {
  const EscolasPage({super.key});

  @override
  State<EscolasPage> createState() => _EscolasPageState();
}

class _EscolasPageState extends State<EscolasPage> {
  late Future<List<Escola>> _escolas;

  @override
  void initState() {
    super.initState();
    _carregarEscolas();
  }

  Future<void> _carregarEscolas() async {
    _escolas = getIt<EscolaService>().getAll();
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
                  future: _escolas,
                  builder: (context, snapshot) {
                    List<Escola> escolas = snapshot.data ?? [];
                    return Text(
                      'Escolas cadastradas: ${escolas.length}',
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
                        builder: (context) => const FormEscola(),
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
              future: _escolas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Text(
                    'Erro ao carregar as escolas',
                  );
                } else {
                  List<Escola> escolas = snapshot.data!;
                  return ListView.builder(
                    itemCount: escolas.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(escolas[index].nome),
                          subtitle: Text(escolas[index].endereco),
                          onTap: () async {},
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
