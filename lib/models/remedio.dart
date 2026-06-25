class Remedio {
  int? id;
  String nome;
  String descricao;
  double preco;
  String categoria;

  Remedio({
    this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.categoria,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'categoria': categoria,
    };
  }

  factory Remedio.fromMap(Map<String, dynamic> map) {
    return Remedio(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      preco: map['preco'],
      categoria: map['categoria'],
    );
  }
}