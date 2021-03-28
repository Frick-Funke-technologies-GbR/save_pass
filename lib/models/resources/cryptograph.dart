import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:cryptography/dart.dart';

class Cryptograph {
  String password;
  // TODO: Store this salt
  final List<int> salt = generateSalt();
  List<int> encryptionSalt;
  int encryptionMacLength = 16;
  Cryptograph(this.password);

  static final Random _random = Random.secure();

  static List<int> generateSalt([int length = 32]) {
    return List<int>.generate(length, (i) => _random.nextInt(256));
  }

  // Future<List<int>> generateKeyFromPass() async {
  //   /// generate a key from the password
  //   /// prevoiusely stored in a global variable
  //   /// Algorythm: Argon2id

  //   final algorithm = DartArgon2id(
  //     parallelism: 3,
  //     memorySize: 10000000,
  //     iterations: 3,
  //     hashLength: 32,
  //   );

  //   @override
  //   final newSecretKey = await algorithm.deriveKey(
  //     secretKey: SecretKey(password.codeUnits),
  //     nonce: salt,
  //   );

  //   final newSecretKeyBytes = await newSecretKey.extractBytes();

  //   return newSecretKeyBytes;
  // }

  Future<List<int>> generateKeyFromPass({List<int> keySalt}) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 100000,
      bits: 128,
    );

    keySalt = keySalt == null ? salt : keySalt;

    // Password we want to hash
    final secretKey = SecretKey(password.codeUnits);

    // A random salt
    final nonce = keySalt;

    // Calculate a hash that can be stored in the database
    final newSecretKey = await pbkdf2.deriveKey(
      secretKey: secretKey,
      nonce: nonce,
    );
    final newSecretKeyBytes = await newSecretKey.extractBytes();
    print('Result: $newSecretKeyBytes');
    return newSecretKeyBytes;
  }

  Future<List<int>> encrypt(String decryptedContent, List<int> key) async {
    /// encrypt the String [decryptedContent]
    /// using the [key] generated with [generateKeyFromPass()]

    // encodedDecryptedContent we want to encrypt
    final encodedDecryptedContent = utf8.encode(decryptedContent);

    // Choose the cipher
    final algorithm = AesCbc.with128bits(macAlgorithm: Hmac.sha256());

    // Generate a secret key.
    final secretKey = await algorithm.newSecretKeyFromBytes(key);
    final secretKeyBytes = secretKey.extractBytes();
    print('Secret key: $secretKeyBytes');

    // Encrypt
    final secretBox = await algorithm.encrypt(
      encodedDecryptedContent,
      secretKey: secretKey,
    );
    print('Nonce: ${secretBox.nonce}');
    // print('NonceLength: ${secretBox.mac.bytes.length}');
    print('Ciphertext: ${secretBox.cipherText}');
    print('MAC: ${secretBox.mac.bytes}');

    encryptionSalt = secretBox.nonce;
    encryptionMacLength = secretBox.mac.bytes.length;

    return secretBox.cipherText + secretBox.mac.bytes;
  }

  Future<String> decrypt(
    List<int> encryptedContent,
    List<int> key, {
    int macLength,
    List<int> salt,
  }) async {
    // final secretBox = SecretBox.fromConcatenation(
    //   encryptedContent,
    //   nonceLength: 16,
    //   macLength: macLength,
    // );

    macLength = macLength ?? encryptionMacLength;
    salt = salt ?? encryptionSalt;


    final encryptedContentInListView = Uint8List.fromList(encryptedContent);
    final saltInListView = Uint8List.fromList(salt);

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
        ),
      ),
      nonce: saltInListView,
    );

    final algorithm = AesCbc.with128bits(macAlgorithm: Hmac.sha256());

    final secretKey = await algorithm.newSecretKeyFromBytes(key);
    final secretKeyBytes = secretKey.extractBytes();
    print('Secret key: $secretKeyBytes');

    final List<int> clearText = await algorithm.decrypt(
      secretBox,
      secretKey: secretKey,
    );

    final String decodedDecryptedContent = utf8.decode(clearText);

    return decodedDecryptedContent;
  }
}
