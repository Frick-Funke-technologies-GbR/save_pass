import 'dart:convert';

import 'package:connectivity/connectivity.dart';
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
    
    if (!await checkConnectionAvailability()) {
      throw Exception('No valid connection available');
    }
    
    CacheHandler cache = CacheHandler();
    DatabaseHandler db = DatabaseHandler();
    ApiProvider api = ApiProvider();

    bool didSendToCloud = false;
    bool didSendToDB = false;

    if (!bypassSyncedCheck) {
      if (await cache.getBoolFromCache('passwords_synced')) {
        return true;
      }
    }

    List<EncryptedPasswordEntryClass> localEntries =
        await db.getEncryptedPasswordEntries();

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
          print('Attempting to insert local password entry');
          db.insertEncryptedPasswordEntry(i);
          didSendToDB = true;
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
          print('Attempting to send password entry to backend recource server');
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
          didSendToCloud = true;
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

    await cache.addBoolToCache('did_send_to_cloud', didSendToCloud);
    await cache.addBoolToCache('did_send_to_db', didSendToDB);

    if (didSendToDB && didSendToDB) {
      await cache.addBoolToCache('passwords_synced', true); // singalize, that passwords are synced
      await cache.addStringToCache('last_sync_datetime', DateTime.now().toString()); // save sync time
    }

    print('test');

    return true;
  }


  Future<bool> checkConnectionAvailability() async {
    Connectivity connect = Connectivity();
    CacheHandler cache = CacheHandler();
    ConnectivityResult result = await connect.checkConnectivity();
    print('ConnectivityResult: ' + result.index.toString());
    bool syncOverCellular = false;
    try {
      syncOverCellular = await cache.getBoolFromCache('sync_over_cellular');
    } on Exception {
      syncOverCellular = false;
    } 
    syncOverCellular ??= false;
    if (syncOverCellular) {
      if (result == ConnectivityResult.mobile) {
        return true;
      } else if (result == ConnectivityResult.wifi) {
        return true;
      } else if (result == ConnectivityResult.none) {
        return false;
      }
    } else {
      if (result == ConnectivityResult.mobile) {
        return false;
      } else if (result == ConnectivityResult.wifi) {
        return true;
      } else if (result == ConnectivityResult.none) {
        return false;
      }
    }
  }
}
