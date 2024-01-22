import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:formato/config/injetor_dependencia.dart';
import 'package:formato/entity/produto.dart';
import 'package:formato/pages/home_page.dart';
import 'package:formato/service/escola_service.dart';
import 'package:formato/service/formulario_service.dart';
import 'package:formato/service/produto_service.dart';
import 'package:image_picker/image_picker.dart';

class FormProduto extends StatefulWidget {
  final List<Map<String, Object?>> idsEscolas;
  const FormProduto({super.key, required this.idsEscolas});

  @override
  State<FormProduto> createState() => _FormProdutoState();
}

class _FormProdutoState extends State<FormProduto> {
  final escolaService = getIt<EscolaService>();
  final formularioService = getIt<FormularioService>();
  final _formKey = GlobalKey<FormBuilderState>();
  late List<Map<String, String>> _idsNomesEscolas;

  final imagePicker = ImagePicker();
  File? imageFile;

  @override
  void initState() {
    super.initState();
    _carregarIdsEscolas();
  }

  Future<void> _carregarIdsEscolas() async {
    _idsNomesEscolas =
        _converterLista(widget.idsEscolas as List<Map<String, String>>);
  }

  List<Map<String, String>> _converterLista(
      List<Map<String, String>> listaOriginal) {
    List<Map<String, String>> listaConvertida = [];

    for (var mapa in listaOriginal) {
      String chaveId = mapa.keys.first;
      String valorId = mapa[chaveId]!;
      String chaveNome = mapa.keys.last;
      String valorNome = mapa[chaveNome]!;

      Map<String, String> novoMapa = {'value': valorId, 'key': valorNome};
      listaConvertida.add(novoMapa);
    }

    return listaConvertida;
  }

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final campos = formularioService.criarCamposFormulario(
      campos: [
        CampoFormulario(
            name: 'nome',
            label: 'Nome',
            type: TypeFormulario.textField,
            validator: FormBuilderValidators.required()),
        CampoDropDown(
          name: 'idEscola',
          label: 'Escola',
          type: TypeFormulario.dropDown,
          validator: FormBuilderValidators.required(),
          valores: _idsNomesEscolas,
        ),
      ],
    );

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
                      'Cadastrar Produto',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 75,
                                    backgroundColor: Colors.blueAccent[200],
                                    child: CircleAvatar(
                                      radius: 65,
                                      backgroundColor: Colors.blueAccent[400],
                                      backgroundImage: imageFile != null
                                          ? FileImage(imageFile!)
                                          : null,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 5,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[200],
                                      child: IconButton(
                                        onPressed: _showOpcoesBottomSheet,
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: campos.length,
                              itemBuilder: ((context, index) {
                                return campos[index];
                              }),
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
                                    final produto = Produto.fromMap({
                                      'nome': formData['nome'],
                                      'idEscola':
                                          int.parse(formData['idEscola']),
                                    });
                                    getIt<ProdutoService>()
                                        .salvar(produto: produto)
                                        .then(
                                          (produtoSalvo) =>
                                              Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage(
                                                      currentPageIndex: 0),
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
                                onPressed: () async {
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

  void _showOpcoesBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Galeria',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Buscar imagem da galeria
                  pick(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Câmera',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Fazer foto da câmera
                  pick(ImageSource.camera);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Remover',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Tornar a foto null
                  setState(() {
                    imageFile = null;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
