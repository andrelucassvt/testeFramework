class Produtos {
  int id;
  String nome;
  String foto;
  String preco;

  Produtos({
    this.id,
    this.nome, 
    this.preco,
    this.foto
  });

  Produtos.fromMap(Map map){
    id = map['id'];
    nome = map['nome'];
    preco = map['preco'];
    foto = map['foto'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'nome': nome,
      'preco': preco,
      'foto': foto,
    };
    if(id != null){
      map['id'] = id;
    }
    return map;
  }
}