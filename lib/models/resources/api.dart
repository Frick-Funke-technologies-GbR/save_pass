import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client, ClientException, Request;
import 'package:save_pass/models/classes/passwordentryClass.dart';
import 'package:save_pass/models/classes/userClass.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'package:retry/retry.dart';

class ApiProvider {
  Client client = Client();

  Future<UserClass> registerUser(
    bool googleSignIn,
    String username,
    String firstname,
    String lastname,
    String emailadress,
  ) async {
    final response = await client.post(
      // "http://10.0.2.2:5000/api/register",
      'https://savepass.frifu.de/api/register',
      // headers: "",
      body: jsonEncode(
        {
          "google_sign_in" : googleSignIn,
          "emailadress": emailadress,
          "username": username,
          "firstname": firstname,
          "lastname": lastname
        },
      ),
    );
    print('[DEBUG] Status of POST request (/api/register):' +
        response.statusCode.toString());
    stdout.write(response.statusCode);
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

  Future getUserData(
    String username,
  ) async {
    final response = await client.get(
      // "http://10.0.2.2:5000/api/login",
      'https://savepass.frifu.de/api/user_data',
      // headers: {
      //   "Authorization" : userIdent
      // },
      headers: {"username": username},
    );
    print('[DEBUG] Status of POST request (/api/user_data): ' +
        response.statusCode.toString());
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await _saveUserIdent(result["data"]["user_ident"]);
      await _saveUserName(result["data"]["username"]);
      await _saveFirstName(result["data"]["firstname"]);
      await _saveLastName(result["data"]["lastname"]);
      await _saveEmailAdress(result["data"]["emailadress"]);
    } else if (response.statusCode == 400) {
      throw Exception(result['message']);
    } else {
      // If that call was not successful, throw an error.
      print(json.decode(response.body).toString());
      throw Exception('Failed to get user data');
    }
  }

  Future<bool> login(
    String userIdent,
    String password,
  ) async {
    print('[DEBUG] userIdent: ' + userIdent.toString());
    final response = await client.get(
      // "http://10.0.2.2:5000/api/check_pass",
      'https://savepass.frifu.de/api/login',
      headers: {"user_ident": userIdent, "password": password},
    );
    print('[DEBUG] Status of GET request (/api/login):' +
        response.statusCode.toString());
    final Map result = json.decode(response.body);
    if (response.statusCode == 401) {
      return false;
    } else if (response.statusCode == 404) {
      if (result['reason'] == 'no password entries yet') {
        return null;
      }
    } else {
      _savePassword(password);
      return true;
    }
  }

  Future<List<PasswordEntryClass>> getUserPasswordEntries(
    String userIdent,
    String password,
  ) async {
    // try {
    // FIXME: Hardfix this ClientException 'connection closed while receiving data' bug
    print('[DEBUG] userIdent ' + userIdent);
    final response = await retry(
      () => client.get(
        // "http://10.0.2.2:5000/api/password_entry",
        'https://savepass.frifu.de/api/password_entry',
        headers: {"user_ident": userIdent, "password": password},
      ),
      // .then((resp) {
      //   print('[DEBUG] Status of GET request (/api/password_entry): ' + resp.statusCode.toString());
      // }),
      retryIf: (e) => e is ClientException,
    );
    // final response = await
    print(response.body);
    final Map<String, dynamic> result = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<PasswordEntryClass> passwordEntries = [];
      // check if password is correct. May be unnecessary because password is already checked within login progress
      if (result.containsKey('status') &&
          result['status'] == 'failure' &&
          result['reason'] == 'wrong password') {
        throw Exception('Wrong password');
      }
      // print('following is result[\'data\']');
      // print(result['data'].toString());
      for (Map<String, dynamic> json_ in result["data"]) {
        try {
          // print(PasswordEntryClass.fromJson(json_).toString());
          passwordEntries.add(PasswordEntryClass.fromJson(json_));
        } catch (Exception) {
          print(
              '[DEBUG] Exception occured while GET request (/api/password_entry): ' +
                  Exception.toString());
          return null;
        }
      }
      for (PasswordEntryClass passwordEntry in passwordEntries) {
        print(passwordEntry.alias + passwordEntry.notes);
      }
      return passwordEntries ?? '';
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load password entries');
    }
    // } on ClientException catch (e) {
    //   print('[DEBUG] Client exception occured:');
    //   print(e.message);
    //   print('[DEBUG] Retry in 2,5 seconds...');
    //   // await new Future.delayed(const Duration(seconds: 5));
    //   retryFuture(getUserPasswordEntries, 2500);
    //   // this.getUserPasswordEntries(userIdent, password);
    //   // print('LALALALLALALLA');
    //   // ApiProvider().getUserPasswordEntries(userIdent, password);
    //   // print('LALALALLALALLA2');
    // }
  }

  Future addUserPasswordEntry(
    String userIdent,
    String masterPassword,
    String alias,
    String url,
    String username,
    String password,
    String notes,
  ) async {
    final response = await client.post(
      // "http://10.0.2.2:5000/api/password_entry",
      'https://savepass.frifu.de/api/password_entry',
      headers: {
        "user_ident": userIdent,
        'password': masterPassword,
      },
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
    print('[DEBUG] Status of POST request (/api/register): ' +
        response.statusCode.toString());
    if (response.statusCode == 200) {
      print("[DEBUG] ^ Entry added");
    } else {
      // If that call was not successful, throw an error.
      var responsebody = json.decode(response.body);
      // print(responsebody.toString());
      if (responsebody['message'] == "Entry with given alias already exists")
        throw Exception('Failed to add entry');
    }
  }

  Future deleteUserPasswordEntry(
    int where,
    bool all,
    String userIdent,
    String masterPassword,
  ) async {
    try {
      final response = await client.send(Request(
          "DELETE", Uri.parse("https://savepass.frifu.de/api/password_entry"))
        ..headers['user_ident'] = userIdent
        ..headers['password'] = masterPassword
        ..body = jsonEncode({
          "where": where,
          "what": all ? 'all' : "only",
          "alias": "None",
        }));
      print('[DEBUG] Status of POST request (/api/register): ' +
          response.statusCode.toString());
      if (response.statusCode == 204) {
        return true;
      } else {
        // Map<String, dynamic> result = json.decode(response.reasonPhrase);
        // Stream result = response.stream;
        // var sum = {};
        // await for (var value in result) {
        //   sum.addEntries(value);
        // }
        // dynamic resultPrintbable = await json.decode(sum);
        // print(resultPrintbable);
        throw Exception('Error: delete failed');
      }
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> getGeneratedPassword(
    int length,
    int complexity,
    bool words,
    bool specialchar,
    bool uppercase,
    bool lowercase,
    bool numbers,
  ) async {
    final response = await client.get(
      'https://savepass.frifu.de/api/generate_password',
      headers: {
        'length': length.toString(),
        'complexity': complexity.toString(),
        'words': words.toString(),
        'specialchar': specialchar.toString(),
        'uppercase': uppercase.toString(),
        'lowercase': lowercase.toString(),
        'numbers': numbers.toString(),
      },
    );
    print('[DEBUG] Status of GET request (/api/generate_password): ' +
        response.statusCode.toString());
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['data'];
      return data;
    } else {
      final Map<String, dynamic> message =
          json.decode(response.body)['message'];
      throw Exception(message);
    }
  }

  // retryFuture(future, int delay) {
  //   Future.delayed(Duration(milliseconds: delay), () {
  //     future();
  //   });
  // }

  _saveUserIdent(String userIdent) {
    CacheHandler cache = CacheHandler();
    cache.addSecureStringToCache('user_ident', userIdent);
  }

  _saveUserName(String userName) {
    CacheHandler cache = CacheHandler();
    // print(userName.toString() + '_________________________________________________________________________');
    cache.addSecureStringToCache('user_name', userName);
  }

  _saveFirstName(String firstName) {
    CacheHandler cache = CacheHandler();
    cache.addSecureStringToCache('first_name', firstName);
  }

  _saveLastName(String lastName) {
    CacheHandler cache = CacheHandler();
    cache.addSecureStringToCache('last_name', lastName);
  }

  _saveEmailAdress(String emailAdress) {
    CacheHandler cache = CacheHandler();
    cache.addSecureStringToCache('email_adress', emailAdress);
  }

  _savePassword(String password) {
    CacheHandler cache = CacheHandler();
    cache.addSecureStringToCache('master_password', password);
  }
}
