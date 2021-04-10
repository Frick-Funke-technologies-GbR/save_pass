import 'package:flutter/material.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';
import 'package:save_pass/models/resources/api.dart';
import 'package:save_pass/models/resources/cache.dart';

final _passwordFieldController = TextEditingController();
final _passwordRepeatFieldController = TextEditingController();

final _passwordFieldKey = GlobalKey<FormState>();
final _passwordRepeatFieldKey = GlobalKey<FormState>();

bool passwordMatchValidatorFalse;


Future<String> validatePasswordFields() async {
  ApiProvider api = ApiProvider();
  CacheHandler cache = CacheHandler();

  if (_passwordFieldController.text != _passwordRepeatFieldController.text) {
    _passwordFieldKey.currentState.validate();
    // _passwordFieldKey.currentState.validate();
  } else {
    String userIdent = await cache.getSecureStringFromCache('user_ident');
    // FIXME: possible error found in register progress. if not ignore/delete this comment
    // String masterPassword =
    //     await cache.getSecureStringFromCache('master_password');

    String exception = null;

    // await api
    //     .login(userIdent, masterPassword)
    //     .catchError(
    //         (e) => e = exception == null ? null : exception.toString());
    
    await CacheHandler().addSecureStringToCache('master_password', _passwordFieldController.text);
    return null;
  }
}

Future showAddPasswordDialog(BuildContext context, bool register) async {
  await showDialog(
    barrierDismissible: false,
    // barrierColor:,
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('Add password'),
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
                      if (!passwordMatchValidatorFalse) {
                        return 'passwords don\'t match';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              register
                  ? Container()
                  : Text(
                      'Tipp: you can also add randomly generated passwords with words that you can easily remember. Try it out!',
                      style: TextStyle(
                        color: AppDefaultColors.colorPrimaryGrey,
                        fontSize: 12,
                      ),
                    ),
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
            TextButton(
              child: Text('Submit'),
              // key: _submitButtonKey,
              // textColor: Colors.white,
              // color: AppDefaultColors.colorPrimaryGrey[500],
              onPressed: () async {
                String goFurther = await validatePasswordFields();
                if (goFurther == null) {
                  Navigator.of(context).pop();
                } else {
                  return false;
                }
              },
              // var error = await validatePasswordFields();
              //   Navigator.of(context).pop();
              //   final sucessSnackBar = SnackBar(
              //     content: Text('The entry was stored sucessfully!'),
              //     behavior: SnackBarBehavior.floating,
              //     backgroundColor: AppDefaultColors.colorPrimaryGrey[800],
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(10),
              //       ),
              //     ),
              //   );
              //   // sucess = sucess.toString();
              //   final unsucessSnackBar = SnackBar(
              //     content: Text(
              //       'An Error occured $error',
              //     ),
              //     behavior: SnackBarBehavior.floating,
              //     backgroundColor: AppDefaultColors.colorPrimaryGrey[800],
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(10),
              //       ),
              //     ),
              //   );
              //   if (error == null) {
              //     error = false;
              //   }
              //   Scaffold.of(context).showSnackBar(
              //       error ? unsucessSnackBar : sucessSnackBar);
              // },
            ),
          ],
        ),
      ],
    ),
  );
}
