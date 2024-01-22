import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormularioService {
  List<Widget> criarCamposFormulario({required List<CampoFormulario> campos}) {
    List<Widget> camposReturn = [];
    for (final campo in campos) {
      late Widget campoFormatado;
      switch (campo.type) {
        case TypeFormulario.textField:
          campoFormatado = FormBuilderTextField(
            name: campo.name,
            decoration: InputDecoration(labelText: campo.label),
            validator: campo.validator,
          );
        case TypeFormulario.dropDown:
          campo as CampoDropDown;
          campoFormatado = FormBuilderDropdown(
            name: campo.name,
            decoration: InputDecoration(labelText: campo.label),
            items: campo.valores
                .map((item) => DropdownMenuItem(
                      value: item["value"],
                      child: Text('${item["key"]}'),
                    ))
                .toList(),
            validator: campo.validator,
          );
      }

      camposReturn.add(campoFormatado);
    }
    return camposReturn;
  }
}

class CampoFormulario {
  String name;
  String label;
  TypeFormulario type;
  String? Function(Object?)? validator;

  CampoFormulario({
    required this.name,
    required this.label,
    required this.type,
    required this.validator,
  });
}

class CampoDropDown extends CampoFormulario {
  List<Map> valores;

  CampoDropDown({
    required super.name,
    required super.label,
    required super.type,
    required super.validator,
    required this.valores,
  });
}

enum TypeFormulario {
  textField,
  dropDown,
}
