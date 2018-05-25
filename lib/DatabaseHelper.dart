import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite_demo/Note.dart';



class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Note(id INTEGER PRIMARY KEY, classname TEXT, note TEXT)"); // Fix table
    print("Table is created");
  }

//insertion
  Future<int> saveNote(Note note) async {
    var dbClient = await db;
    int res = await dbClient.insert("Note", note.toMap()); //Fix to map
    return res;
  }

  //deletion
  Future<int> deleteNote(Note note) async {
    var dbClient = await db;
    int res = await dbClient.delete("Note", where: "classname = ?", whereArgs: [note.classname]);
    return res;
  }

  Future<int> eraseNote() async {
    var dbClient = await db;
    int res = await dbClient.delete("Note");
    return res;
  }

  Future<List<Map<String,dynamic>>> selectNote() async {
    var dbClient = await db;
    List<Map<String,dynamic>> res = await dbClient.rawQuery('SELECT * FROM "Note"');
    return res;
  }



}