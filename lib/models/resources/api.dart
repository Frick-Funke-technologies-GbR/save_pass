import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:save_pass/models/classes/passwordentryClass.dart';
import 'package:save_pass/models/classes/userClass.dart';
import 'package:save_pass/models/resources/cache.dart';

class ApiProvider {
  Client client = Client();

  Future<UserClass> registerUser(String username, String firstname,
      String lastname, String emailadress) async {
    final response = await client.post(
      "http://10.0.2.2:5000/api/register",
      // headers: "",
      body: jsonEncode(
        {
          "emailadress": emailadress,
          "username": username,
          "firstname": firstname,
          "lastname": lastname
        },
      ),
    );
    final Map result = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      await _saveUserIdent(result["data"]["user_ident"]);
      return UserClass.fromJson(result["data"]);
    } else if (response.statusCode == 400) {
      // If email or username already exist, throw an error
      String error = result["message"];
      throw Exception('$error');
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to register');
    }
  }

  Future loginUser(String username) async {
    final response = await client.post(
      "http://10.0.2.2:5000/api/login",
      // headers: {
      //   "Authorization" : userIdent
      // },
      body: jsonEncode(
        {
          "username": username,
        },
      ),
    );
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await _saveUserIdent(result["data"]["user_ident"]);
      await _saveUserName(result["data"]["user_name"]);
      await _saveFirstName(result["data"]["first_name"]);
      await _saveLastName(result["data"]["last_name"]);
      await _saveEmailAdress(result["data"]["email_adress"]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to login');
    }
  }

  Future<bool> checkPass(String userIdent, String password) async {
    final response = await client.get(
      "http://10.0.2.2:5000/api/check_pass",
      headers: {"user_ident": userIdent, "password": password},
    );
    final Map result = json.decode(response.body);
    if (result['status'] == 'failure' && result['reason'] == 'wrong password') {
      return false;
    } else {
      _savePassword(password);
      return true;
    }
  }

  Future<List<PasswordEntryClass>> getUserPasswordEntries(
      String userIdent, String password) async {
    final response = await client.get(
      "http://10.0.2.2:5000/api/password_entry",
      headers: {"user_ident": userIdent, "password": password},
    );
    print('point1');
    final Map<String, dynamic> result = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<PasswordEntryClass> passwordEntries = [];
      print('point2');
      // check if password is correct. May be unnecessary because password is already checked within login progress
      if (result.containsKey('status') &&
          result['status'] == 'failure' &&
          result['reason'] == 'wrong password') {
        print('point3');
        throw Exception('Wrong password');
      }
      print('following is result[\'data\']');
      print(result['data'].toString());
      for (Map<String, dynamic> json_ in result["data"]) {
        try {
          print('point3.5');
          print(PasswordEntryClass.fromJson(json_).toString());
          passwordEntries.add(PasswordEntryClass.fromJson(json_));
        } catch (Exception) {
          print(Exception);
          return null;
        }
      }
      for (PasswordEntryClass passwordEntry in passwordEntries) {
        print(passwordEntry.alias + passwordEntry.notes);
      }
      return passwordEntries;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load password entries');
    }
  }

  Future addUserPasswordEntry(String userIdent, String masterPassword, String alias, String url,
      String username, String password, String notes) async {
    final response = await client.post(
      "http://10.0.2.2:5000/api/password_entry",
      headers: {"user_ident": userIdent, 'password': masterPassword},
      body: jsonEncode(
        {
          'alias': alias,
          'url': url,
          'username': username,
          'password': password,
          'notes': notes
        },
      ),
    );
    if (response.statusCode == 200) {
      print("entry added");
    } else {
      // If that call was not successful, throw an error.
      var responsebody = json.decode(response.body);
      print(responsebody);
      if (responsebody['message'] == "Entry with given alias already exists")
      throw Exception('Failed to add entry');
    }
  }

  _saveUserIdent(String userIdent) {
    CacheHandler cache = CacheHandler();
    cache.addStringToCache('user_ident', userIdent);
  }

  _saveUserName(String userName) {
    CacheHandler cache = CacheHandler();
    cache.addStringToCache('user_name', userName);
  }

  _saveFirstName(String firstName) {
    CacheHandler cache = CacheHandler();
    cache.addStringToCache('first_name', firstName);
  }

  _saveLastName(String lastName) {
    CacheHandler cache = CacheHandler();
    cache.addStringToCache('last_name', lastName);
  }

  _saveEmailAdress(String emailAdress) {
    CacheHandler cache = CacheHandler();
    cache.addStringToCache('last_name', emailAdress);
  }

  _savePassword(String password) {
    CacheHandler cache = CacheHandler();
    cache.addStringToCache('master_password', password);
  }
}
