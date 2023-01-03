import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
CREATE TABLE pet(
  name VARCHAR,
  age INT,
  price VARCHAR,
  adoptme INT,
  image VARCHAR,
  PRIMARY KEY(name)
)
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('pets.db', version: 2,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future createItem(
      var name, int age, var price, int adoptme, var image) async {
    final db = await SQLHelper.db();
    // final id = await db.rawInsert(
    //     'INSERT INTO items (Productid,Storeid,quantity) VALUES (?,?,?)',
    //     [productId, storeId, quantity]);
    final data = {
      'name': name,
      'age': age,
      'price': price,
      'adoptme': adoptme,
      'image': image
    };
    final id = await db.insert(
      "pet",
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('pet');
  }

  static Future<List<Map<String, dynamic>>> getItem(var name) async {
    final db = await SQLHelper.db();
    return db.query('pet', where: "name = ?", whereArgs: [name], limit: 1);
  }

  static Future<int> updateItem(
      var name, int age, var price, int adoptme, var image) async {
    final db = await SQLHelper.db();
    // final result =
    //     db.rawUpdate('UPDATE pet SET adoptme = 1 WHERE name = $name');

    final data = {
      'name': name,
      'age': age,
      'price': price,
      'adoptme': adoptme,
      'image': image
    };
    final result = await db.update(
      'pet',
      data,
      where: "name = ?",
      whereArgs: [name],
    );

    var list =
        await db.query('pet', where: "name = ?", whereArgs: [name], limit: 1);
    print(list);
    return result;
  }

  static Future<void> deleteItem(var name) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("pet", where: "name = ?", whereArgs: [name]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> deleteAll() async {
    final db = await SQLHelper.db();
    try {
      await db.rawDelete("DELETE FROM pet");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
