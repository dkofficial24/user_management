import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:user_management/shared/shared.dart';
import 'package:user_management/user/model/address_model.dart';
import 'package:user_management/user/model/company_model.dart';
import 'package:user_management/user/model/user_model.dart';

class UserDbService {
  static const databaseName = 'user_database.db';
  static const userTableName = 'users';
  late Database database;

  Future<void> initDatabase() async {
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
        name TEXT,
        username TEXT,
        email TEXT,
        phone TEXT,
        website TEXT,
        street TEXT,
        city TEXT,
        companyName TEXT,
        catchPhrase TEXT,
        bs TEXT
      )
    ''');
  }

  Future<List<UserModel>> getUsers() async {
    List<Map<String, dynamic>> userMaps = await database.query(userTableName);
    return userMaps.map((userMap) {
      return UserModel(
        id: userMap['id'],
        name: userMap['name'],
        username: userMap['username'],
        email: userMap['email'],
        address: Address(
          street: userMap['street'],
          city: userMap['city'],
        ),
        phone: userMap['phone'],
        website: userMap['website'],
        company: Company(
          name: userMap['companyName'],
          catchPhrase: userMap['catchPhrase'],
          bs: userMap['bs'],
        ),
      );
    }).toList();
  }


  Future<void> saveUsers(List<UserModel> users) async {
    try {
      Batch batch = database.batch();

      for (final user in users) {
        batch.insert(
          userTableName,
          {
            'id': user.id,
            'name': user.name,
            'username': user.username,
            'email': user.email,
            'street': user.address?.street,
            'city': user.address?.city,
            'phone': user.phone,
            'website': user.website,
            'companyName': user.company?.name,
            'catchPhrase': user.company?.catchPhrase,
            'bs': user.company?.bs,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit();
    } catch (e) {
      Log.e('saveUsers: $e');
    }
  }

}
