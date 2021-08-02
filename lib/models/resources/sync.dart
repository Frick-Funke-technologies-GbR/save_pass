// TODO: Add state changing sync class

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:save_pass/models/classes/passwordentryClass.dart';
import 'package:save_pass/models/resources/api.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'package:save_pass/models/resources/database.dart';

class Sync {
  Future<bool> normalSync(
      [bool bypassSyncedCheck = false, BuildContext context]) async {
    CacheHandler cache = CacheHandler();
    DatabaseHandler db = DatabaseHandler();
    ApiProvider api = ApiProvider();

    if (!bypassSyncedCheck) {
      if (await cache.getBoolFromCache('passwords_synced')) {
        return true;
      }
    }

    List<EncryptedPasswordEntryClass> localEntries =
        await db.getEncrpytedPasswordEntries();

    String userIdent = await cache.getSecureStringFromCache('user_ident');
    String masterPassword =
        await cache.getSecureStringFromCache('master_password');
    List<int> salt =
        base64Decode((await cache.getStringFromCache('key_derivation_salt')))
            .toList();

    List<List<int>> localEntriesAlias = [];

    for (EncryptedPasswordEntryClass i in localEntries) {
      localEntriesAlias.add(i.alias);
    }

    try {
      List<EncryptedPasswordEntryClass> cloudEntries =
          await api.getEncryptedUserPasswordEntries(userIdent, masterPassword);

      for (EncryptedPasswordEntryClass i in cloudEntries) {
        bool contains = false;
        for (List<int> localAlias in localEntriesAlias) {
          if (listEquals(localAlias, i.alias)) {
            contains = true;
          }
        }
        if (!contains) {
          db.insertEncryptedPasswordEntry(i);
        }
      }

      for (List<int> i in localEntriesAlias) {
        bool contains = false;
        for (EncryptedPasswordEntryClass cloudEntry in cloudEntries) {
          if (listEquals(cloudEntry.alias, i)) {
            contains = true;
          }
        }
        if (!contains) { // FIXME: START - somewhere here seems to be an comparison error
          int index =
              localEntriesAlias.indexWhere((element) => listEquals(i, element));
          EncryptedPasswordEntryClass localEntry =
              localEntries.elementAt(index);
          api.addUserPasswordEntry(
            userIdent,
            masterPassword,
            localEntry.alias,
            localEntry.url,
            localEntry.username,
            localEntry.password,
            localEntry.notes,
            localEntry.encryptionSalt,
          ); // FIXME: END
        }
      }
    } on Exception catch (e) {
      print('following is the exception');
      print(e);
      return false;
    }

    // if (context != null) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar());
    // }

    await cache.addBoolToCache(
        'passwords_synced', true); // singalize, that passwords are synced

    print('test');

    return true;
  }
}
