class PizzasMenu {
  final String id;
  final String nome;
  final String tamanho;
  final double preco;
  final String foto;

  PizzasMenu({
    required this.id,
    required this.nome,
    required this.tamanho,
    required this.preco,
    required this.foto,
  });

  factory PizzasMenu.fromJson(Map<String, dynamic> json) {
    return PizzasMenu(
      id: json['id'] as String,
      nome: json['nome'] as String,
      tamanho: json['tamanho'] as String,
      preco: json['preco'],
      foto: json['foto'] as String,
    );
  }
}
