import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' show Client, ClientException, Request;
import 'package:save_pass/models/authentication/auth.dart';
import 'package:save_pass/models/classes/passwordentryClass.dart';
import 'package:save_pass/models/classes/userClass.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'package:retry/retry.dart';

class ApiProvider {
  // FIXME: Add server reachability check e.g. by checking connection to internet
  Client client = Client();

  Future<Uint8List> getIconAsBlob(String domain) async {
    try {
      final response = await client
          .get('https://logo.clearbit.com/$domain?size=600&format=png');
      print(
          '[DEBUG] Icon GET request Status: ${response.statusCode.toString()}');

      // If domain does not exist in clearbit db:
      if (response.statusCode == 404) {
        throw Exception(1);
      }
      return response.bodyBytes;
    } on HttpException {
      return null;
    }
  }

  // Future<UserClass> registerUser(
  //   bool googleSignIn,
  //   String username,
  //   String firstname,
  //   String lastname,
  //   String emailadress,
  //   // TODO: Add KeyDerivationSalt (base64 encoded)
  // ) async {
  //   final response = await client.post(
  //     // "http://10.0.2.2:5000/api/register",
  //     'https://savepass.frifu.de/api/register',
  //     // headers: "",
  //     body: jsonEncode(
  //       {
  //         "google_sign_in" : googleSignIn,
  //         "emailadress": emailadress,
  //         "username": username,
  //         "firstname": firstname,
  //         "lastname": lastname
  //       },
  //     ),
  //   );
  //   print('[DEBUG] Status of POST request (/api/register):' +
  //       response.statusCode.toString());
  //   stdout.write(response.statusCode);
  //   final Map result = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     // If the call to the server was successful, parse the JSON
  //     await _saveUserIdent(result["data"]["user_ident"]);
  //     await _saveUserName(result["data"]['username']);
  //     return UserClass.fromJson(result["data"]);
  //   } else if (response.statusCode == 400) {
  //     // If email or username already exist, throw an error
  //     String error = result["message"];
  //     throw Exception('$error');
  //   } else {
  //     // If that call was not successful, throw an error.
  //     throw Exception('Failed to register');
  //   }
  // }

  Future getUserData(
    String username,
  ) async {
    final response = await client.get(
      // "http://10.0.2.2:5000/api/login",
      'https://savepass.frifu.de/api/user_data',
      // headers: {
      //   "Authorization" : userIdent
      // },
      headers: {"username": username, 'all': 'false'},
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

  // Future<bool> login(
  //   String userIdent,
  //   String password,
  // ) async {
  //   print('[DEBUG] userIdent: ' + userIdent.toString());
  //   final response = await client.get(
  //     // "http://10.0.2.2:5000/api/check_pass",
  //     'https://savepass.frifu.de/api/login',
  //     headers: {"user_ident": userIdent, "password": password},
  //   );
  //   print('[DEBUG] Status of GET request (/api/login):' +
  //       response.statusCode.toString());
  //   final Map result = json.decode(response.body);
  //   if (response.statusCode == 401) {
  //     return false;
  //   } else if (response.statusCode == 404) {
  //     if (result['reason'] == 'no password entries yet') {
  //       return null;
  //     }
  //   } else {
  //     _savePassword(password);
  //     _saveUserIdent(userIdent);
  //     return true;
  //   }
  // }

  Future<String> getAuthToken(String userIdent, String password) async {
    bool loginProcessResult = await BackendAuth().login(userIdent, password);
    loginProcessResult ??= true;
    if (loginProcessResult) {
      String authToken =
          await CacheHandler().getSecureStringFromCache('auth_token');
      return authToken;
    } else {
      return null;
    }
  }

  Future<List<PasswordEntryClass>> getUserPasswordEntries(
    String userIdent,
    String password, {
    int authTimeoutCount = 0,
  }) async {
    if (authTimeoutCount >= 3) {
      throw Exception(
          'An error occured. Please contact the developer under support.savepass@frifu.de');
    }

    String authToken = await getAuthToken(userIdent, password);

    print(authToken);

    // try {
    print('[DEBUG] userIdent ' + userIdent);
    final response = await retry(
      () => client.get(
        // "http://10.0.2.2:5000/api/password_entry",
        'https://savepass.frifu.de/api/db/password_entry',
        headers: {
          "user_ident": userIdent,
          "Authorization": "Bearer " + authToken
        },
      ),
      // .then((resp) {
      //   print('[DEBUG] Status of GET request (/api/password_entry): ' + resp.statusCode.toString());
      // }),
      retryIf: (e) => e is ClientException,
    );
    print('[DEBUG] Status of GET request (/api/db/password_entry): ' + response.statusCode.toString());
    print(response.body);
    final Map<String, dynamic> result = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<PasswordEntryClass> passwordEntries = [];

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
    } else if (response.statusCode == 401) {
      String message = result['message'];
      print(message);
      return getUserPasswordEntries(userIdent, password,
          authTimeoutCount: authTimeoutCount + 1);
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

  Future<bool> addUserPasswordEntry(
    String userIdent,
    String masterPassword,
    List<int> alias,
    List<int> url,
    List<int> username,
    List<int> password,
    List<int> notes,
    List<int> encryption_salt, {
    int authTimeoutCount = 0,
  }) async {
    if (authTimeoutCount >= 3) {
      throw Exception(
          'An error occured. Please contact the developer under support.savepass@frifu.de');
    }

    String authToken = await getAuthToken(userIdent, masterPassword);

    print(authToken);

    final response = await client.post(
      // "http://10.0.2.2:5000/api/password_entry",
      'https://savepass.frifu.de/api/db/password_entry',
      headers: {
        "user_ident": userIdent,
        'Authorization': 'Bearer ' + authToken,
      },
      body: jsonEncode(
        {
          'alias': base64.encode(alias),
          'url': base64.encode(url),
          'username': base64.encode(username),
          'password': base64.encode(password),
          'notes': base64.encode(notes),
          'encryption_salt': base64.encode(encryption_salt),
        },
      ),
    );
    print('[DEBUG] Status of POST request (/api/db/password_entry): ' +
        response.statusCode.toString());

    print(response.body);


    if (response.statusCode == 401) {
      return addUserPasswordEntry(
          userIdent, masterPassword, alias, url, username, password, notes,encryption_salt,
          authTimeoutCount: authTimeoutCount + 1);
    } else if (response.statusCode == 201) {
      print("[DEBUG] Entry added");
      return true;
    } else if (response.statusCode == 422) {
      throw Exception('Failed to add entry.');
    } else if (response.statusCode == 404) {
      // If that call was not successful, throw an error.
      var result = json.decode(response.body);
      throw Exception(result['message']);
      // print(result.toString());
    }
  }

  Future deleteUserPasswordEntry(
    int where,
    bool all,
    String userIdent,
    String masterPassword, {
    int authTimeoutCount = 0,
  }) async {
    if (authTimeoutCount >= 3) {
      throw Exception(
          'An error occured. Please contact the developer under support.savepass@frifu.de');
    }

    String authToken = await getAuthToken(userIdent, masterPassword);

    try {
      final response = await client.send(Request("DELETE",
          Uri.parse("https://savepass.frifu.de/api/db/password_entry"))
        ..headers['user_ident'] = userIdent
        ..headers['Authorization'] = 'Bearer ' + authToken
        ..body = jsonEncode({
          "where": where,
          "what": all ? 'all' : "only",
          "alias": "None",
        }));
      print('[DEBUG] Status of POST request (/api/register): ' +
          response.statusCode.toString());
      if (response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 401) {
        return deleteUserPasswordEntry(where, all, userIdent, masterPassword, authTimeoutCount: authTimeoutCount + 1);
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

  @deprecated
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
