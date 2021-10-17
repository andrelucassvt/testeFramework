import 'package:flutter/material.dart';
import 'package:testeframework/app/modules/home/models/produtos.dart';
import 'package:testeframework/app/modules/home/widgets/container_produtos.dart';
import 'package:testeframework/app/shared/database/produtos_db.dart';
import 'package:testeframework/app/shared/util/gerar_pdf.dart';

class CarrinhoPage extends StatefulWidget {

  @override
  _CarrinhoPageState createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {

  ProdutosHelper _produtosHelper = ProdutosHelper();
  List<Produtos> listaProdutosSalvos = [];

  pegarDados() async {
    List<Produtos> lista = [];
    lista = await _produtosHelper.getAllProdutos();
    setState(() {
      listaProdutosSalvos = lista;
      print(listaProdutosSalvos.length);
    });
  }
  deletarProduto(Produtos produtos) {
    _produtosHelper.deleteProdutos(produtos);
    pegarDados();  
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text('Produto deletado')
      )
    );
  }
  @override
  void initState() {
    super.initState();
    pegarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: listaProdutosSalvos.isEmpty 
          ? () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sem produtos salvos'))
            );
          } 
          : (){
            GeneratePDF generatePdf = GeneratePDF(produtos: listaProdutosSalvos);
            generatePdf.generatePDFInvoice();
          },
        icon: Icon(Icons.payment),
        label: Text('Comprar'),
      ),
      appBar: AppBar(
        title: Text('Carrinho'),
        centerTitle: true,
      ),
      body: Column(
        children: [

          if (listaProdutosSalvos.isEmpty) Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: Text('Sem produtos salvos'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listaProdutosSalvos.length,
              itemBuilder: (context,index){
                return ContainerProdutos(
                  model: listaProdutosSalvos[index], 
                  isDelete: true, 
                  action: () => deletarProduto(listaProdutosSalvos[index])
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}