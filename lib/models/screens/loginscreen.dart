import 'package:flutter/material.dart';
import 'package:save_pass/models/widgets/toplabel.dart';
import 'package:save_pass/models/screens/passwordscreen.dart';
import 'dart:ui' as ui;

bool checkMasterPassword(String value) {
  // TODO: Add passworValidate class/function
  if (value == 'password') {
    return true;
  } else {
    return false;
  }
}

class LoginScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // var content = [
    //   'Hello this is a brand new language, i\'m working on right now',
    //   'What\'s our best blue cheese?',
    // ];
    return Scaffold(
      // backgroundColor: Colors.white,

      // appBar: AppBar(
      //   title: Text('SavePass.'),
      // ),
      body: SafeArea(
        bottom: true,
        top: true,
        child: CustomPaint(
          painter: BackgroundPainter(),
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
                      child: PasswordInputField(),
                    ),
                    // ),
                    Container(
                      margin: EdgeInsets.only(left: 245, bottom: 20),
                      child: FlatButton(
                        child: Icon(
                          Icons.lock_open,
                          color: Colors.blue,
                        ),
                        // color: Colors.blue,
                        // splashColor: Colors.blue,
                        onPressed: () {
                          // if (passinputKey) {};
                          // if (checkMasterPassword(value)) {
                          //   return null;
                          // }
                          // ;
                          Navigator.of(context).pushNamed("/newpasswordscreen");
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
    circlePathOne.moveTo(0, height * 0.1);
    circlePathOne.quadraticBezierTo(
      width * 0.9,
      height * 0.1,
      width * 0,
      height * 0.9,
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
    circlePathTwo.moveTo(width * 1, height * 0.1);
    circlePathTwo.quadraticBezierTo(
      width * 0.1,
      height * 0.8,
      width * 1,
      height * 0.9,
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

class PasswordInputField extends StatefulWidget {
  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _showPassword = false;
  int wrongPassCount = 0;
  final passinputKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: passinputKey,
      child: TextFormField(
        // key: ,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a Password';
          }
          if (wrongPassCount > 3) {
            // showDialog();
            return 'You failed to enter the correct password three times';
          }
          if (checkMasterPassword(value)) {
            return null;
          } else {
            wrongPassCount += 1;
            return 'Password is incorrect';
          }
        },
        enableInteractiveSelection: true,
        onEditingComplete: () {
          if (passinputKey.currentState.validate()) {
            Navigator.of(context).pushNamed("/newpasswordscreen");
          }
        },
        // onEditingComplete: ,
        keyboardType: TextInputType.visiblePassword,
        obscureText: !this._showPassword,
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.security),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: this._showPassword ? Colors.blue : Colors.grey,
            ),
            onPressed: () {
              setState(() => this._showPassword = !this._showPassword);
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
    );
  }
}
