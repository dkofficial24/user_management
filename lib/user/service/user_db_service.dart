import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:user_management/shared/shared.dart';
import 'package:user_management/user/model/user_model.dart';

class UserDbService {
  static const databaseName = 'user_database.db';
  static const userTableName = 'users';
  late Database database;

  Future initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $userTableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userJson TEXT
      )
    ''');
  }

  Future<List<UserModel>> getUsers() async {
    List<Map<String, dynamic>> userMaps = await database.query(userTableName);

    return userMaps
        .map((userMap) => UserModel.fromJson(jsonDecode(userMap['userJson'])))
        .toList();
  }

  Future<void> saveUsers(List<UserModel> users) async {
    try {
      Batch batch = database.batch();

      for (UserModel user in users) {
        batch.insert(
          userTableName,
          {'userJson': jsonEncode(user.toJson())},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit();
    } catch (e) {
      Log.e('saveUsers: $e');
    }
  }
}
