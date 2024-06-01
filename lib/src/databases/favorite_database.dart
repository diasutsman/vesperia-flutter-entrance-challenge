import 'dart:collection';

import 'package:entrance_test/src/models/product_model.dart';
import 'package:entrance_test/src/models/request/product_list_request_model.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDatabase {
  Database? _db;
  Database get db => _db as Database;

  static const String _tableFavorites = 'favorites';
  static const String _columnId = 'id';
  static const String _columnName = 'name';
  static const String _columnPrice = 'price';
  static const String _columnDiscountPrice = 'price_after_discount';
  static const String _columnIsPrescriptionDrugs = 'is_prescription_drugs';
  static const String _columnDescription = 'description';
  static const String _columnReturnTerms = 'refund_terms_and_condition';
  static const String _columnRatingAverage = 'rating_average';
  static const String _columnRatingCount = 'rating_count';
  static const String _columnReviewCount = 'review_count';

  static const String _tableFavoritesImages = 'favoritesImages';
  static const String _columnImageId = 'id';
  static const String _columnImageProductId = 'product_id';
  static const String _columnImagePath = 'path';
  static const String _columnImagePathSmall = 'path_small';
  static const String _columnImageUrl = 'image_url';
  static const String _columnImageUrlSmall = 'image_url_small';
  static const String _columnImageCreatedAt = 'created_at';
  static const String _columnImageUpdatedAt = 'updated_at';

  Future _init() async {
    if (_db != null) return;
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/favorites.db';
    _db = await openDatabase(
      path,
      version: 3,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
create table $_tableFavorites ( 
  $_columnId VARCHAR(255) PRIMARY KEY)
''',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS $_tableFavorites");
        await db.execute('''
create table $_tableFavorites ( 
  $_columnId VARCHAR(255) PRIMARY KEY,
  $_columnName VARCHAR(255),
  $_columnPrice INT,
  $_columnDiscountPrice INT,
  $_columnIsPrescriptionDrugs BOOLEAN,
  $_columnDescription TEXT,
  $_columnReturnTerms TEXT,
  $_columnRatingAverage VARCHAR(255),
  $_columnRatingCount INT,
  $_columnReviewCount INT)
''');

        await db.execute("DROP TABLE IF EXISTS $_tableFavoritesImages");
        await db.execute('''
create table $_tableFavoritesImages ( 
  $_columnImageId VARCHAR(255) PRIMARY KEY,
  $_columnImageProductId VARCHAR(255),
  $_columnImagePath VARCHAR(255),
  $_columnImagePathSmall VARCHAR(255),
  $_columnImageUrl TEXT,
  $_columnImageUrlSmall TEXT,
  $_columnImageCreatedAt VARCHAR(255),
  $_columnImageUpdatedAt VARCHAR(255),
  FOREIGN KEY ($_columnImageProductId) REFERENCES $_tableFavorites($_columnId) ON DELETE CASCADE)
''');
      },
    );
  }

  Future<void> like(ProductModel product) async {
    await _init();
    List<Map> fav = await db.query(
      _tableFavorites,
      columns: [_columnId],
      where: '$_columnId = ?',
      whereArgs: [product.id],
    );
    //* Means it's already added
    if (fav.isNotEmpty) {
      return;
    }

    await db.insert(
      _tableFavorites,
      {
        ...product.toJson(),
        _columnIsPrescriptionDrugs: product.isPrescriptionDrugs == true ? 1 : 0,
      }..remove('images'),
    );

    Batch batch = db.batch();
    product.images?.forEach((image) {
      batch.insert(_tableFavoritesImages, image.toJson());
    });

    batch.commit(noResult: true);
  }

  Future<List<ProductModel>> getLikedProducts(
      ProductListRequestModel request) async {
    await _init();
    final requestJson = request.toJson();
    final res = await db.query(
      _tableFavorites,
      offset: requestJson['skip'],
      limit: requestJson['limit'],
    );

    print('skip: ${requestJson['skip']}');
    print('limit: ${requestJson['limit']}');
    print('res: $res');

    final List<ProductModel> list = [];

    for (Map<String, Object?> x in res) {
      list.add(ProductModel.fromJson({
        ...x,
        _columnIsPrescriptionDrugs: x[_columnIsPrescriptionDrugs] == 1,
        'images': await db.query(
          _tableFavoritesImages,
          columns: [_columnImageProductId],
          where: '$_columnImageProductId = ?',
          whereArgs: [x[_columnId]],
        ),
      }));
    }

    return list;
  }

  Future<HashSet<String>> getLikedProductIDsSet() async {
    await _init();
    final res = await db.query(_tableFavorites);

    return HashSet()..addAll(res.map((e) => e[_columnId].toString()));
  }

  Future<int> dislike(ProductModel product) async {
    List<Map> fav = await db.query(
      _tableFavorites,
      columns: [_columnId],
      where: '$_columnId = ?',
      whereArgs: [product.id],
    );
    //* Means it's not in the table
    if (fav.isEmpty) {
      return -1;
    }
    return await db.delete(
      _tableFavorites,
      where: '$_columnId = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> clear() {
    return db.delete(_tableFavorites);
  }

  Future close() async => db.close();
}
