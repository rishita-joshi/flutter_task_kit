import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/user_model.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'planets.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        return db.execute(
          'CREATE TABLE task(id INTEGER PRIMARY KEY, opration TEXT , value1 TEXT , value2 TEXT,  ans TEXT)',
        );
      },
    );
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final db = await initializedDB();
    return await db.insert('task', row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await initializedDB();
    return await db.query('task');
  }

  Future<List<UserModel>> getData() async {
    List<UserModel> cal = [];
    final db = await initializedDB();
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('task');
    for (int i = 1; i < maps.length; i++) {
      cal.add(UserModel.fromMap(maps[i]));
    }
    return cal;
  }
}
