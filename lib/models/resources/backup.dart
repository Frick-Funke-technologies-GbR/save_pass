import 'dart:async';

import 'dart:convert';
import 'dart:io';

import 'package:save_pass/models/classes/passwordentryClass.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'package:save_pass/models/resources/database.dart';

class Backup {
  Future<Directory?> getPwd() async {
    Directory? pwd = await CacheHandler().getStorageDirectory();
    return pwd;
  }

  Future<bool> backupData() async {
    // validate this function
    Directory path = await (getPwd() as FutureOr<Directory>);
    DateTime now = DateTime.now();
    CacheHandler cache = CacheHandler();
    DatabaseHandler db = DatabaseHandler();
    Directory backupsPath = Directory(
        path.path + '/backups'); // FIXME: Could be an other path in IOS
    backupsPath.createSync(); // create backups dir if not existing yet
    File backupFile =
        File(backupsPath.path + '/${now.toIso8601String().split('.')[0]}.spb');
    String? passwordHash = await cache.getSecureStringFromCache(
        'master_password'); // TODO: IMPORTANT FIX BEFORE LAUNCH!!! Add password derivation/hash function here
    String body = jsonEncode(
      {
        'info': {
          'creation_date': now.toIso8601String(),
          'created_by': 'mobile_client',
          'synced_with_server':
              await cache.getBoolFromCache('passwords_synced'),
          'last_sync_datetime':
              await cache.getStringFromCache('last_sync_datetime')
        },
        'user': {
          'user_name': await cache.getSecureStringFromCache('user_name'),
          'user_ident': await cache.getSecureStringFromCache('user_ident'),
          'first_name': await cache.getSecureStringFromCache('first_name'),
          'last_name': await cache.getSecureStringFromCache('last_name'),
          'email_adress': await cache.getSecureStringFromCache('email_adress'),
          'password': passwordHash,
          'register_date': null,
          'last_login_date': null,
          'google_sign_in': null
        },
        'data': {
          'password_entries': _passwordEntriesToList(
            await db.getEncryptedPasswordEntries(),
          ),
        },
      },
    );
    await backupFile.writeAsBytes(body.codeUnits).catchError((e) => throw e);
    print('wrote ${backupFile.path}');
    return true;
  }

  Future<List<DateTime>?> listBackupsByDate() async {
    Directory path = await (getPwd() as FutureOr<Directory>);
    Directory backupsPath = Directory(
        path.path + '/backups'); // FIXME: Could be an other path in IOS
    backupsPath.createSync(); // create backups dir if not existing yet

    // TODO: Add function to list backup dates
  }

  Future<bool>? retrieveDataFromBackup() {
    // TODO: Add function to retrieve Data from certain backup
  }

  List<Map<String, dynamic>> _passwordEntriesToList(
      List<EncryptedPasswordEntryClass> passwordEntries) {
    List<Map<String, dynamic>> list = [];
    // FIXME: Eventually, encode with base64 before storing
    for (EncryptedPasswordEntryClass entry in passwordEntries) {
      list.add(
        {
          'alias': entry.alias,
          'creation_date': entry.creationDate,
          'encryption_salt': entry.encryptionSalt,
          'id': entry.id,
          'notes': entry.notes,
          'password': entry.password,
          'thumbnail': null,
          'url': entry.url,
          'user_name': entry.username,
        },
      );
    }
    return list;
  }
}
