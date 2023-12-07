import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:super_note/Models/NoteModel.dart';

class MasterDB {
  static final nameDB = 'MOVIEDB';
  static final versionDB = 1;
  Map? tempu;
  List<NoteModel>? liti;

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(pathDB, version: versionDB, onCreate: _createTables);
  }

  FutureOr<void> _createTables(Database db, int version) {
    String query1 = '''CREATE TABLE tblNotes(
        IdNote INTEGER PRIMARY KEY,
        title VARCHAR(100),
        description VARCHAR(100),
        importancia INTEGER,
        notificacion INTEGER,
        tiempo VARCHAR(100));''';
    db.execute(query1);
  }

//Career---------------------------------------
  Future<int> INSERT_Note(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> DELETE_Note(String tblName, String id) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'IdNote = ?', whereArgs: [id]);
  }

  Future<List<NoteModel>> GETALL_Note() async {
    var conexion = await database;
    var result = await conexion!.query('tblNotes');
    return result
        .map((task) => NoteModel.fromMap(task))
        .toList(); //muevete en cada elemento y genera la lista
  }

  Future<int> UPDATE_Note(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'IdNote = ?', whereArgs: [data['IdNote']]);
  }

  Future<int> GETID_NOTI() async {
    var conexion = await database;
    var result = await conexion!.rawQuery(
        'SELECT * FROM tblNotes WHERE IdNote = (SELECT MAX(IdNote) FROM tblNotes)');
    liti = result.map((task) => NoteModel.fromMap(task)).toList();
    //print("esta" + liti.toString());
    return liti![0].idnote!;
  }

  /*
  //----------------------------------------------
  Future<int> INSERT_Favo(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> DELETE_Favo(String tblName, String id) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<PopularModel>> GETALL_Favo() async {
    var conexion = await database;
    var result = await conexion!.query('tblFavoritoMovie');
    return result
        .map((task) => PopularModel.fromMap(task))
        .toList(); //muevete en cada elemento y genera la lista
  }*/
}
