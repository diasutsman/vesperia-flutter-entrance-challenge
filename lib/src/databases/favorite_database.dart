import 'dart:collection';

import 'package:entrance_test/src/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDatabase {
  Database? _db;
  Database get db => _db as Database;

  static const String _tableFavorites = 'favorites';
  static const String _columnId = 'id';

  Future init() async {
    if (_db != null) return;
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/favorites.db';
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
create table $_tableFavorites ( 
  $_columnId VARCHAR(255) PRIMARY KEY)
''');
      },
    );
  }

  Future<void> like(ProductModel product) async {
    print("product id = ${product.id}");
    // List<Map> fav = await db.query(
    //   _tableFavorites,
    //   columns: [_columnId],
    //   where: '$_columnId = ?',
    //   whereArgs: [product.id],
    // );
    // //* Means it's already added
    // if (fav.isNotEmpty) {
    //   return;
    // }

    await db.insert(_tableFavorites, {
      _columnId: product.id,
    });
  }

  Future<HashSet<String>> getLikedProductIds() async {
    final res = await db.query(_tableFavorites);
    return HashSet<String>()..addAll(res.map((e) => e[_columnId].toString()));
  }

  Future<int> dislike(ProductModel product) async {
    print("product id = ${product.id}");
    // List<Map> fav = await db.query(
    //   _tableFavorites,
    //   columns: [_columnId],
    //   where: '$_columnId = ?',
    //   whereArgs: [product.id],
    // );
    // //* Means it's not in the table
    // if (fav.isEmpty) {
    //   return -1;
    // }
    return await db.delete(
      _tableFavorites,
      where: '$_columnId = ?',
      whereArgs: [product.id],
    );
  }

  Future close() async => db.close();
}
