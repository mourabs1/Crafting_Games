import 'package:crafting_games/database/app_database.dart';
import 'package:crafting_games/models/craft.dart';
import 'package:sqflite/sqflite.dart';

class CraftDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_nivel INTEGER)';
  static const String _tableName = 'crafts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _nivel = 'nivel';

  Future<int> save(Craft craft) async {
    final Database db = await getDatabase();
    Map<String, dynamic> craftMap = _toMap(craft);
    return db.insert(_tableName, craftMap);
  }

  Future<int> update(Craft craft) async {
    final Database db = await getDatabase();
    Map<String, dynamic> craftMap = _toMap(craft);
    print(craftMap);
    return db
        .update(_tableName, craftMap, where: 'id = ?', whereArgs: [craft.id]);
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Craft>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Craft> crafts = _toList(result);
    return crafts;
  }

  Map<String, dynamic> _toMap(Craft craft) {
    final Map<String, dynamic> craftMap = Map();
    craftMap[_name] = craft.name;
    craftMap[_nivel] = craft.nivel;
    return craftMap;
  }

  List<Craft> _toList(List<Map<String, dynamic>> result) {
    final List<Craft> crafts = [];
    for (Map<String, dynamic> row in result) {
      final Craft craft = Craft(
        row[_id],
        row[_name],
        row[_nivel],
      );
      crafts.add(craft);
    }
    return crafts;
  }
}
