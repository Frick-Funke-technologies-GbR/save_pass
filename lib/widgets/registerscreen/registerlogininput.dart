import 'package:flutter/material.dart';


class RegisterLoginInputWidget extends StatefulWidget {
  @override
  _RegisterLoginInputWidgetState createState() =>
      _RegisterLoginInputWidgetState();
}

class _RegisterLoginInputWidgetState extends State<RegisterLoginInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 100, minWidth: 300),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: 110, maxWidth: 260),
            child: Expanded(
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
                            margin: EdgeInsets.only(left: 3),
                            child: CircleAvatar(
                              // FIXME: This google icon just isn't beautiful enough
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(2),
                                child: Icon(Icons.account_circle),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 7, right: 90),
                            child: Text(
                              'Register',
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
                                padding: EdgeInsets.all(2),
                                child: Image.asset('assets/GoogleIcon.png'),
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
