import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:barcode/src/models/scan_model.dart';
export 'package:barcode/src/models/scan_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  //Constructor privado
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDb();

    return _database;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'scansDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT,'
          ' formato TEXT,'
          ' formatoNota TEXT'
          ')');
    });
  }

  nuevoScanRaw(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.rawInsert(
        "INSERT Into Scans (id, tipo, valor, formato, formatoNota) "
        "VALUES (${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}', '${nuevoScan.formato}', '${nuevoScan.formatoNota}')");

    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;

    final res = await db.insert('Scans', nuevoScan.toJson());

    return res;
  }

  Future<ScanModel> getScanId(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getTodosScans() async {
    final db = await database;
    final res = await db.query('Scans');

    List<ScanModel> list =
        res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];

    return list;
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo = '$tipo'");

    List<ScanModel> list =
        res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];

    return list;
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;

    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteTodos() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Scans');

    return res;
  }
}
