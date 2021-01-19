import 'package:flutter/material.dart';

class RegisterLoginInputWidget extends StatefulWidget {
  @override
  _RegisterLoginInputWidgetState createState() =>
      _RegisterLoginInputWidgetState();
}

class _RegisterLoginInputWidgetState extends State<RegisterLoginInputWidget> {
  bool _showSecondRegisterInputWidget = false;
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
                            constraints: BoxConstraints(minWidth: 100),
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
                            margin: EdgeInsets.only(left: 7, right: 90),
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
                                padding: EdgeInsets.only(left:2, right:2, top:2, bottom:2),
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
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
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
            child: TextField(
              
            ),
          )
        ],
      ),
      height: 300,
      width: 350,
    );
  }
}
