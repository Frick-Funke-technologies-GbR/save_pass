import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' show Client, ClientException, Request;
import 'package:save_pass/models/classes/userClass.dart';
import 'package:save_pass/models/resources/cache.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User?> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount =
      await (googleSignIn.signIn() as FutureOr<GoogleSignInAccount>);
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User? user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser!;
    assert(user.uid == currentUser.uid);

    print('[DEBUG] signInWithGoogle succeeded: $user');

    return user;
  }

  return null;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("[DEBUG] User Signed Out");
}

// Class for handling the user register/login process and save the JWT's
class BackendAuth {
  Client client = Client();

  Future<UserClass?> register(
      bool googleSignIn,
      String username,
      String? firstname,
      String lastname,
      String? emailaddress,
      String? password) async {
    String? passwordHash =
        password; // TODO: IMPORTANT FIX BEFORE LAUNCH!!! Add password derivation/hash function here

    final response = await client.post(
      // "http://10.0.2.2:5000/api/auth/register",
      Uri.parse("https://savepass.frifu.de/api/auth/register"),
      body: jsonEncode(
        {
          "google_sign_in": googleSignIn,
          "email": emailaddress,
          "username": username,
          "firstname": firstname,
          "lastname": lastname,
          "password": passwordHash,
        },
      ),
    );

    print('[DEBUG] Status of POST request (/api/auth/register):' +
        response.statusCode.toString());

    final Map? result = json.decode(response.body);

    print(result);

    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON

      String authToken = result!['auth_token'];

      await _saveAuthToken(authToken);

      await CacheHandler().addSecureStringToCache('ident_auth_token',
          authToken); // save the registration auth token for identification when trying to get user data

      await _saveUserIdent(result["data"]["user_ident"]);
      await _saveUserName(result["data"]['username']);

      return UserClass.fromJson(result["data"]);
    } else if (response.statusCode == 202) {
      // If email or username already exist, throw an error
      String? error = result!["message"];
      throw Exception('$error');
    } else if (response.statusCode == 500) {
      // If that call was not successful, throw an error.
      throw Exception(
          'Failed to register. Try again soon. If this error keeps repeating, contact us at support.savepass@frifu.de'); 
    }
  }

  Future<bool?> login(
    String? userIdent,
    String? password,
  ) async {
    String? passwordHash =
        password; // TODO: IMPORTANT FIX BEFORE LAUNCH!!! Add password derivation/hash function here

    final response = await client.post(
      // "http://10.0.2.2:5000/api/check_pass",
      Uri.parse('https://savepass.frifu.de/api/auth/login'),
      body: jsonEncode(
        {
          "user_ident": userIdent,
          "password": passwordHash,
        },
      ),
    );

    print('[DEBUG] Status of GET request (/api/auth/login): ' +
        response.statusCode.toString());
    print(response.body.toString());

    final Map? result = json.decode(response.body);

    if (response.statusCode == 401) {
      return false; // FIXME: Change to throw Exception('wrong password')
    } else if (response.statusCode == 200) {
      String? authToken = result!['auth_token'];
      await _saveAuthToken(authToken);
      
      if (result['data']['password_entries'] == 0) {
        return null;
      }

      return true;
    }
  }

  _saveUserIdent(String? userIdent) {
    CacheHandler cache = CacheHandler();
    cache.addSecureStringToCache('user_ident', userIdent);
  }

  _saveUserName(String userName) {
    CacheHandler cache = CacheHandler();
    cache.addSecureStringToCache('user_name', userName);
  }

  _saveAuthToken(String? authToken) async {
    CacheHandler cache = CacheHandler();
    await cache.addSecureStringToCache('auth_token', authToken);
  }

  // _saveFirstName(String firstName) {
  //   CacheHandler cache = CacheHandler();
  //   cache.addSecureStringToCache('first_name', firstName);
  // }

  // _saveLastName(String lastName) {
  //   CacheHandler cache = CacheHandler();
  //   cache.addSecureStringToCache('last_name', lastName);
  // }

  // _saveEmailAdress(String emailAdress) {
  //   CacheHandler cache = CacheHandler();
  //   cache.addSecureStringToCache('email_address', emailAdress);
  // }

  // _savePassword(String password) {
  //   CacheHandler cache = CacheHandler();
  //   cache.addSecureStringToCache('master_password', password);
  // }
}
