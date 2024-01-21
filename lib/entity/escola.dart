class Escola {
  int? id;
  String nome;
  String endereco;

  Escola({this.id, required this.nome, required this.endereco});

  factory Escola.fromMap(Map<String, dynamic> map) {
    return Escola(
      id: map['id'],
      nome: map['nome'],
      endereco: map['endereco'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'endereco': endereco,
    };
  }
}
