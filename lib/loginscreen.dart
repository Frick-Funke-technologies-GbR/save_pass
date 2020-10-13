import 'package:flutter/material.dart';
import 'package:save_pass/toplabel.dart';
import 'package:save_pass/passwordscreen.dart';

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
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('SavePass.'),
      // ),
      body: SafeArea(
        bottom: true,
        top: true,
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
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(
                  const Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  // Expanded(
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                    child: RaisedButton(
                      child: Icon(
                        Icons.lock_open,
                        color: Colors.blue,
                      ),
                      // color: Colors.blue,
                      // splashColor: Colors.blue,
                      onPressed: () {
                        Navigator.of(context).pushNamed("/newpasswordscreen");
                      },
                      color: Colors.white,
                      elevation: 6,
                    ),
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

class PasswordInputField extends StatefulWidget {
  @override
  _PasswordInputFieldState createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableInteractiveSelection: true,
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
        fillColor: Colors.white,
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
  }
}
