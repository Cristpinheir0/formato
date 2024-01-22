import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:formato/config/injetor_dependencia.dart';
import 'package:formato/entity/escola.dart';
import 'package:formato/pages/home_page.dart';
import 'package:formato/service/escola_service.dart';
import 'package:formato/service/formulario_service.dart';

class FormEscola extends StatefulWidget {
  const FormEscola({super.key});

  @override
  State<FormEscola> createState() => _FormEscolaState();
}

class _FormEscolaState extends State<FormEscola> {
  final formularioService = getIt<FormularioService>();
  final escolaService = getIt<EscolaService>();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final campos = formularioService.criarCamposFormulario(
      campos: [
        CampoFormulario(
          name: 'nome',
          label: 'Nome',
          type: TypeFormulario.textField,
          validator: FormBuilderValidators.required(),
        ),
        CampoFormulario(
          name: 'endereco',
          label: 'Endereço',
          type: TypeFormulario.textField,
          validator: FormBuilderValidators.required(),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
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
              Expanded(
                child: Card(
                  child: FormBuilder(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: campos.length,
                              itemBuilder: (context, index) {
                                return campos[index];
                              },
                            ),
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
                                    escolaService.salvar(escola: escola).then(
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
