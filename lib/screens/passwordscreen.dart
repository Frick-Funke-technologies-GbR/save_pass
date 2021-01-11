// import 'dart:js';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:path/path.dart' as Path;
import 'package:loading_animations/loading_animations.dart';
import 'package:save_pass/models/classes/passwordentryClass.dart';
import 'package:save_pass/models/resources/api.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'package:save_pass/screens/loginscreen.dart';
import 'package:save_pass/widgets/bottomnavigationbar.dart';
import 'package:save_pass/widgets/drawer.dart';
import 'package:save_pass/widgets/passwordentry.dart';
import 'dart:ui' as ui;

Future<List<PasswordEntryClass>> getPasswordEntries() async {
  CacheHandler cache = CacheHandler();
  ApiProvider api = ApiProvider();

  String userIdent = await cache.getStringFromCache('user_ident');
  String password = await cache.getStringFromCache('master_password');

  List<PasswordEntryClass> entries =
      await api.getUserPasswordEntries(userIdent, password);

  print(entries[0].password);

  List<String> ids = [];

  for (PasswordEntryClass entry in entries) {
    await cache.addStringToCache(
        'stored_alias_with_id_' + entry.id.toString(), entry.alias);
    ids.add(entry.id.toString());
  }

  await cache.addStringListToCache('stored_ids', ids);

  return entries;
}

class PasswordScreen extends StatelessWidget {
  // final List<PasswordEntryClass> contents = [PasswordEntryClass(1, 'a', 'alias', 'note')];
  // String _randomGeneratedPassword = 'S(99*aSdFuj9Baum_';
  // for (str  in _randomGeneratedPassword.) {

  // }
  // @override
  // Widget _createDrawerItem(
  //   {IconData icon, String text, GestureTabCallback onTap}) {
  //     return ListTile(
  //       title: Row(
  //         children: <Widget> [
  //           Icon(icon),
  //           Padding(
  //             padding: EdgeInsets.only(left: 8),
  //             child: Text(text),
  //           ),
  //         ]
  //       ),
  //     ),
  //     onTap: onTap,
  //   };
  // )
  @override
  Widget build(BuildContext context) {
    // task
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    ListView _passwordEntryListView(data) {
      return ListView.builder(
        // addSemanticIndexes: true,
        // addRepaintBoundaries: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(top: 100, left: 5, right: 5, bottom: 40),
        itemCount: data.length,
        itemBuilder: (context, index) {
          // getPasswordEntries();
          return PasswordEntry(
            data[index].id,
            data[index].url,
            data[index].alias,
            data[index].username,
            data[index].password,
            data[index].notes,
          );
        },
      );
    }

    return Scaffold(
      drawer: CustomDrawer(true, false, false),
      // backgroundColor: Colors.transparent,
      backgroundColor: Colors.grey[200],
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.vpn_key),
      //       title: Text('Passwords'),
      //     ),
      //     // BottomNavigationBarItem(
      //     //   icon: Icon(Icons.account_balance_wallet),
      //     //   title: Text('Wallet'),
      //     // ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.notification_important),
      //         title: Text('Notifications')),
      //   ],
      //   backgroundColor: Colors.grey[200],
      // ),

      bottomNavigationBar: CustomBottomNavigationBar(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: PasswordActionButtonWithDialogWidget(),
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            top: true,
            bottom: true,
            child: CustomPaint(
              painter: BackgroundPainter(),
              child: Stack(
                // height: 900,

                children: [
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //     colors: [
                  //       Colors.blue[800],
                  //       Colors.blue[700],
                  //       Colors.blue[600],
                  //       Colors.blue[400],
                  //     ],
                  //     begin: FractionalOffset(0.0, 0.0),
                  //     end: FractionalOffset(1, 0),
                  //     stops: [0, 1],
                  //     tileMode: TileMode.clamp,
                  //   ),
                  // ),

                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [

                  // Toplabel(),
                  // TODO: Add search passwords bar

                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(5),
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey[300],
                  //         blurRadius: 3,
                  //         spreadRadius: 1,
                  //       )
                  //     ],
                  //   ),
                  //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  //   height: 60,

                  // alignment: Alignment.center,

                  //   child: TextField(
                  //     // controller: editingController,
                  //     decoration: InputDecoration(
                  //       // fillColor: Colors.grey[100],
                  //       // hintText: "Search",
                  //       labelText: 'Search',
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(5),
                  //         borderSide: BorderSide(
                  //           width: 0,
                  //           style: BorderStyle.none,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Container(
                    // height: 422,
                    // margin: EdgeInsets.symmetric(horizontal: 10),
                    // decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey[300], width: 3),
                    // color: Colors.grey[100],
                    // borderRadius: BorderRadius.circular(10)),
                    child: ['contents', 'moin'].length != 0
                        ? RefreshIndicator(
                            onRefresh: () async {
                              // TODO: add code here!!!
                            },
                            child: FutureBuilder<List<PasswordEntryClass>>(
                              future: getPasswordEntries(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<PasswordEntryClass> data = snapshot.data;
                                  return _passwordEntryListView(data);
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                // TODO: Add proper Progress Indicator
                                return CircularProgressIndicator();
                              },
                            ),
                          )
                        : Center(
                            child: LoadingBouncingGrid.circle(
                              borderSize: 5,
                              backgroundColor: Colors.blue,
                              size: 30,
                              inverted: true,
                              duration: Duration(milliseconds: 400),
                            ),
                          ),
                  ),
                  Positioned(
                    top: 10,
                    right: 15,
                    left: 15,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 3,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      // height: 50,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey[500],
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              // controller: editingController,
                              decoration: InputDecoration(
                                // fillColor: Colors.grey[100],
                                // hintText: "Search",
                                // labelText: 'Search',
                                hintText: 'Search passwords',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: 8,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              // TODO: Add user account image
                              backgroundImage: NetworkImage(
                                  'https://via.placeholder.com/150'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  // List<Widget> getContents() {
  //   for (int i = 0; i < 10; i++) {
  //     contents.add(PasswordEntry(i, 'Paulus222', 'Facebook', 'Not all cpital letters, but with my birthday in it.'))
  //   }
  //   return contents;
  // }
}

// class _MainScreenState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
// child: BottomNavigationBarMain()
//   Container(
//     color: Colors.white,
//     child: Column(
//       children: [
//         Toplabel(),
//         Container(
//         ),
//       ],
//     ),
// ),
//   }
// }

// class BottomNavigationBarMain extends StatefulWidget {
//   @override
//   _BottomNavigationBarMainState createState() => _BottomNavigationBarMainState();
// }

// class _BottomNavigationBarMainState extends State<BottomNavigationBarMain> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.vpn_key),
//             title: Text('Passwords')
//           ),
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.account_balance_wallet),
//             title: Text('Notes'),
//           ),
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.warning),
//             title: Text('Notifications'),
//           ),
//         ],
//       ),
//     );
//   }
// }

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


  void validatePasswordFields() async {
    ApiProvider api = ApiProvider();
    CacheHandler cache = CacheHandler();

    if (passwordFieldController.text != passwordRepeatFieldController.text) {
      passwordFieldKey.currentState.validate();
      // passwordFieldKey.currentState.validate();
    } else {
      String userIdent = await cache.getStringFromCache('user_ident');
      String masterPassword = await cache.getSecureStringFromCache('master_password');

      await api.addUserPasswordEntry(
        userIdent,
        masterPassword,
        aliasFieldController.text,
        urlFieldController.text,
        usernameFieldController.text,
        passwordFieldController.text,
        notesFieldController.text,
      );
      print('TEEEST');

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
                    onPressed: () {
                      validatePasswordFields();
                      Navigator.of(context).pop();
                      final sucessSnackBar = SnackBar(content: Text('The entry was stored sucessfully!'),);  
                      Scaffold.of(context).showSnackBar(sucessSnackBar);
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

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.grey[300];
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
