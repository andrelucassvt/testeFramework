import 'package:flutter/material.dart';
import 'package:testeframework/app/modules/home/controller/home_controller.dart';
import 'package:testeframework/app/modules/home/models/produtos.dart';
import 'package:testeframework/app/modules/home/service/home_service.dart';
import 'package:testeframework/app/modules/home/widgets/container_produtos.dart';
import 'package:testeframework/app/shared/database/produtos_db.dart';
import 'package:testeframework/app/shared/widgets/container_text_field.dart';

class PesquisaPage extends StatefulWidget {

  @override
  _PesquisaPageState createState() => _PesquisaPageState();
}

class _PesquisaPageState extends State<PesquisaPage> {
  HomeService _controller = HomeService();
  ProdutosHelper _produtosHelper = ProdutosHelper();
  List<Produtos> _allProdutos = [];
  List<Produtos> _filtoProdutos = [];
  @override
  void initState() {
    super.initState();
    getDados();
  }
  salvarProduto(Produtos produtos) {
    _produtosHelper.saveProdutos(produtos);   
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Text('Produto adicionado no carrinho')
      )
    );
  }
  getDados(){
    setState(() {
      _allProdutos = _controller.getProdutos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: ContainerTextField(
          child: Container(
            alignment: Alignment.centerLeft,
            color: Colors.white,
            child: TextField(
              autofocus: true,
              onChanged: (value) => onSearchTextChanged(value),
              decoration: const InputDecoration(
                labelText: 'Pesquisar produto', 
                suffixIcon: Icon(Icons.search),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(20)
              ),
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _filtoProdutos.isNotEmpty
                ? ListView.builder(
                    itemCount: _filtoProdutos.length,
                    itemBuilder: (context, index) {
                      return ContainerProdutos(
                        model: _filtoProdutos[index],
                        isDelete: false,
                        action: () => salvarProduto(_filtoProdutos[index]),
                      );
                    }
                  )
                : const Center(
                  child: Text(
                      'Sem resultados',
                      style: TextStyle(fontSize: 24),
                    ),
                ),
            ),
          ],
        ),
      ),
    );
  }


  onSearchTextChanged(String text) async {
    List<Produtos> results = [];
    if (text.isEmpty) {
      results = _allProdutos;
    } else {
      results = _allProdutos.where((user) =>
        user.nome.toLowerCase().contains(text.toLowerCase())).toList();
    }
    setState(() {
      _filtoProdutos = results;
    });
  }
}