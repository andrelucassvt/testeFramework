import 'package:testeframework/app/modules/home/models/produtos.dart';

class HomeService {
  
  List<Produtos> getProdutos() {
    List<Produtos> lista = [
      Produtos(
        id: 1,
        preco: '20.0',
        foto: 'assets/frutas/abacaxi.jpeg',
        nome: 'Abacaxi'
      ),
      Produtos(
        id: 2,
        preco: '20.3',
        foto: 'assets/frutas/maca.jpeg',
        nome: 'Maça'
      ),
      Produtos(
        id: 3,
        preco: '3.0',
        foto: 'assets/frutas/banana.jpeg',
        nome: 'Banana'
      ),
      Produtos(
        id: 4,
        preco: '22.0',
        foto: 'assets/frutas/pera.jpeg',
        nome: 'Pêra'
      ),
      Produtos(
        id: 5,
        preco: '20.2',
        foto: 'assets/frutas/manga.jpeg',
        nome: 'Manga'
      ),
    ];
    return lista;
  }

}