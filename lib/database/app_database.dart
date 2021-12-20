import 'package:crafting_games/database/craft_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'craftinggames.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(CraftDao.tableSql);
  }, version: 1);
}
