class Produto {
  int? id;
  int idEscola;
  String nome;

  Produto({
    this.id,
    required this.idEscola,
    required this.nome,
  });

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      idEscola: map['idEscola'],
      nome: map['nome'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idEscola': idEscola,
      'nome': nome,
    };
  }
}
