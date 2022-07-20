import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_pass/models/authentication/auth.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';
import 'package:save_pass/models/classes/userClass.dart';
import 'package:save_pass/models/resources/api.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'package:save_pass/models/resources/cryptograph.dart';
import 'package:save_pass/widgets/uni/addpassworddialog.dart';

class RegisterLoginInputWidget extends StatefulWidget {
  @override
  _RegisterLoginInputWidgetState createState() =>
      _RegisterLoginInputWidgetState();
}

class _RegisterLoginInputWidgetState extends State<RegisterLoginInputWidget> {
  User? user;
  bool _showSecondRegisterInputWidget = false;
  bool _showRegisterWithGoogleInfoWidget = false;

  @override
  void initState() {
    // TODO: eventually remove before release, add manual logout
    super.initState();
    // TODO: Add signout functionality
    // signOutGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 100, minWidth: 270),
      decoration: BoxDecoration(
        color: AppDefaultColors.colorPrimaryGrey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedCrossFade(
        duration: Duration(milliseconds: 200),
        // TODO: Add the coose password widget
        crossFadeState: CrossFadeState.showFirst,
        secondChild: ChoosePasswordWidget(),
        firstChild: Column(
          children: [
            AnimatedCrossFade(
              duration: Duration(milliseconds: 200),
              firstChild: Container(
                padding: EdgeInsets.all(0),
                // key: ValueKey(keyValue),
                constraints: BoxConstraints(minHeight: 110, minWidth: 260),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: RaisedButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.all(0),
                        color: AppDefaultColors.colorPrimaryGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              // constraints: BoxConstraints(minWidth: 40),
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 3),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.email,
                                  size: 20,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 7, right: 52),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Register with email',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _showSecondRegisterInputWidget = true;
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: RaisedButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.all(0),
                        color: AppDefaultColors.colorPrimaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 3),
                              child: CircleAvatar(
                                // FIXME: This google icon just isn't beautiful enough
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset('assets/google_logo.png'),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 7, right: 15),
                              child: Text(
                                'Register with Google',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 7),
                              child: IconButton(
                                constraints:
                                    BoxConstraints(maxHeight: 20, maxWidth: 20),
                                padding: EdgeInsets.all(0),
                                iconSize: 20,
                                // constraints: BoxConstraints(maxHeight: 30),
                                icon: Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                  // size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showRegisterWithGoogleInfoWidget =
                                        !_showRegisterWithGoogleInfoWidget;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          // TODO: Add username textinput, finish code
                          User user =
                              await (signInWithGoogle() as FutureOr<User>);
                          this.user = user;
                          print(user.toString());
                          try {
                            String keyDerivationSalt =
                                base64Encode(Cryptograph().salt);
                            await showAddPasswordDialog(context, true);
                            CacheHandler cache = CacheHandler();
                            UserClass? addedUser = await BackendAuth().register(
                              true,
                              user.uid,
                              user.displayName,
                              '',
                              user.email,
                              await cache
                                  .getSecureStringFromCache('master_password'),
                            );
                            await CacheHandler().addStringToCache(
                                'key_derivation_salt', keyDerivationSalt);
                            await BackendAuth().login(
                              await cache
                                  .getSecureStringFromCache('user_ident'),
                              await cache
                                  .getSecureStringFromCache('master_password'),
                            );
                            Navigator.of(context)
                                .pushReplacementNamed('/passwordscreen');
                            CacheHandler().addBoolToCache('registered', true);
                          } catch (e) {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e
                                    .toString()
                                    .replaceAll('Exception', 'Error')),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor:
                                    AppDefaultColors.colorPrimaryGrey[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    AnimatedCrossFade(
                      duration: Duration(milliseconds: 500),
                      // opacity: _googleRegisterButtonInfoVisible ? 1.0 : 0.0,
                      // child:
                      crossFadeState: !_showRegisterWithGoogleInfoWidget
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      secondChild: RegisterWithGoogleInfoWidget(),
                      firstChild: Container(),
                    )
                  ],
                ),
              ),
              secondChild: RegisterInputWidget(),
              crossFadeState: !_showSecondRegisterInputWidget
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 5),
                    child: Text('Already registered?'),
                  ),
                  RaisedButton(
                    child: Text('Login'),
                    color: AppDefaultColors.colorPrimaryBlue,
                    padding: EdgeInsets.all(0),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/loginscreen');
                      CacheHandler().addBoolToCache('registered', true);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChoosePasswordWidget extends StatelessWidget {
  const ChoosePasswordWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}

class RegisterWithGoogleInfoWidget extends StatelessWidget {
  const RegisterWithGoogleInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 230),
      child: Text(
        'Note: We will only use your google account to get your user data (e.G. your email adress). You will save the time to type it in manually.',
        style: TextStyle(
          color: AppDefaultColors.colorPrimaryGrey[500],
          fontSize: 13,
        ),
      ),
    );
  }
}

class RegisterInputWidget extends StatefulWidget {
  @override
  _RegisterInputWidgetState createState() => _RegisterInputWidgetState();
}

class _RegisterInputWidgetState extends State<RegisterInputWidget> {
  bool? _toggleSaveUserInApp = false;
  bool _signInWithEmailFieldsValidator = false;
  bool _usernameAlreadyAdded = false;
  bool _emailAlreadyAdded = false;
  bool _showPasswordInputWidget = false;
  bool _passwordFieldsEqual = false;

  final _usernameInputKey = GlobalKey<FormState>();
  final _emailInputKey = GlobalKey<FormState>();
  final _firstNameInputKey = GlobalKey<FormState>();
  final _lastNameInputKey = GlobalKey<FormState>();

  final _usernameInputController = TextEditingController();
  final _emailInputController = TextEditingController();
  final _firstNameInputController = TextEditingController();
  final _lastNameInputController = TextEditingController();

  final _passwordFieldController = TextEditingController();
  final _passwordRepeatFieldController = TextEditingController();
  final _passwordFieldKey = GlobalKey<FormState>();
  final _passwordRepeatFieldKey = GlobalKey<FormState>();

  Future<bool> _startRegister() async {
    CacheHandler cache = CacheHandler();
    BackendAuth auth = BackendAuth();

    // setState(() {
    //   _usernameAlreadyAdded = false;
    // });
    // setState(() {
    //   _emailAlreadyAdded = false;
    // });

    String keyDerivationSalt = base64Encode(Cryptograph().salt);
    await cache.addStringToCache('key_derivation_salt', keyDerivationSalt);

    try {
      await auth.register(
        false,
        _usernameInputController.text,
        _firstNameInputController.text,
        _lastNameInputController.text,
        _emailInputController.text,
        _passwordFieldController.text,
      );
    } catch (e) {
      print('AAAAAAAAAA');
      print(e);
      if (e.toString() ==
          'Exception: Username not available or already in use') {
        setState(() {
          _usernameAlreadyAdded = true;
        });
        // _usernameInputKey.currentState!.validate();
        // _emailInputKey.currentState!.validate();
        // _firstNameInputKey.currentState!.validate();
        // _lastNameInputKey.currentState!.validate();
        return false;
      }
      if (e.toString() ==
          'Exception: Email already registered. Please log in.') {
        setState(() {
          _emailAlreadyAdded = true;
        });
        // _usernameInputKey.currentState!.validate();
        // _emailInputKey.currentState!.validate();
        // _firstNameInputKey.currentState!.validate();
        // _lastNameInputKey.currentState!.validate();
        return false;
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception', 'Error')),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppDefaultColors.colorPrimaryGrey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      );
      return false;
    }
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Registration progress successfully'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppDefaultColors.colorPrimaryGrey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
    return true;
  }

  Future<bool> _validateSignInEmailFields() async {
    ApiProvider api = ApiProvider();

    if (!(_usernameInputKey.currentState!.validate() &&
        _emailInputKey.currentState!.validate() &&
        _firstNameInputKey.currentState!.validate() &&
        _lastNameInputKey.currentState!.validate())) {
      return false;
    }

    return true;
  }

  Future<bool> _validatePasswordFields() async {
    CacheHandler cache = CacheHandler();

    if (_passwordFieldController.text != _passwordRepeatFieldController.text) {
      setState(() {
        _passwordFieldsEqual = false;
      });
      _passwordFieldKey.currentState!.validate();
      return false;
    } else {
      setState(() {
        _passwordFieldsEqual = true;
      });
      // String? userIdent = await cache.getSecureStringFromCache('user_ident');
      // FIXME: possible error found in registration progress. if not, ignore/delete this comment
      // String masterPassword =
      //     await cache.getSecureStringFromCache('master_password');

      // String? exception = null;

      // await api
      //     .login(userIdent, masterPassword)
      //     .catchError(
      //         (e) => e = exception == null ? null : exception.toString());

      await cache.addSecureStringToCache(
          'master_password',
          _passwordFieldController
              .text); // TODO: Implement avoidance of saving password locally in future
      return true;
    }
  }

  Widget _passwordInput() {
    return Column(
      children: [
        Container(
          height: 60,
          margin: EdgeInsets.only(top: 5),
          // padding: EdgeInsets.symmetric(),
          constraints: BoxConstraints(maxWidth: 340),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
          ),
          child: Form(
            key: _passwordFieldKey,
            child: TextFormField(
              expands: false,
              controller: _passwordFieldController,
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.password),
                // fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: false,
                labelText: 'password',
              ),
              validator: (value) {
                // FIXME: not working, throws LateError, if called from validatePasswordFields()
                if (!_passwordFieldsEqual) {
                  return 'passwords don\'t match';
                }
                return null;
              },
            ),
          ),
        ),
        Container(
          height: 60,
          margin: EdgeInsets.only(top: 5),
          // padding: EdgeInsets.symmetric(),
          constraints: BoxConstraints(maxWidth: 340),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
          ),
          child: Form(
            key: _passwordRepeatFieldKey,
            child: TextFormField(
              expands: false,
              controller: _passwordRepeatFieldController,
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.password),
                // fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: false,
                labelText: 'repeat password',
              ),
              validator: (value) {
                if (!_passwordFieldsEqual) {
                  return 'passwords don\'t match';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernameInputController.dispose();
    _emailInputController.dispose();
    _firstNameInputController.dispose();
    _lastNameInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedCrossFade(
            duration: Duration(milliseconds: 500),
            crossFadeState: _showPasswordInputWidget
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            secondChild: _passwordInput(),
            firstChild: Column(
              children: [
                Container(
                  height: 60,
                  margin: EdgeInsets.only(top: 5),
                  // padding: EdgeInsets.symmetric(),
                  constraints: BoxConstraints(maxWidth: 340),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _usernameInputKey,
                    child: TextFormField(
                      expands: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'type in a username';
                        }
                        if (_usernameAlreadyAdded) {
                          return 'username already in use';
                        }
                        return null;
                      },
                      controller: _usernameInputController,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.security),
                        suffixIcon: Icon(Icons.person),
                        // fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        // filled: true,
                        // hintText: '',
                        labelText: 'username',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.only(top: 5),
                  // padding: EdgeInsets.symmetric(),
                  constraints: BoxConstraints(maxWidth: 340),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _emailInputKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'type in an email';
                        }
                        print('BBBBBBBBBBBB');
                        print(_emailAlreadyAdded);
                        if (_emailAlreadyAdded) {
                          return 'email already added';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailInputController,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.security),
                        suffixIcon: Icon(Icons.email),
                        // fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        // filled: true,
                        // hintText: '',
                        labelText: 'email',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.only(top: 5),
                  // padding: EdgeInsets.symmetric(),
                  constraints: BoxConstraints(maxWidth: 340),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _firstNameInputKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'type in your first name';
                        }
                        return null;
                      },
                      controller: _firstNameInputController,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.security),
                        suffixIcon: Icon(Icons.contacts),
                        // fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        // filled: true,
                        // hintText: '',
                        labelText: 'first name',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  margin: EdgeInsets.only(top: 5),
                  // padding: EdgeInsets.symmetric(),
                  constraints: BoxConstraints(maxWidth: 340),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _lastNameInputKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'type in your last name';
                        }
                        return null;
                      },
                      controller: _lastNameInputController,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.security),
                        suffixIcon: Icon(Icons.contacts),
                        // fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        // filled: true,
                        // hintText: '',
                        labelText: 'last name',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 245),
                child: CheckboxListTile(
                  dense: true,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    'save user data in app',
                    style: TextStyle(fontSize: 14),
                  ),
                  onChanged: (bool? val) {
                    setState(() {
                      _toggleSaveUserInApp = val;
                    });
                    print(_toggleSaveUserInApp);
                  },
                  value: _toggleSaveUserInApp,
                ),
              ),
              RaisedButton(
                child: Text('Submit'),
                color: AppDefaultColors.colorPrimaryBlue,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)),
                onPressed: () async {
                  // setState(() {
                  //   _showPasswordInputWidget = true;
                  // });
                  if (!_showPasswordInputWidget) {
                    bool goFurther = await _validateSignInEmailFields();
                    if (goFurther) {
                      setState(() {
                        _showPasswordInputWidget = true;
                      });
                    }
                  } else {
                    if (await _validatePasswordFields()) {
                      bool goFurther = await _startRegister();

                      if (!goFurther) {
                        setState(() {
                          _showPasswordInputWidget = false;
                        });
                        if (_usernameAlreadyAdded)
                          _usernameInputKey.currentState!.validate();
                        setState(() {
                          _usernameAlreadyAdded = false;
                        });
                      }
                      if (_emailAlreadyAdded) {
                        _emailInputKey.currentState!.validate();
                        setState(() {
                          _emailAlreadyAdded = false;
                        });
                      }

                      if (goFurther) {
                        CacheHandler cache = CacheHandler();
                        BackendAuth auth = BackendAuth();

                        await auth.login(
                          await cache.getSecureStringFromCache('user_ident'),
                          await cache
                              .getSecureStringFromCache('master_password'),
                        );

                        Navigator.of(context)
                            .pushReplacementNamed('/passwordscreen');
                        cache.addBoolToCache('registered', true);
                        String? authToken = await CacheHandler()
                            .getSecureStringFromCache('auth_token');
                        ApiProvider().getUserData(
                            await (cache
                                .getSecureStringFromCache(
                                    'user_name') as FutureOr<
                                String>), // FIXME: IMPORTANT BUG!!!!!!!!!!!!! The old cached auth token is getting used, zumindest glaube ich das.
                            authToken);
                        // TODO: add save user data in app functionality (button already added)
                        // _toggleSaveUserInApp ? null : cache.removeFromCache('user_name') && cache.removeFromCache('user_ident') && cache.removeFromCache('master_password');
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
      // height: 300,
      // width: 350,
      constraints: BoxConstraints(maxWidth: 350, maxHeight: 320),
    );
  }
}
