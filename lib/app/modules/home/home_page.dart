import 'package:flutter/material.dart';
import 'package:testeframework/app/modules/home/controller/home_controller.dart';
import 'package:testeframework/app/modules/home/models/produtos.dart';
import 'package:testeframework/app/modules/home/pages/carrinho/carrinho_page.dart';
import 'package:testeframework/app/modules/home/pages/pesquisa/pesquisa_page.dart';
import 'package:testeframework/app/modules/home/widgets/container_produtos.dart';
import 'package:testeframework/app/shared/database/produtos_db.dart';
import 'package:testeframework/app/shared/widgets/container_text_field.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _controller = HomeController();
  ProdutosHelper _produtosHelper = ProdutosHelper();

  salvarProduto(Produtos produtos) {
    _produtosHelper.saveProdutos(produtos);   
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Text('Produto adicionado no carrinho')
      )
    );
  }
  @override
  void initState() {
    super.initState();
    _controller.getProdutos();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => CarrinhoPage())
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text('Bem vindo ao \nComercio virtual',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                )
              ),

              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => PesquisaPage())
                  );
                },
                child: ContainerTextField(
                  child: TextFormField(
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: 'Pesquisar',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(20),
                      prefixIcon: Icon(Icons.search)
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              Text(
                'Produtos',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),

              Expanded(
                child: StreamBuilder<List<Produtos>>(
                  stream: _controller.produtosStrem.stream,
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<Produtos> dados = snapshot.data;

                    if(dados.isEmpty){
                      return Center(
                        child: Text('Sem produtos no momento'),
                      );
                    }
                    return ListView.builder(
                      itemCount: dados.length,
                      itemBuilder: (context,index){
                        return ContainerProdutos(
                          model: dados[index],
                          isDelete: false,
                          action: () => salvarProduto(dados[index])
                        );
                      }
                    );
                  }
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}