

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:english_words/english_words.dart';
import 'package:path_provider/path_provider.dart';
import 'package:save_pass/models/resources/strings.dart';

class Cryptograph {
  String? password;
  final List<int> salt = generateSalt();
  List<int>? encryptionSalt;
  int encryptionMacLength = 32;
  Cryptograph([this.password]);

  static final Random _random = Random.secure();

  static List<int> generateSalt([int length = 16]) {
    return List<int>.generate(length, (i) => _random.nextInt(256));
  }

  Future<List<int>> generateKeyFromPass({List<int>? keySalt}) async {

    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 50000, // FIXME: Change to 200.000 iterations for better security if performance is better
      bits: 128,
    );

    Stopwatch stopwatch = Stopwatch()..start();

    keySalt = keySalt ?? salt;

    // Password we want to hash
    final secretKey = SecretKey(password!.codeUnits);

    // A random salt
    final nonce = keySalt;

    // Calculate a hash that can be stored in the database
    final newSecretKey = await pbkdf2.deriveKey(
      secretKey: secretKey,
      nonce: nonce,
    );  

    final newSecretKeyBytes = await newSecretKey.extractBytes();
    print('Result: $newSecretKeyBytes');
    print('[CRYPTOGRAPH] key generation executed in ${stopwatch.elapsed}');
    stopwatch.stop();
    return newSecretKeyBytes;

  // TODO: implement Argon2id password deviation in the future
  // final algorithm = Argon2id(
  //   parallelism: 3,
  //   memorySize: 10000000,
  //   iterations: 3,
  //   hashLength: 32,
  // );

  // final newSecretKey = await algorithm.deriveKey(
  //   secretKey: SecretKey([1,2,3]),
  //   nonce: [4,5,6],
  // );
  // final newSecretKeyBytes = await newSecretKey.extractBytes();

  // print('hashed password: $newSecretKeyBytes');

  }

  // Future<List<int>> generateAuthPassKeyFromPass({List<int> keySalt}) async {

  //   final pbkdf2 = Pbkdf2(
  //     macAlgorithm: Hmac.sha256(),
  //     iterations: 50000, // FIXME: Change to 200.000 iterations for better security if performance is better
  //     bits: 128,
  //   );

  //   Stopwatch stopwatch = Stopwatch()..start();

  //   keySalt = keySalt ?? salt;

  //   // Password we want to hash
  //   final secretKey = SecretKey(password.codeUnits);

  //   // A random salt
  //   final nonce = keySalt;

  //   // Calculate a hash that can be stored in the database
  //   final newSecretKey = await pbkdf2.deriveKey(
  //     secretKey: secretKey,
  //     nonce: nonce,
  //   );  

  //   final newSecretKeyBytes = await newSecretKey.extractBytes();
  //   print('Result: $newSecretKeyBytes');
  //   print('[CRYPTOGRAPH] key generation executed in ${stopwatch.elapsed}');
  //   stopwatch.stop();
  //   return newSecretKeyBytes;
  // }


  Future<List<int>> encrypt(String decryptedContent, List<int> key) async {
    /// encrypt the String [decryptedContent]
    /// using the [key] generated with [generateKeyFromPass()]

    // encodedDecryptedContent we want to encrypt
    final encodedDecryptedContent = utf8.encode(decryptedContent);

    // Choose the cipher
    final algorithm = AesCbc.with128bits(macAlgorithm: Hmac.sha256());

    // Stopwatch stopwatch = Stopwatch()..start();
    // SecretKey secretKeyy = SecretKeyData.random(length: 20);
    // algorithm.macAlgorithm.calculateMac([1, 9, 7, 6, 4, 4, 3], secretKey: secretKeyy);
    // print('ASDFGH${stopwatch.elapsed}');
    
    // mac calculation takes about 0.002918 seconds

    // Generate a secret key.
    final secretKey = await algorithm.newSecretKeyFromBytes(key);

    // Encrypt
    final secretBox = await algorithm.encrypt(
      encodedDecryptedContent,
      secretKey: secretKey,
      nonce: salt,
    );

    print('ENCRYPTION KEY: ${await secretKey.extractBytes()}');
    print('ENCRYPTION SALT: ${secretBox.nonce}');
    // print('NonceLength: ${secretBox.mac.bytes.length}');
    print('ENCRYPTION ENCRYPTED CONTENT: ${secretBox.cipherText}');
    print('MAC: ${secretBox.mac.bytes}');
    print('MACLENGTH: ${secretBox.mac.bytes.length}');

    encryptionSalt = secretBox.nonce;
    encryptionMacLength = secretBox.mac.bytes.length;

    return secretBox.cipherText + secretBox.mac.bytes;
  }

  Future<String> decrypt(
    List<int> encryptedContent,
    List<int> key, {
    List<int>? salt, // FIXME add keyword required in future implementation of null savety 
    int? macLength,
  }) async {
    // final secretBox = SecretBox.fromConcatenation(
    //   encryptedContent,
    //   nonceLength: 16,
    //   macLength: macLength,
    // );

    macLength = macLength ?? encryptionMacLength;
    salt = salt ?? encryptionSalt;

    final encryptedContentInListView = Uint8List.fromList(encryptedContent);
    // final saltInListView = Uint8List.fromList(salt);

    final SecretBox secretBox = SecretBox(
      Uint8List.sublistView(
        encryptedContentInListView,
        0,
        encryptedContentInListView.lengthInBytes - macLength,
      ),
      mac: Mac(
        Uint8List.sublistView(
          encryptedContentInListView,
          encryptedContentInListView.lengthInBytes - macLength,
          encryptedContentInListView.lengthInBytes,
        ),
      ),
      // nonce: Uint8List.sublistView(
      //   encryptedContentInListView,
      //   encryptedContentInListView.lengthInBytes - macLength - 16,
      //   encryptedContentInListView.lengthInBytes - macLength,
      // ),
      nonce: salt!,
    );

    print(encryptedContentInListView.lengthInBytes);
    print('DECRYPTION MAC: ' +  secretBox.mac.toString());
    print('DECRYPTION ENCRYPTET CONTENT: ' + secretBox.cipherText.toString());
    print('DECRYPTION SALT: ' + secretBox.nonce.toString());
    // print(';;;;;;;;;;;;;;;;;;;;;;;;');
    print(secretBox.mac.bytes);

    final algorithm = AesCbc.with128bits(macAlgorithm: Hmac.sha256());

    final secretKey = await algorithm.newSecretKeyFromBytes(key);
    final secretKeyBytes = await secretKey.extractBytes();
    print('Secret key: $secretKeyBytes');

    final List<int> clearText = await algorithm.decrypt(
      secretBox,
      secretKey: secretKey,
    );

    final String decodedDecryptedContent = utf8.decode(clearText);

    print('Decrypted Content: $decodedDecryptedContent');

    return decodedDecryptedContent;
  }
}

class Generator {
  
  static final Random _random = Random.secure();

  // static List<int> generateSalt([int length = 32]) {
  //   return List<int>.generate(length, (i) => _random.nextInt(256));
  // }

  bool probabilityFromComplexity(int complexity, [lessRare = false]) {
    /// returns a bool with the propability of the complexity int to be true.
    if (!lessRare) {
      return _random.nextInt(complexity + 1) == complexity ? true : false;
    } else {
      return _random.nextInt(((complexity + 1) / 2).round()) == (complexity / 2).round(); 
    }
  }

  Map<String, dynamic> generatePassword(
    int length,
    int complexity,
    bool? containWords,
    bool? containNumbers,
    bool? containSpecialchar,
    bool? containUppercase,
    bool? containLowercase,
  ) {
  Map<String, dynamic> passwordMap = {};
  int whichCharacter = 0;
  List uppercase = [
    'Q',
    'W',
    'E',
    'R',
    'T',
    'Z',
    'U',
    'I',
    'O',
    'P',
    'A',
    'S',
    'D',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
    'Y',
    'X',
    'C',
    'V',
    'B',
    'N',
    'M',
  ];
  List lowercase = [
    'q',
    'w',
    'e',
    'r',
    't',
    'z',
    'u',
    'i',
    'o',
    'p',
    'a',
    's',
    'd',
    'f',
    'g',
    'h',
    'j',
    'k',
    'l',
    'y',
    'x',
    'c',
    'v',
    'b',
    'n',
    'm',
  ];
  List digits = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
  ];
  List punctuations = [
    '!',
    '"',
    '#',
    '\$',
    '&',
    '\'',
    '(',
    ')',
    '*',
    '+',
    ',',
    '-',
    '.',
    '/',
    ':',
    ';',
    '<',
    '>',
    '=',
    '?',
    '@',
    '[',
    '\\',
    ']',
    '^',
    '_',
    '`',
    '{',
    '|',
    '}',
    '~'
  ];

  for (int iter = 0; iter < length; iter++) {
    String i = iter.toString().padLeft(3);
    if (probabilityFromComplexity(complexity, true) && containWords!) {
      int where = _random.nextInt(nounsWithLessThanTwoSyllables.length);
      String word = nounsWithLessThanTwoSyllables[where];
      passwordMap[i] = {word : 'grey_bright'};
    } else {
      String charval = '';
      if (!probabilityFromComplexity(complexity, true)) {
        whichCharacter = _random.nextInt(2);
      } else {
        whichCharacter = 3;
      }
      bool exsists = false;
      if (!(whichCharacter == 3)) {
        if (whichCharacter == 0 && containSpecialchar!) {
          for (int ii = 0; ii < (complexity / 4).round(); ii++) {
            charval += punctuations[_random.nextInt(punctuations.length)];
          }
          passwordMap[i] = {charval : 'red'};
        } else if (whichCharacter == 1 && containNumbers!) {
          for (int ii = 0; ii < (complexity / 4).round(); ii++) {
            charval += digits[_random.nextInt(digits.length)];
          }
          passwordMap[i] = {charval : 'blue'};
        }
      } else {
        if (containUppercase! && containLowercase!) {
          if (_random.nextBool()) {
            for (int ii = 0; ii < (length / 4).round(); ii++) {
              charval += uppercase[_random.nextInt(uppercase.length)];
            }
            passwordMap[i] = {charval : 'grey'};
          } else {
            for (int ii = 0; ii < (length / 4).round(); ii++) {
              charval += lowercase[_random.nextInt(lowercase.length)];
            }
            passwordMap[i] = {charval : 'grey'};            
          }
        } else if (containUppercase) {
            for (int ii = 0; ii < (length / 4).round(); ii++) {
              charval += uppercase[_random.nextInt(uppercase.length)];
            }
            passwordMap[i] = {charval : 'grey'};          
        } else if (containLowercase!) {
            for (int ii = 0; ii < (complexity / 4).round(); ii++) {
              charval += lowercase[_random.nextInt(lowercase.length)];
            }
            passwordMap[i] = {charval : 'grey'};
        }
      }
    }
  }

  // _write(text) async {
  //   final Directory directory = await getApplicationDocumentsDirectory();
  //   final File file = File('${directory.path}/my_file.txt');
  //   await file.writeAsString(text.toString());
  // }

  // int ind = 0;
  // List<String> newnouns = [];
  // for(String i in nouns) {
  //   if (syllables(i) <= 2) {
  //     newnouns.add(i);
  //   }
  //   ind++;
  // }
  // print(newnouns);
  // _write(newnouns);



  return passwordMap;
  }
}