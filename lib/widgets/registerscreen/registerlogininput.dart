import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_pass/models/authentication/auth.dart';
import 'package:save_pass/models/classes/userClass.dart';
import 'package:save_pass/models/resources/api.dart';

class RegisterLoginInputWidget extends StatefulWidget {
  @override
  _RegisterLoginInputWidgetState createState() =>
      _RegisterLoginInputWidgetState();
}

class _RegisterLoginInputWidgetState extends State<RegisterLoginInputWidget> {
  User user;
  bool _showSecondRegisterInputWidget = false;
  bool _googleRegisterButtonInfoVisible = false;

  @override
  void initState() {
    super.initState();
    signOutGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 100, minWidth: 270),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
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
                      color: Colors.grey,
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
                              // FIXME: This google icon just isn't beautiful enough
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.account_circle),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 7, right: 117),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Register',
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
                      color: Colors.blue,
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
                                  _googleRegisterButtonInfoVisible =
                                      !_googleRegisterButtonInfoVisible;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        // TODO: Add username textinput, finish code
                        User user = await signInWithGoogle();
                        this.user = user;
                        print(user.toString());
                        try {
                          UserClass addedUser = await ApiProvider().registerUser(
                              'username', user.displayName, '', user.email);
                        } catch (e) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString().replaceAll('Exception', 'Error')),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.grey[800],
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
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: _googleRegisterButtonInfoVisible ? 1.0 : 0.0,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 230),
                      child: Text(
                        'Note: if you sign in with google, you will have access to online features later on. You encrypted data will not be stored in google servers though.',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      ),
                    ),
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
                ElevatedButton(
                  child: Text('Login'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterInputWidget extends StatefulWidget {
  @override
  _RegisterInputWidgetState createState() => _RegisterInputWidgetState();
}

class _RegisterInputWidgetState extends State<RegisterInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            // padding: EdgeInsets.symmetric(),
            constraints: BoxConstraints(maxWidth: 230),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: TextField(),
          )
        ],
      ),
      height: 300,
      width: 350,
    );
  }
}
