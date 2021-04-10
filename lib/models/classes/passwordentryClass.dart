import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:save_pass/models/resources/database.dart';
import 'package:save_pass/models/resources/cryptograph.dart';

class PasswordEntryClass {
  int id;
  String alias;
  String password;
  String username;
  String url;
  String notes;
  String thumbnail; // FIXME: add to string
  String creationDate;
  List<int> encryptionSalt;

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
    print(result.alias +
        ';' +
        result.notes +
        ';' +
        result.password +
        ';' +
        result.username);
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
      'thumbnail': thumbnail
    };
  }

  Future<Map<String, dynamic>> toEncryptedMap(String password) async {
    Cryptograph c = Cryptograph(password);
    // List<int> salt = c.salt;
    List<int> key = await c.generateKeyFromPass();
    
    return {
      'alias': Uint8List.fromList(await c.encrypt(alias, key)),
      'password': Uint8List.fromList(await c.encrypt(password, key)),
      'username': Uint8List.fromList(await c.encrypt(username, key)),
      'url': Uint8List.fromList(await c.encrypt(url, key)),
      'notes': Uint8List.fromList(await c.encrypt(notes, key)),
      'thumbnail': Uint8List.fromList(await c.encrypt(thumbnail, key)),  // Also encrypt thumbnail, because hackers might conclude the password from it...
      'encryption_salt': Uint8List.fromList(c.salt),
    };
  }

  Future<PasswordEntryClass> fromEncryptedMap(
    String masterPassword,
    int id,
    List<int> alias,
    List<int> password,
    List<int> username,
    List<int> url,
    List<int> notes,
    List<int> thumbnail,
    List<int> salt,
  ) async {
    Cryptograph c = Cryptograph(masterPassword);
    List<int> key = await c.generateKeyFromPass(keySalt: salt);
    try {
      return PasswordEntryClass(
        id,
        await c.decrypt(alias, key, salt: salt),
        await c.decrypt(password, key, salt: salt),
        await c.decrypt(username, key, salt: salt),
        await c.decrypt(url, key, salt: salt),
        await c.decrypt(notes, key, salt: salt),
        await c.decrypt(thumbnail, key, salt: salt),
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
