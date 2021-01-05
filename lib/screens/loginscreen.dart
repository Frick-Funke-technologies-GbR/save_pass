import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:save_pass/widgets/toplabel.dart';
import 'package:save_pass/models/resources/api.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'dart:ui' as ui;

Future<String> getUserIdent() async {
  CacheHandler cache = CacheHandler();
  String value = await cache.getStringFromCache('user_ident');
  return value;
}

// Future<bool> checkMasterPassword(String password) async {
//   // TODO: Add get username from progreq.json
//   ApiProvider api = ApiProvider();
//   api.loginUser('paulaner');
//   String userIdent = await getUserIdent();
//   bool passcheck = await api.checkPass(userIdent, password);
//   return passcheck;
// }

Future<bool> checkMasterPassword(String password) async {
  // TODO: Add get username from progreq.json
  // final _boolSubject = BehaviorSubject<bool>();
  ApiProvider api = ApiProvider();
  api.loginUser('paulaner');
  // bool _bool;
  // Future<String> userIdent = getUserIdent();
  // userIdent.then(
  //   (userIdent) {
  //     Future<bool> checkpass = api.checkPass(userIdent, password);
  //     checkpass.then(
  //       (boolean) {
  //         print('Point.1');
  //         _boolSubject.add(boolean);
  //         // _bool = boolean;
  //       },
  //     );
  //     print('hä');
  //   },
  // );
  // print('Sojetztaber');
  // var stream = _boolSubject.stream;
  // return stream;

  String userIdent = await getUserIdent();
  bool check = await api.checkPass(userIdent, password);
  return check;
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
  final textFieldController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textFieldController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    bool _showPassword = false;
    bool passwordValidator = false;
    int wrongPassCount = 0;
    final passinputKey = GlobalKey<FormState>();
    final passButtonKey = GlobalKey<FormState>();
    // var content = [
    //   'Hello this is a brand new language, i\'m working on right now',
    //   'What\'s our best blue cheese?',
    // ];
    void togglePasswordVisibillity() {
      _showPassword = !_showPassword;
      if (_showPassword) {
        setState(() {
          _showPassword = false;
        });
      } else {
        _showPassword = true;
      }
      print(_showPassword);
    }

    void passInputValidator() async {
      var response = await checkMasterPassword(textFieldController.text);

      setState(
        () {
          passwordValidator = response;
        },
      );

      if (passinputKey.currentState.validate()) {
        Navigator.of(context).pushNamed("/newpasswordscreen");
      }

      // if (passinputKey) {};
      // if (checkMasterPassword(value)) {
      //   return null;
      // }
      // ;
      // Navigator.of(context).pushNamed("/newpasswordscreen");
    }

    return new Scaffold(
      // backgroundColor: Colors.white,

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
                  margin: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      // BoxShadow(
                      //   color: Colors.grey[100],
                      //   blurRadius: 10,
                      //   spreadRadius: 3,
                      //   // offset: Offset(3, 4),
                      // ),
                    ],
                    // color: Colors.grey[100],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      const Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Expanded(
                      Container(
                        decoration: BoxDecoration(
                          // color: Colors.grey[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: 80,
                          horizontal: 10,
                        ),
                        child: Form(
                          key: passinputKey,
                          child: new TextFormField(
                            controller: textFieldController,
                            // key: passinputKey,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a Password';
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
                              print('niunununun');
                              print(passwordValidator);
                              if (passwordValidator) {
                                return null;
                              }
                              return 'Password is incorrect';
                            },
                            enableInteractiveSelection: true,
                            onEditingComplete: () {
                              // passinputKey.currentState.validate();
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
                                  color:
                                      _showPassword ? Colors.blue : Colors.grey,
                                ),
                                onPressed: () {
                                  togglePasswordVisibillity();
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
                          ),
                        ),
                      ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(left: 245, bottom: 20),
                        child: FlatButton(
                          key: passButtonKey,
                          child: Icon(
                            Icons.lock_open,
                            color: Colors.blue,
                          ),
                          // color: Colors.blue,
                          // splashColor: Colors.blue,
                          onPressed: () {
                            passInputValidator();
                          },
                          color: Colors.grey[100],
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
          Colors.blue,
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
    // paint.color = Colors.blue;
    paint
      ..shader = ui.Gradient.linear(
        Offset(width * 0, height * 0.9),
        Offset(width * 0.9, height * 0.4),
        [
          Colors.white,
          Colors.blue,
        ],
      );
    canvas.drawPath(circlePathTwo, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
