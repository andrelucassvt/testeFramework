import 'dart:async';

import 'package:testeframework/app/modules/home/models/produtos.dart';
import 'package:testeframework/app/modules/home/service/home_service.dart';

class HomeController {

  HomeService service = HomeService();
  StreamController<List<Produtos>> produtosStrem = StreamController<List<Produtos>>();

  getProdutos(){
    List<Produtos> dados = service.getProdutos();
    produtosStrem.add(dados);
  }
}