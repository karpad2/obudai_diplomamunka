import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:escape_room/models/Users.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database
  String userstable = 'users_table';
  String userId = 'user_id';
  String username = 'username';
  String password = 'password';
  String admin = 'admin';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $userstable($userId INTEGER PRIMARY KEY AUTOINCREMENT, $username TEXT, '
        '$password TEXT, $admin int)');
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'database.db';

    // Open/create the database at a given path
    var escaperoomDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return escaperoomDatabase;
  }
/*
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $userstable ($userId INTEGER PRIMARY KEY AUTOINCREMENT, $username TEXT, '
        '$password TEXT, $admin int)');
  }*/

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getUsersMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(userstable, orderBy: '$username ASC');
    return result;
  }

  // Insert Operation: Insert a todo object to database
  Future<int> insertTodo(User user) async {
    Database db = await this.database;
    var result = await db.insert(userstable, user.toMap());
    return result;
  }

  // Update Operation: Update a todo object and save it to database
  Future<int> updateTodo(User user) async {
    var db = await this.database;
    var result = await db.update(userstable, user.toMap(),
        where: '$userId = ?', whereArgs: [user.userId]);
    return result;
  }

  // Delete Operation: Delete a todo object from database
  Future<int> usersTodo(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $userstable WHERE $userId = $id');
    return result;
  }
/*
  // Get number of todo objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $todoTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<Todo>> getTodoList() async {
    var todoMapList = await getTodoMapList(); // Get 'Map List' from database
    int count =
        todoMapList.length; // Count the number of map entries in db table

    List<Todo> todoList = List<Todo>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      todoList.add(Todo.fromMapObject(todoMapList[i]));
    }
    return todoList;
  }*/
}
