import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:save_pass/widgets/passwordscreen/passwordentry.dart';

class PasswordEntryClass {
  int id;
  String alias;
  String password;
  String username;
  String url;
  String notes;
  String thumbnail;
  String creationDate;

  PasswordEntryClass(
      this.id, this.alias, this.password, this.username, this.url, this.notes, this.thumbnail);

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
    print(result.alias + ';' + result.notes + ';' + result.password + ';' + result.username);
    return result;
  }

  // String asString() {
  //   string = id.toString();
  // }

}
