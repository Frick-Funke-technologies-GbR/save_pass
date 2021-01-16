import 'package:flutter/material.dart';
import 'package:save_pass/models/resources/api.dart';
import 'package:save_pass/models/resources/cache.dart';


class PasswordActionButtonWithDialogWidget extends StatefulWidget {
  @override
  _PasswordActionButtonWithDialogWidgetState createState() =>
      _PasswordActionButtonWithDialogWidgetState();
}

class _PasswordActionButtonWithDialogWidgetState
    extends State<PasswordActionButtonWithDialogWidget> {
  bool aliasValidator = true;
  bool urlValidator = true;
  bool usernameValidator = true;
  bool passwordMatchValidatorFalse = false;

  final aliasFieldController = TextEditingController();
  final urlFieldController = TextEditingController();
  final usernameFieldController = TextEditingController();
  final notesFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final passwordRepeatFieldController = TextEditingController();

  final aliasFieldKey = GlobalKey<FormState>();
  final urlFieldKey = GlobalKey<FormState>();
  final usernameFieldKey = GlobalKey<FormState>();
  final notesFieldKey = GlobalKey<FormState>();
  final passwordFieldKey = GlobalKey<FormState>();
  final passwordRepeatFieldKey = GlobalKey<FormState>();

  @override
  void dispose() {
    aliasFieldController.dispose();
    urlFieldController.dispose();
    usernameFieldController.dispose();
    notesFieldController.dispose();
    passwordFieldController.dispose();
    passwordRepeatFieldController.dispose();

    super.dispose();
  }

  validatePasswordFields() async {
    ApiProvider api = ApiProvider();
    CacheHandler cache = CacheHandler();

    if (passwordFieldController.text != passwordRepeatFieldController.text) {
      passwordFieldKey.currentState.validate();
      // passwordFieldKey.currentState.validate();
    } else {
      String userIdent = await cache.getStringFromCache('user_ident');
      String masterPassword =
          await cache.getSecureStringFromCache('master_password');

      String exception = null;

      await api
          .addUserPasswordEntry(
            userIdent,
            masterPassword,
            aliasFieldController.text,
            urlFieldController.text,
            usernameFieldController.text,
            passwordFieldController.text,
            notesFieldController.text,
          )
          .catchError(
              (e) => e = exception == null ? null : exception.toString());
      return exception;
    }
  }

  void validateAddPasswordEntryFields(bool addGeneratedPassword) async {
    CacheHandler cache = CacheHandler();

    String alias = aliasFieldController.text;
    // String url = urlFieldController.text;
    // String username = usernameFieldController.text;
    // String notes = notesFieldController.text;

    List<String> ids = await cache.getStringListFromCache('stored_ids');

    // check if alias already exists
    for (String id in ids) {
      String storedalias = await cache
          .getStringFromCache('stored_alias_with_id_' + id.toString());

      if (storedalias == alias) {
        setState(() {
          aliasValidator = false;
        });
      }
    }

    bool aliasvalidate = aliasFieldKey.currentState.validate();
    bool urlvalidate = urlFieldKey.currentState.validate();
    bool usernamevalidate = usernameFieldKey.currentState.validate();
    bool notesvalidate = notesFieldKey.currentState.validate();

    if (!addGeneratedPassword) {
      if (aliasvalidate && urlvalidate && usernamevalidate && notesvalidate) {
        Navigator.of(context).pop();
        showDialog(
          barrierDismissible: false,
          // barrierColor:,
          context: context,
          builder: (_) => AlertDialog(
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
                        // color: Colors.grey[200]
                      ),
                      child: Form(
                        key: passwordFieldKey,
                        child: TextFormField(
                          controller: passwordFieldController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'password',
                          ),
                          validator: (value) {
                            if (!passwordMatchValidatorFalse) {
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
                        // color: Colors.grey[200]
                      ),
                      child: Form(
                        key: passwordRepeatFieldKey,
                        child: TextFormField(
                          controller: passwordRepeatFieldController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: 'repeat password',
                          ),
                          validator: (value) {
                            if (!passwordMatchValidatorFalse) {
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
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    )
                    // Container(
                    //   margin: EdgeInsets.only(top: 20),
                    //   child: Text(
                    //     'Tipp: you can also add randomly generated passwords with words that you can easily remember. Try it out!',
                    //     style: TextStyle(
                    //       color: Colors.grey,
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
                //     // color: Colors.grey[200]
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
                    color: Colors.blue,
                    // textColor: Colors.white,
                    // color: Colors.grey[500],
                    onPressed: () async {
                      var error = await validatePasswordFields();
                      Navigator.of(context).pop();
                      final sucessSnackBar = SnackBar(
                        content: Text('The entry was stored sucessfully!'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.grey[800],
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
                        backgroundColor: Colors.grey[800],
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
          ),
        );
      }
    }

    if (addGeneratedPassword) {}
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      isExtended: true,
      onPressed: () {
        // Only for debug:
        Navigator.of(context).pushNamed('/registerscreen');
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            scrollable: true,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Form(
                    key: aliasFieldKey,
                    child: TextFormField(
                      controller: aliasFieldController,
                      decoration: InputDecoration(
                        helperText: 'Keyword for the entry.',
                        labelText: 'Alias',
                        filled: true,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter a alias';
                        }
                        if (!aliasValidator) {
                          setState(() {
                            aliasValidator = true;
                          });
                          return 'already in use';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Form(
                    key: urlFieldKey,
                    child: TextFormField(
                      controller: urlFieldController,
                      decoration: InputDecoration(
                        labelText: 'Url',
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
                  margin: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Form(
                    key: usernameFieldKey,
                    child: TextFormField(
                      controller: usernameFieldController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        filled: true,
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Form(
                    key: notesFieldKey,
                    child: TextFormField(
                      controller: notesFieldController,
                      decoration: InputDecoration(
                        labelText: 'notes',
                        filled: true,
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
                    // textColor: Colors.blue,
                    child: Text(
                      'Add own password',
                      style: TextStyle(
                        color: Colors.grey,
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
                    color: Colors.blue,
                    // textColor: Colors.white,
                    // color: Colors.grey[500],
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
    );
  }
}
