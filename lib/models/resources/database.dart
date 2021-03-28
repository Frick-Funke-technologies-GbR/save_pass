import 'dart:async';

import 'package:path/path.dart';
import 'package:save_pass/models/classes/passwordentryClass.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {

  getDatabase() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'save_pass.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS password_entry(id INTEGER PRIMARY KEY, alias BLOB NOT NULL UNIQUE, url BLOB, username BLOB, password BLOB, notes BLOB, thumbnail BLOB, creation_date TEXT, encryption_salt BLOB)",
        );
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertPasswordEntry(
      PasswordEntryClass entry, String password) async {
    final Database db = await getDatabase();
    print('[DATABASE] Path: ' + db.path);
    Map<String, dynamic> encryptedEntry = await entry.toEncryptedMap(password);
    int result = await db.insert(
      'password_entry',
      encryptedEntry,
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );

    print('-result-:  ' + result.toString());
    // encryptedEntry.forEach((key, value) {print(key); print(value);});
  }

  Future<List<PasswordEntryClass>> getPasswordEntries(String password) async {
    final Database db = await getDatabase();
    print('[DATABASE] Path: ' + db.path);
    final List<Map<String, dynamic>> maps = await db.query('password_entry');

    // Convert the List<Map<String, dynamic> into a List<PasswordEntryClass> while decrypt the members contents
    List<PasswordEntryClass> passwordEntries = [];
    for (Map entry in maps) {
      print(';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');
      entry.forEach((key, value) {print(key + value.toString());});
      entry.remove('creation_date');
      print(';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');
      entry.forEach((key, value) {print(key + value.toString());});
      passwordEntries.add(await generatePasswordEntry(password, entry));
    }
    return passwordEntries;
  }

  Future<PasswordEntryClass> generatePasswordEntry(
      String password, Map<String, dynamic> map) async {
    return await PasswordEntryClass().fromEncryptedMap(
        password,
        map['id'],
        map['alias'],
        map['password'],
        map['username'],
        map['url'],
        map['notes'],
        map['thumbnail'],
        map['encryption_salt'],);
  }

  Future<bool> checkPassword(password) async {
    final Database db = await getDatabase();
    print('[DATABASE] Path: ' + db.path);
    List<Map<String, dynamic>> map;

    map = await db.query(
      'password_entry',
      where: 'id = ?',
      whereArgs: [1],
    );

    if (map.isEmpty) {
      return true;
    }

    Map<String, dynamic> mapAsMap = map[0];

    try {
      PasswordEntryClass().fromEncryptedMap(
        password,
        mapAsMap['id'],
        mapAsMap['alias'],
        mapAsMap['password'],
        mapAsMap['username'],
        mapAsMap['url'],
        mapAsMap['notes'],
        mapAsMap['thumbnail'],
        mapAsMap['encryption_salt'],
      );
      return true;
    } on Exception catch (e) {
      if (e.toString() == 'wrong_password') {
        return false;
      } else {
        throw Error(); // FIXME: e.toString() == 'wrong_password' does eventually not work
      }
    }
  }

  Future<void> updatePasswordEntry(
      PasswordEntryClass passwordEntry, String password) async {
    final Database db = await getDatabase();
    print('[DATABASE] Path: ' + db.path);
    await db.update(
      'password_entry',
      await passwordEntry.toEncryptedMap(password),
      where: 'id = ?',
      whereArgs: [passwordEntry.id],
    );
  }

  Future<void> deletePasswordEntry(int targetId) async {
    final Database db = await getDatabase();
    print('[DATABASE] Path: ' + db.path);
    await db.delete(
      'password_entry',
      where: 'id = ?',
      whereArgs: [targetId],
    );
  }

  Future<void> deleteAllPasswordEntries() async {
    final Database db = await getDatabase();
    print('[DATABASE] Path: ' + db.path);
    await db.delete('password_entry');
  }
}
