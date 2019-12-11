import 'package:sqflite/sqflite.dart';//ديه سكوال درايفر بتخلينا نتعامل مع الداتا بيز
import 'package:path_provider/path_provider.dart';//بيخلينا نشتعل مع فايلات السيستم الاساسية
import 'dart:io'; //بيخلينا نتعامل مع الdevice file system
import 'package:path/path.dart';// زي path provider بس في فرق
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';
class NewsDbProvider implements Source,Cache{
  Database db;//جاي من اول ايمبورت بتاعه sqflite

  NewsDbProvider(){
    init();
}


  //To do store and fetch top ids
  Future<List<int>>fetchTopIds(){
    return null;
  }

  void init () async{
    Directory documentsDirectory=await getApplicationDocumentsDirectory();
    //get application بتتعامل مع فايلات الموبايلات جاية من path provider
    final path=join(documentsDirectory.path,"items2.db");
    //شايل مكان اللي هعمل فيه الداتا بيز
    db=await openDatabase(
        path,//هيشوف لو في داتا بيز هيفتحها من خلال الpath اللي متباصي او لو مش موجودة يكريتها
        version: 1,
        /*هيكريتلي الداتا بيز*/onCreate:(Database newDb,int version){
        newDb.execute("""
          CREATE TABLE Itemss
          (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
        """);
      }


        );
  }
 Future<ItemModel> fetchItem(int id) async{
    final maps=await db.query(
      "Itemss",
      columns: null,
      where: "id=?",//علامة الاستفهام ديه عبارة عن argument هتتبدل بالفنكشن او هتتساوي بفنكشن whereargs
      whereArgs: [id],
    );
    if(maps.length>0){
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }
  Future<int>addItem(ItemModel item){
   return db.insert("Itemss", item.toMap(),
   conflictAlgorithm: ConflictAlgorithm.ignore);
  }
  Future<int> clear(){
    return db.delete("Itemss");
    /*بيمسح كل الداتا اللي جوة الجدول وديه عملية مستمرة  */
  }
}
final newsDbProvider=NewsDbProvider();
