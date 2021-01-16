import 'dart:convert';

import 'package:save_pass/widgets/passwordscreen/passwordentry.dart';

class PasswordEntryClass {
  int id;
  String alias;
  String password;
  String username;
  String url;
  String notes;
  int thumbnailId;
  String creationDate;

  PasswordEntryClass(
      this.id, this.alias, this.password, this.username, this.url, this.notes);

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
    );
    print('following is result in PasswordEntryClass.fromJson():');
    print(result.alias + ';' + result.notes + ';' + result.password + ';' + result.username);
    return result;
  }

  // String asString() {
  //   string = id.toString();
  // }

}
