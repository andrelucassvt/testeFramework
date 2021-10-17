import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testeframework/app/modules/home/models/produtos.dart';

String nomeTable = 'produtos';

String idColumn = 'id';
String nomeColumn = 'nome';
String precoColumn = 'preco';
String fotoColumn = 'foto';

class ProdutosHelper {

  static final ProdutosHelper _instance = ProdutosHelper.internal();

  factory ProdutosHelper() => _instance;

  ProdutosHelper.internal();

  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "produtos.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE $nomeTable($idColumn INTEGER, $nomeColumn TEXT, $precoColumn TEXT,$fotoColumn TEXT)"
      );
    });
  }

  Future<Produtos> saveProdutos(Produtos produtos) async {
    Database dbContact = await db;
    produtos.id = await dbContact.insert(nomeTable, produtos.toMap());
    return produtos;
  }


  Future<int> deleteProdutos(Produtos produto) async {
    Database dbContact = await db;
    return await dbContact.delete(nomeTable, where: "$idColumn = ?", whereArgs: [produto.id]);
  }


  Future<List> getAllProdutos() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $nomeTable");
    List<Produtos> listContact = [];
    for(Map m in listMap){
      listContact.add(Produtos.fromMap(m));
    }
    return listContact;
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }

}