import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';
import 'package:save_pass/models/resources/api.dart';
import 'package:save_pass/models/resources/cache.dart';

class PasswordActionButtonWithDialogWidget extends StatefulWidget {
  @override
  _PasswordActionButtonWithDialogWidgetState createState() =>
      _PasswordActionButtonWithDialogWidgetState();
}

class _PasswordActionButtonWithDialogWidgetState
    extends State<PasswordActionButtonWithDialogWidget> {
  bool _aliasValidator = true;
  bool _urlValidator = true;
  bool _usernameValidator = true;
  bool _passwordMatchValidatorFalse = false;
  bool _showAliasInputInfoText = false;
  bool _showUrlInputInfoText = false;

  final _aliasFieldController = TextEditingController();
  final _urlFieldController = TextEditingController();
  final _usernameFieldController = TextEditingController();
  final _notesFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _passwordRepeatFieldController = TextEditingController();

  final _aliasFieldKey = GlobalKey<FormState>();
  final _urlFieldKey = GlobalKey<FormState>();
  final _usernameFieldKey = GlobalKey<FormState>();
  final _notesFieldKey = GlobalKey<FormState>();
  final _passwordFieldKey = GlobalKey<FormState>();
  final _passwordRepeatFieldKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _aliasFieldController.dispose();
    _urlFieldController.dispose();
    _usernameFieldController.dispose();
    _notesFieldController.dispose();
    _passwordFieldController.dispose();
    _passwordRepeatFieldController.dispose();

    super.dispose();
  }

  validatePasswordFields() async {
    ApiProvider api = ApiProvider();
    CacheHandler cache = CacheHandler();

    if (_passwordFieldController.text != _passwordRepeatFieldController.text) {
      _passwordFieldKey.currentState.validate();
      // _passwordFieldKey.currentState.validate();
    } else {
      String userIdent = await cache.getStringFromCache('user_ident');
      String masterPassword =
          await cache.getSecureStringFromCache('master_password');

      String exception = null;

      await api
          .addUserPasswordEntry(
            userIdent,
            masterPassword,
            _aliasFieldController.text,
            _urlFieldController.text,
            _usernameFieldController.text,
            _passwordFieldController.text,
            _notesFieldController.text,
          )
          .catchError(
              (e) => e = exception == null ? null : exception.toString());
      return exception;
    }
  }

  void validateAddPasswordEntryFields(bool addGeneratedPassword) async {
    CacheHandler cache = CacheHandler();

    String alias = _aliasFieldController.text;
    // String url = _urlFieldController.text;
    // String username = _usernameFieldController.text;
    // String notes = _notesFieldController.text;

    List<String> ids = await cache.getStringListFromCache('stored_ids');

    // check if alias already exists
    for (String id in ids) {
      String storedalias = await cache
          .getStringFromCache('stored_alias_with_id_' + id.toString());

      if (storedalias == alias) {
        setState(() {
          _aliasValidator = false;
        });
      }
    }

    bool aliasvalidate = _aliasFieldKey.currentState.validate();
    bool urlvalidate = _urlFieldKey.currentState.validate();
    bool usernamevalidate = _usernameFieldKey.currentState.validate();
    bool notesvalidate = _notesFieldKey.currentState.validate();

    if (!addGeneratedPassword) {
      if (aliasvalidate && urlvalidate && usernamevalidate && notesvalidate) {
        Navigator.of(context).pop();
        await showDialog(
          barrierDismissible: false,
          // barrierColor:,
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text('Add own password'),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          // padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            // color: AppDefaultColors.colorPrimaryGrey[200]
                          ),
                          child: Form(
                            key: _passwordFieldKey,
                            child: TextFormField(
                              controller: _passwordFieldController,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: 'password',
                              ),
                              validator: (value) {
                                if (!_passwordMatchValidatorFalse) {
                                  return 'passwords don\'t match';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          // padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            // color: AppDefaultColors.colorPrimaryGrey[200]
                          ),
                          child: Form(
                            key: _passwordRepeatFieldKey,
                            child: TextFormField(
                              controller: _passwordRepeatFieldController,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: 'repeat password',
                              ),
                              validator: (value) {
                                if (!_passwordMatchValidatorFalse) {
                                  return 'passwords don\'t match';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Text(
                          'Tipp: you can also add randomly generated passwords with words that you can easily remember. Try it out!',
                          style: TextStyle(
                            color: AppDefaultColors.colorPrimaryGrey,
                            fontSize: 12,
                          ),
                        )
                        // Container(
                        //   margin: EdgeInsets.only(top: 20),
                        //   child: Text(
                        //     'Tipp: you can also add randomly generated passwords with words that you can easily remember. Try it out!',
                        //     style: TextStyle(
                        //       color: AppDefaultColors.colorPrimaryGrey,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: 10),
                    //   // padding: EdgeInsets.symmetric(horizontal: 10),
                    //   height: 50,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(4),
                    //     // color: AppDefaultColors.colorPrimaryGrey[200]
                    //   ),
                    //   child: RichText(
                    //     text: TextSpan(
                    //       style: GoogleFonts.sourceCodePro(),
                    //       children: <TextSpan>[
                    //         TextSpan(text: '')
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                actions: [
                  ButtonBar(
                    children: [
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: AppDefaultColors.colorPrimaryBlue,
                        // textColor: Colors.white,
                        // color: AppDefaultColors.colorPrimaryGrey[500],
                        onPressed: () async {
                          var error = await validatePasswordFields();
                          Navigator.of(context).pop();
                          final sucessSnackBar = SnackBar(
                            content: Text('The entry was stored sucessfully!'),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppDefaultColors.colorPrimaryGrey[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          );
                          // sucess = sucess.toString();
                          final unsucessSnackBar = SnackBar(
                            content: Text(
                              'An Error occured $error',
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppDefaultColors.colorPrimaryGrey[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          );
                          if (error == null) {
                            error = false;
                          }
                          Scaffold.of(context).showSnackBar(
                              error ? unsucessSnackBar : sucessSnackBar);
                        },
                        child: Text('Submit and create Entry'),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      }
    }

    if (addGeneratedPassword) { 
      // TODO: Add function for adding generated passwords (Backend change also required)
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      isExtended: true,
      onPressed: () {
        // Only for debug:
        // Navigator.of(context).pushNamed('/registerscreen');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            scrollable: true,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Form(
                    key: _aliasFieldKey,
                    child: TextFormField(
                      controller: _aliasFieldController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        suffixIcon: IconButton(
                          splashColor: Colors.transparent,
                          icon: Icon(Icons.info, color: AppDefaultColors.colorPrimaryBlue),
                          onPressed: () {
                            print(_showAliasInputInfoText);
                            setState(() {
                              _showAliasInputInfoText =
                                  !_showAliasInputInfoText;
                              print(_showAliasInputInfoText);
                            });
                          },
                        ),
                        // helperText: 'Keyword for the entry.',
                        labelText: 'alias',
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter an alias';
                        }
                        if (!_aliasValidator) {
                          setState(() {
                            _aliasValidator = true;
                          });
                          return 'already in use';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                // FIXME: Fix animated info about Alias and url
                AnimatedCrossFade(
                  crossFadeState: !_showAliasInputInfoText
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: Container(),
                  secondChild: Container(
                    margin: EdgeInsets.only(left: 12, bottom: 15),
                    child: Text(
                      'keyword/title for the entry. Most commonly the name of the company/provider.',
                      style: TextStyle(
                        color: AppDefaultColors.colorPrimaryBlue,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  duration: Duration(milliseconds: 200),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Form(
                    // TODO: Add info widget on how to add appropriate url
                    key: _urlFieldKey,
                    child: TextFormField(
                      controller: _urlFieldController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          splashColor: Colors.transparent,
                          icon: Icon(Icons.info, color: AppDefaultColors.colorPrimaryBlue),
                          onPressed: () {
                            setState(() {
                              _showUrlInputInfoText = !_showUrlInputInfoText;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        labelText: 'domain',
                        filled: true,
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Form(
                    key: _usernameFieldKey,
                    child: TextFormField(
                      controller: _usernameFieldController,
                      decoration: InputDecoration(
                        labelText: 'username',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Form(
                    key: _notesFieldKey,
                    child: TextFormField(
                      controller: _notesFieldController,
                      decoration: InputDecoration(
                        labelText: 'notes',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              ButtonBar(
                children: [
                  FlatButton(
                    // textColor: AppDefaultColors.colorPrimaryBlue,
                    child: Text(
                      'Add own password',
                      style: TextStyle(
                        color: AppDefaultColors.colorPrimaryGrey,
                      ),
                    ),
                    onPressed: () {
                      // Navigator.of(context).pop();
                      validateAddPasswordEntryFields(false);
                    },
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: AppDefaultColors.colorPrimaryBlue,
                    // textColor: Colors.white,
                    // color: AppDefaultColors.colorPrimaryGrey[500],
                    onPressed: () {
                      validateAddPasswordEntryFields(true);
                    },
                    child: Text('Add generated password'),
                  ),
                ],
              ),
            ],
            title: Text('Create password entry'),
          ),
        );
      },
      elevation: 8,
      icon: Icon(Icons.add),
      label: Text('Add password'),
      backgroundColor: AppDefaultColors.colorPrimaryBlue,
    );
  }
}