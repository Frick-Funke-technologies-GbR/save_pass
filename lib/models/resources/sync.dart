// TODO: Add state changing sync class

import 'package:save_pass/models/classes/passwordentryClass.dart';
import 'package:save_pass/models/resources/api.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'package:save_pass/models/resources/database.dart';

class Sync {

  Future<bool> normalSync() async {
    CacheHandler cache = CacheHandler();
    DatabaseHandler db = DatabaseHandler();
    ApiProvider api = ApiProvider();

    List<EncryptedPasswordEntryClass> entries = await db.getEncrpytedPasswordEntries();


  }

}
