import 'package:flutter/material.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';

void showAddPasswordDialog(BuildContext context) {
  final passwordFieldKey = GlobalKey<FormState>();
  final passwordFieldController = TextEditingController();
  bool passwordMatchValidatorFalse;

  final passwordRepeatFieldKey = GlobalKey<FormState>();
  var passwordRepeatFieldController = TextEditingController();
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
                  // color: AppDefaultColors.colorPrimaryGrey[200]
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
                  // color: AppDefaultColors.colorPrimaryGrey[200]
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
              child: Text('Submit'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: AppDefaultColors.colorPrimaryBlue,
              // textColor: Colors.white,
              // color: AppDefaultColors.colorPrimaryGrey[500],
              onPressed: () async {},
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