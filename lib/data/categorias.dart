class Categoria {
  final String id;
  final String nome;
  final String foto;

  Categoria({required this.id, required this.nome, required this.foto});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'] as String,
      nome: json['nome'] as String,
      foto: json['foto'] as String,
    );
  }
}
