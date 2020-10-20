import 'package:barcode/src/models/producto_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
export 'package:barcode/src/models/scan_model.dart';

class DatabaseProvider {
  static Database _database;
  static final DatabaseProvider db = DatabaseProvider._();

  //Constructor privado
  DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDb();

    return _database;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'productosDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Productos('
          ' id INTEGER PRIMARY KEY,'
          ' uuid TEXT,'
          ' tipo TEXT,'
          ' valor TEXT,'
          ' formato TEXT,'
          ' formatoNota TEXT,'
          ' establecimiento TEXT,'
          ' producto TEXT,'
          ' precio REAL,'
          ' estado TEXT'
          ')');
    });
  }

  Future<int> nuevoScan(ProductoModel nuevoScan) async {
    final db = await database;

    final res = await db.insert('Productos', nuevoScan.toJson());

    return res;
  }

  Future<ProductoModel> getScanId(int id) async {
    final db = await database;
    final res = await db.query('Productos', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ProductoModel.fromJson(res.first) : null;
  }

  Future<ProductoModel> getUltimoScanIncompleto() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM Productos WHERE id = (SELECT MAX(id) FROM Productos WHERE estado = 'INCOMPLETO')");

    return res.isNotEmpty ? ProductoModel.fromJson(res.first) : null;
  }

  Future<List<ProductoModel>> getTodosProductos() async {
    final db = await database;
    final res = await db.query('Productos');

    List<ProductoModel> list = res.isNotEmpty
        ? res.map((e) => ProductoModel.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<List<ProductoModel>> getProductosPorTipo(String tipo) async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM Productos WHERE tipo = '$tipo'");

    List<ProductoModel> list = res.isNotEmpty
        ? res.map((e) => ProductoModel.fromJson(e)).toList()
        : [];

    return list;
  }

  Future<int> updateScan(ProductoModel nuevoScan) async {
    final db = await database;

    final res = await db.update('Productos', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Productos', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteTodos() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Productos');

    return res;
  }
}
