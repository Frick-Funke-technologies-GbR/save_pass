import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:save_pass/models/classes/passwordentryClass.dart';
import 'package:save_pass/models/widgets/bottomnavigationbar.dart';
import 'package:save_pass/models/widgets/drawer.dart';
import 'package:save_pass/models/widgets/passwordentry.dart';
import 'dart:ui' as ui;


class PasswordScreen extends StatelessWidget {
  // final List<PasswordEntryClass> contents = [PasswordEntryClass(1, 'a', 'alias', 'note')];
  final List<String> contents = [
    'naöls0üivjknkljföiopaeiofj',
    'saoibsdnoibn',
    'vnbbnouasiuelh',
    'naöls0üivjknkljföiopaeiofj',
    'saoibsdnoibn',
    'vnbbnouasiuelh',
    'naöls0üivjknkljföiopaeiofj',
    'saoibsdnoibn',
    'vnbbnouasiuelh',
    'naöls0üivjknkljföiopaeiofj',
    'saoibsdnoibn',
    'vnbbnouasiuelh',
    'naöls0üivjknkljföiopaeiofj',
    'saoibsdnoibn',
    'vnbbnouasiuelh',
    'naöls0üivjknkljföiopaeiofj',
    'saoibsdnoibn',
    'vnbbnouasiuelh',
    'naöls0üivjknkljföiopaeiofj',
    'saoibsdnoibn',
    'vnbbnouasiuelh',
    'naöls0üivjknkljföiopaeiofj',
    'saoibsdnoibn',
    'vnbbnouasiuelh',
  ];
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
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              // scrollable: true,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.5),
                      //     spreadRadius: 2.5,
                      //     blurRadius: 5,
                      //     offset: Offset(0, 2), // changes position of shadow
                      //   ),
                      // ],
                    ),
                    child: RichText(
                      overflow: TextOverflow.fade,
                      text: TextSpan(
                        style: TextStyle(color: Colors.red),
                        text: 'nmjs',
                        children: [
                          TextSpan(
                            style: TextStyle(color: Colors.blue),
                            text: '!)i',
                          ),
                        ],
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
                      onPressed: () {
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
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      // padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        // color: Colors.grey[200]
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          labelText: 'Provider',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      // padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        // color: Colors.grey[200]
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          labelText: 'Website adress',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      // padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        // color: Colors.grey[200]
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          labelText: 'Username',
                                        ),
                                      ),
                                    ),
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
                            actions: [],
                          ),
                        );
                      },
                      child: Text(
                        'Add own password',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.blue,
                      // textColor: Colors.white,
                      // color: Colors.grey[500],
                      onPressed: () {
                        Navigator.of(context).pop();
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
      ),
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
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    // decoration: BoxDecoration(
                    // border: Border.all(color: Colors.grey[300], width: 3),
                    // color: Colors.grey[100],
                    // borderRadius: BorderRadius.circular(10)),
                    child: contents.length != 0
                        ? LiquidPullToRefresh(
                            onRefresh: () async {},
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: 100),
                              itemCount: contents.length,
                              itemBuilder: (context, i) {
                                return PasswordEntry(
                                  1,
                                  'https://www.Google.com/accounts',
                                  'Google',
                                  'Moinsen3327',
                                  'Diesistderbeginntrallala',
                                  'Dieshatnichtsdamitzutunkasdjfp denn ich habe in der Zwischenzeit noch eine neue Timelie gedrawed. Aber wer noch nicht einen genauen Schuss im Leben missachtet hat, der kann sich auch nicht darüber freuen, wenn er mal danebengeht.',
                                );
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