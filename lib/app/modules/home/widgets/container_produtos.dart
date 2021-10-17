import 'package:flutter/material.dart';
import 'package:testeframework/app/modules/home/models/produtos.dart';
import 'package:testeframework/app/shared/database/produtos_db.dart';

class ContainerProdutos extends StatelessWidget {
  final Produtos model;
  final bool isDelete;
  final VoidCallback action;
  ContainerProdutos({
    @required this.model,
    @required this.isDelete,
    @required this.action
  });

  ProdutosHelper _produtosHelper = ProdutosHelper();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(32),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(model.foto)
              )
            ),
          ),
          Column(
            children: [
              Text(model.nome,style: TextStyle(fontWeight: FontWeight.bold)),
              Text(' R\$: ' + model.preco.toString(),style: TextStyle(color: Colors.green))
            ],
          ),
          IconButton(
            onPressed: action,
            icon: isDelete == false ? Icon(Icons.add) : Icon(Icons.delete,color: Colors.red)
          )
        ],
      ),
    );
  }
}