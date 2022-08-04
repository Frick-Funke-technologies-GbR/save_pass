import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'package:save_pass/models/resources/database.dart';
import 'package:save_pass/models/resources/cryptograph.dart';

class PasswordEntryClass {
  int? id;
  String? alias;
  String? password;
  String? username;
  String? url;
  String? notes;
  String? thumbnail; // FIXME: add to string
  String? creationDate;
  List<int>? encryptionSalt;

  PasswordEntryClass([
    this.id,
    this.alias,
    this.password,
    this.username,
    this.url,
    this.notes,
    this.thumbnail,
    this.encryptionSalt,
  ]);

  factory PasswordEntryClass.fromJson(Map<String, dynamic> parsedJson) {
    print('Point_fromJson');
    print(parsedJson.toString());
    PasswordEntryClass result = PasswordEntryClass(
      parsedJson['id'],
      parsedJson['alias'],
      parsedJson['password'],
      parsedJson['username'],
      parsedJson['url'],
      parsedJson['notes'],
      parsedJson['thumbnail'],
    );
    print('following is result in PasswordEntryClass.fromJson():');
    print(result.alias! +
        ';' +
        result.notes! +
        ';' +
        result.password! +
        ';' +
        result.username!);
    return result;
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'alias': alias,
      'password': password,
      'username': username,
      'url': url,
      'notes': notes,
      'thumbnail': thumbnail,
      'encryption_salt': encryptionSalt
    };
  }

  Future<Map<String, dynamic>> toEncryptedMap(
      String? encryptionPassword) async {
    // Salt changes with every new reference meaning with every new password entry encryption
    Cryptograph c = Cryptograph(encryptionPassword);
    // List<int> salt = c.salt;
    List<int> key = await c.generateKeyFromPass(
        keySalt: base64Decode(await (CacheHandler()
            .getStringFromCache('key_derivation_salt') as FutureOr<String>)));
    return {
      'alias': Uint8List.fromList(await c.encrypt(alias!, key)),
      'password': Uint8List.fromList(await c.encrypt(password!, key)),
      'username': Uint8List.fromList(await c.encrypt(username!, key)),
      'url': Uint8List.fromList(await c.encrypt(url!, key)),
      'notes': Uint8List.fromList(await c.encrypt(notes!, key)),
      'thumbnail': Uint8List.fromList(await c.encrypt(thumbnail!,
          key)), // Also encrypt thumbnail, because hackers might conclude the password from it.
      'encryption_salt': Uint8List.fromList(c.encryptionSalt!),
    };
  }

  Future<PasswordEntryClass> fromEncryptedMap(
    String? masterPassword,
    int? id,
    List<int> alias,
    List<int> password,
    List<int> username,
    List<int> url,
    List<int> notes,
    List<int>? thumbnail,
    List<int>? encryptionSalt,
    List<int> salt,
  ) async {
    Cryptograph c = Cryptograph(masterPassword);
    List<int> key = await c.generateKeyFromPass(keySalt: salt);
    try {
      return PasswordEntryClass(
        id,
        await c.decrypt(alias, key, salt: encryptionSalt),
        await c.decrypt(password, key, salt: encryptionSalt),
        await c.decrypt(username, key, salt: encryptionSalt),
        await c.decrypt(url, key, salt: encryptionSalt),
        await c.decrypt(notes, key, salt: encryptionSalt),
        thumbnail != null
            ? await c.decrypt(thumbnail, key, salt: encryptionSalt)
            : '',
      );
    } on SecretBoxAuthenticationError catch (e) {
      print(e);
      throw Exception('wrong_password');
    }
  }
}

class PasswordEntryDatabaseActions {
  String password;

  PasswordEntryDatabaseActions(this.password);

  DatabaseHandler db = DatabaseHandler();

  Future<bool> login() async {
    // Cryptograph c = Cryptograph(password);
    bool checkedIn = await db.checkPassword(password);
    return checkedIn;
  }
}

class EncryptedPasswordEntryClass {
  int? id;
  List<int>? alias;
  List<int>? password;
  List<int>? username;
  List<int>? url;
  List<int>? notes;
  List<int>? thumbnail;
  List<int>? creationDate;
  List<int>? encryptionSalt;

  EncryptedPasswordEntryClass([
    this.id,
    this.alias,
    this.password,
    this.username,
    this.url,
    this.notes,
    this.thumbnail,
    this.encryptionSalt,
  ]);

  Map<String, dynamic> toUin8ListMap(EncryptedPasswordEntryClass entry) {
    return {
      'alias': Uint8List.fromList(entry.alias!),
      'password': Uint8List.fromList(entry.password!),
      'username': Uint8List.fromList(entry.username!),
      'url': Uint8List.fromList(entry.url!),
      'notes': Uint8List.fromList(entry.notes!),
      'thumbnail': Uint8List.fromList(entry.thumbnail!),
      'encryption_salt': Uint8List.fromList(entry.encryptionSalt!),
    };
  }

  factory EncryptedPasswordEntryClass.fromJson(
      Map<String, dynamic> parsedJson) {
    EncryptedPasswordEntryClass result = EncryptedPasswordEntryClass(
      parsedJson['id'],
      base64.decode(parsedJson['alias']),
      base64.decode(parsedJson['password']),
      base64.decode(parsedJson['username']),
      base64.decode(parsedJson['url']),
      base64.decode(parsedJson['notes']),
      parsedJson['thumbnail'] != null
          ? base64.decode(parsedJson['thumbnail'])
          : [],
      base64.decode(parsedJson['encryption_salt']),
    );
    return result;
  }

  Future<EncryptedPasswordEntryClass> fromMap(
    int? id,
    List<int>? alias,
    List<int>? password,
    List<int>? username,
    List<int>? url,
    List<int>? notes,
    List<int>? thumbnail,
    List<int>? encryptionSalt,
  ) async {
    return EncryptedPasswordEntryClass(
      id,
      alias,
      password,
      username,
      url,
      notes,
      thumbnail,
      encryptionSalt,
    );
  }
}
