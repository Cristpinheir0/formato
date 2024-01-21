import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:formato/config/injetor_dependencia.dart';
import 'package:formato/entity/escola.dart';
import 'package:formato/pages/home_page.dart';
import 'package:formato/service/escola_service.dart';

class FormEscola extends StatefulWidget {
  const FormEscola({super.key});

  @override
  State<FormEscola> createState() => _FormEscolaState();
}

class _FormEscolaState extends State<FormEscola> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Cadastrar Escola',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 50),
              FormBuilder(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name: 'nome',
                            decoration:
                                const InputDecoration(labelText: 'Nome'),
                            validator: FormBuilderValidators.required(),
                          ),
                          FormBuilderTextField(
                            name: 'endereco',
                            decoration:
                                const InputDecoration(labelText: 'Endereço'),
                            validator: FormBuilderValidators.required(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!
                                      .saveAndValidate()) {
                                    final formData =
                                        _formKey.currentState!.value;
                                    final escola = Escola.fromMap({
                                      'nome': formData['nome'],
                                      'endereco': formData['endereco'],
                                    });
                                    getIt<EscolaService>()
                                        .salvar(escola: escola)
                                        .then(
                                          (escolaSalva) =>
                                              Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage(
                                                      currentPageIndex: 2),
                                            ),
                                          ),
                                        );
                                  }
                                },
                                child: const Text('Salvar'),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const HomePage(currentPageIndex: 2),
                                    ),
                                  );
                                },
                                child: const Text('Voltar'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
