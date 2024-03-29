// import 'dart:js';

import 'dart:convert';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:save_pass/models/authentication/auth.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';
import 'package:save_pass/models/classes/userClass.dart';
import 'package:save_pass/models/resources/cryptograph.dart';
import 'package:save_pass/models/classes/passwordentryClass.dart';
import 'package:save_pass/models/resources/database.dart';
import 'package:save_pass/models/resources/sync.dart';
import 'package:save_pass/widgets/uni/toplabel.dart';
import 'package:save_pass/models/resources/api.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'dart:ui' as ui;

Future<String?> getUserIdent() async {
  CacheHandler cache = CacheHandler();
  String? value = await cache.getSecureStringFromCache('user_ident');
  return value;
}

// Future<bool> checkMasterPassword(String password) async {
//   ApiProvider api = ApiProvider();
//   api.loginUser('paulaner');
//   String userIdent = await getUserIdent();
//   bool passcheck = await api.checkPass(userIdent, password);
//   return passcheck;
// }

// FIXME: Fix following function, in case of previous logout
Future<bool?> checkMasterPassword(
    String password, context, String? username) async {
  CacheHandler cache = CacheHandler();

  if (username == null) {
    try {
      cache.getSecureStringFromCache('user_name');
    } catch (e) {
      print('[EXCEPTION_FIX] ' + e.toString());
    }
  }

  // Check if user_data was already requested successfully at register

  bool? registered = await cache.getBoolFromCache('registered');

  bool userIdentAlreadyStored = true;
  try {
    CacheHandler().getSecureStringFromCache('user_ident');
  } catch (e) {
    print('[EXCEPTION_FIX] ' + e.toString());
    userIdentAlreadyStored = false;
  }

  if (!userIdentAlreadyStored) {
    try {
      // FIXME: The followong schould only be called after register
      await ApiProvider().getUserData(username!,
          await CacheHandler().getSecureStringFromCache('auth_token'));
    } catch (e) {
      // If user is not added yet, or an other reason to throw an login error exists, show Snackbar
      // FIXME: Here, the state also doesnt change for Snackbar
      // print('ALALALALALALALALALA');
      // print(e.toString().replaceAll('Exception', 'Error'));
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception', 'Error')),
        ),
      );
      return null;
    }
  }

  String? userIdent = await getUserIdent();
  // TODO: Add route when checkPass receives 404 (list empty)
  // bool checkedIn = await api.login(userIdent, password);
  bool checkedIn = await PasswordEntryDatabaseActions(password).login();
  return checkedIn;
}

class LoginScreen extends StatefulWidget {
  // var _questionIndex = 0;

  // void _answerQuestion() {
  //   setState(() {
  //     _questionIndex += 1;
  //   });
  //   print(_questionIndex);
  //   print('Answer chosen!');
  // }

  // void _passwordInputFalse() {
  //   setState(() {

  //   });
  // }

  // void _showTestSnackbar() {
  //   MaterialBanner(
  //     content: Text('Hallo'),
  //     actions: [],
  //   );
  // }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordTextFieldController = TextEditingController();
  final usernameTextFieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    passwordTextFieldController.dispose();
    usernameTextFieldController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    bool _showUsernameField = false;
    bool _showPassword = false;
    bool _userNameFieldReadOnly = false;
    bool fieldsValidator = false;
    bool usernameValidator = false;
    int wrongPassCount = 0;
    final userInputKey = GlobalKey<FormState>();
    final passInputKey = GlobalKey<FormState>();
    final passButtonKey = GlobalKey<FormState>();

    void passInputValidator([String? username]) async {
      var passwordChecked = await checkMasterPassword(
          passwordTextFieldController.text, context, username);

      if (passwordChecked == null) {
        // No snackbar needed, because it is displayed already in checkMasterPassword()
        // if (passInputKey.currentState.validate()) {
        //   CacheHandler().addSecureStringToCache(
        //       'master_password', passwordTextFieldController.text);
        //   Navigator.of(context).pushNamed("/newpasswordscreen");
        // }
      } else {
        print('[PASSWORD_CHECK] ' + passwordChecked.toString());
        setState(() {
          fieldsValidator = passwordChecked;
        });

        if (passInputKey.currentState!.validate()) {
          CacheHandler().addSecureStringToCache(
              'master_password', passwordTextFieldController.text);
          Navigator.of(context).pushNamed("/newpasswordscreen");
        }
      }

      // if (passInputKey) {};
      // if (checkMasterPassword(value)) {
      //   return null;
      // }
      // ;
      // Navigator.of(context).pushNamed("/newpasswordscreen");
    }

    Future<bool> _checkNessecaryUsername() async {
      String? value =
          await CacheHandler().getSecureStringFromCache('user_name');
      print('[DEBUG] Username field will be shown? $value');
      return value == null ? true : false;
      // await CacheHandler().addSecureStringToCache('user_name', 'fcO3x5GKdthbLnjkImxBWPk7jaz2');
      // return false;
    }

    return new Scaffold(
      // backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,

      // appBar: AppBar(
      //   title: Text('SavePass.'),
      // ),
      body: SafeArea(
        bottom: true,
        top: true,
        child:
            // SingleChildScrollView(
            // dragStartBehavior: DragStartBehavior.down,
            // clipBehavior: Clip.hardEdge,

            CustomPaint(
          painter: BackgroundPainter(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToplabelLogin(),
                Container(
                  constraints: BoxConstraints(minHeight: 300),
                  margin: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      // BoxShadow(
                      //   color: AppDefaultColors.colorPrimaryGrey[100],
                      //   blurRadius: 10,
                      //   spreadRadius: 3,
                      //   // offset: Offset(3, 4),
                      // ),
                    ],
                    // color: AppDefaultColors.colorPrimaryGrey[100],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      const Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FutureBuilder(
                          initialData: false,
                          future: _checkNessecaryUsername(),
                          builder: (context, snapshot) {
                            // print(snapshot.data);
                            // WidgetsBinding.instance.addPostFrameCallback((_){
                            //   setState(() {
                            //     _showUsernameField = true;
                            //   });
                            // });
                            if (snapshot.data == true) {
                              // WidgetsBinding.instance.addPostFrameCallback((_) {
                              _showUsernameField = true;
                              // });
                              return Container(
                                constraints: BoxConstraints(maxHeight: 59),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                margin: EdgeInsets.only(
                                  top: 20,
                                  bottom: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Form(
                                  key: userInputKey,
                                  child: new TextFormField(
                                    readOnly: _userNameFieldReadOnly,
                                    controller: usernameTextFieldController,
                                    // key: passInputKey,
                                    // FIXME: Fix the state not updating
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a username';
                                      }
                                      if (usernameValidator) {
                                        return null;
                                      }
                                      return 'username doesn\'t exist';
                                    },
                                    enableInteractiveSelection: true,
                                    onEditingComplete: () {
                                      // passInputKey.currentState.validate();
                                      // passButtonKey.currentState.
                                      passInputValidator(
                                          usernameTextFieldController.text);
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      // prefixIcon: Icon(Icons.security),
                                      // suffixIcon: IconButton(
                                      //   icon: Icon(
                                      //     Icons.remove_red_eye,
                                      //     color: _showPassword
                                      //         ? AppDefaultColors
                                      //             .colorPrimaryBlue
                                      //         : AppDefaultColors
                                      //             .colorPrimaryGrey,
                                      //   ),
                                      //   onPressed: () {
                                      //     togglePasswordVisibillity();
                                      //   },
                                      // ),
                                      // fillColor: Colors.white,
                                      suffix: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: InkWell(
                                          enableFeedback: true,
                                          excludeFromSemantics: true,
                                          onTap: () {},
                                          child: Image.asset(
                                            'assets/google_logo.png',
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      // hintText: '',
                                      labelText: 'Username',
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          }),
                      Container(
                        decoration: BoxDecoration(
                          // color: AppDefaultColors.colorPrimaryGrey[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          // vertical: _showUsernameField ? 10 : 80,
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Form(
                          key: passInputKey,
                          child: StatefulBuilder(builder: (context, setState) {
                            return TextFormField(
                              controller: passwordTextFieldController,
                              // key: passInputKey,
                              // FIXME: Fix the state not updating
                              validator: (value) {
                                print(
                                    '[VALIDATE_PASSWORDFIELD] passwordcheck: ' +
                                        fieldsValidator.toString());
                                if (value!.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (wrongPassCount > 3) {
                                  // this.deactivate();
                                  return 'You failed to enter the correct password three times';
                                }

                                // bool checked = checkMasterPassword(value);
                                // String _return = 'Password is incorrect';

                                // if (checked) {
                                //   Navigator.of(context)
                                //       .pushNamed("/newpasswordscreen");
                                // }
                                // // print('mensch');
                                // // print(checked);

                                // // String delay() {
                                // //   // int sec = 0;
                                // //   // while (checked == null) {
                                // //   //   sec += sec;
                                // //   //   print(sec);
                                // //   // }
                                // //   if (checked) {
                                // //     Navigator.of(context).pushNamed("/newpasswordscreen");
                                // //   } else if (checked == false) {
                                // //     return 'Password is incorrect';
                                // //   }
                                // // }

                                // // print('mensch2');
                                // // print(checked);
                                // // String delayedchecked = delay();
                                // // return delayedchecked;
                                // print('niunununun');
                                // print(fieldsValidator);
                                if (fieldsValidator) {
                                  return null;
                                }
                                if (!fieldsValidator) {
                                  // FIXME: fix not changing state here
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text('wrong password, ' +
                                          (3 - wrongPassCount).toString() +
                                          ' trys left'),
                                    ),
                                  );
                                  return 'Password is incorrect';
                                }
                                return null;
                              },
                              enableInteractiveSelection: true,
                              onEditingComplete: () {
                                // passInputKey.currentState.validate();
                                // passButtonKey.currentState.
                                passInputValidator();
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !_showPassword,
                              decoration: InputDecoration(
                                // prefixIcon: Icon(Icons.security),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: _showPassword
                                        ? AppDefaultColors.colorPrimaryBlue
                                        : AppDefaultColors.colorPrimaryGrey,
                                  ),
                                  onPressed: () {
                                    // DatabaseHandler db = DatabaseHandler();
                                    // db.deleteAllPasswordEntries();
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                    print(_showPassword);
                                  },
                                ),
                                // fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                // hintText: '',
                                labelText: 'Password',
                              ),
                            );
                          }),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 270, bottom: 20),
                        child: TextButton(
                          key: passButtonKey,
                          child: Icon(
                            Icons.lock_open,
                            // color: AppDefaultColors.colorPrimaryBlue,
                          ),
                          // color: AppDefaultColors.colorPrimaryBlue,
                          // splashColor: AppDefaultColors.colorPrimaryBlue,
                          style: TextButton.styleFrom(
                            primary: AppDefaultColors.colorPrimaryBlue,
                            backgroundColor:
                                AppDefaultColors.colorPrimaryGrey[50],
                          ),
                          onPressed: () async {
                            // DEBUG (uncomment for testing):
                            // ____________________________________
                            // String keyDerivationSalt = base64Encode(Cryptograph().salt);
                            // await CacheHandler().addStringToCache('key_derivation_salt', keyDerivationSalt);
                            // Cryptograph c = Cryptograph('password');
                            // List<int> key = await c.generateKeyFromPass();
                            // c.encrypt('hallo', key);
                            // await DatabaseHandler().deleteAllPasswordEntries();
                            // await CacheHandler().removeFromCache('user_ident');
                            // await CacheHandler().removeFromCache('user_name');
                            // print(await CacheHandler().getStringFromCache('key_derivation_salt'));
                            //
                            // UserClass user = await BackendAuth().register(false, 'Klausineeeeeeeee', 'Klaus', 'Dieter', 'klausineeeeeeeee@gmail.com', 'moinsen');
                            // print(await BackendAuth().login(user.userIdent, 'moinsen'));
                            // print('Next best thing');
                            //
                            // Random random = Random();
                            // print(await ApiProvider().addUserPasswordEntry(
                            //     '#aQigBRZ4WEfhQzN',
                            //     'password',
                            //     List<int>.generate(
                            //         32, (i) => random.nextInt(256)),
                            //     List<int>.generate(
                            //         32, (i) => random.nextInt(256)),
                            //     List<int>.generate(
                            //         32, (i) => random.nextInt(256)),
                            //     List<int>.generate(
                            //         32, (i) => random.nextInt(256)),
                            //     List<int>.generate(
                            //         32, (i) => random.nextInt(256)),
                            //     List<int>.generate(
                            //         32, (i) => random.nextInt(256))));
                            // print(await ApiProvider().getUserPasswordEntries(await CacheHandler().getSecureStringFromCache('user_ident'), 'moinsen'));
                            // print(await CacheHandler().getSecureStringFromCache('user_ident'));
                            // Sync().normalSync(true); // TODO: debug sync function
                            // print(await ApiProvider().getIconAsBlob('facebook.com'));
                            // print(await CacheHandler()
                            //     .getSecureStringFromCache('user_ident'));
                            // print(await CacheHandler()
                            //     .getSecureStringFromCache('user_name'));
                            // print(await CacheHandler()
                            //     .getSecureStringFromCache('master_password'));
                            // ____________________________________

                            passInputValidator(_showUsernameField
                                ? usernameTextFieldController.text
                                : null);
                          },
                          // elevation: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path circlePathOne = Path();
    // Start paint from 20% height to the left
    circlePathOne.moveTo(0, height * 0.15);
    circlePathOne.quadraticBezierTo(
      width * 0.9,
      height * 0.1,
      width * 0,
      height * 1.15,
    );
    paint
      ..shader = ui.Gradient.linear(
        Offset(width * 0, height * 0.4),
        Offset(width * 0.9, height * 0.1),
        [
          AppDefaultColors.colorPrimaryBlue,
          Colors.white,
        ],
      );
    canvas.drawPath(circlePathOne, paint);

    Path circlePathTwo = Path();
    // Start paint from 20% height to the left
    circlePathTwo.moveTo(width * 1, height * 0.15);
    circlePathTwo.quadraticBezierTo(
      width * 0.1,
      height * 0.8,
      width * 1,
      height * 1.15,
    );
    // paint.color = AppDefaultColors.colorPrimaryBlue;
    paint
      ..shader = ui.Gradient.linear(
        Offset(width * 0, height * 0.9),
        Offset(width * 0.9, height * 0.4),
        [
          Colors.white,
          AppDefaultColors.colorPrimaryBlue,
        ],
      );
    canvas.drawPath(circlePathTwo, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
