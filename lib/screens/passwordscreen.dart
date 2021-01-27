// import 'dart:js';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:path/path.dart' as Path;
import 'package:loading_animations/loading_animations.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';
import 'package:save_pass/models/classes/passwordentryClass.dart';
import 'package:save_pass/models/resources/api.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'package:save_pass/screens/loginscreen.dart';
import 'package:save_pass/widgets/bottomnavigationbar.dart';
import 'package:save_pass/widgets/passwordscreen/passwordactionbuttonwithdialog.dart';
import 'package:save_pass/widgets/uni/drawer.dart';
import 'package:save_pass/widgets/passwordscreen/passwordentry.dart';
import 'package:save_pass/widgets/uni/usercard.dart';
import 'package:url_launcher/url_launcher.dart';
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

  void _showAccountDialog(BuildContext context) {
    String username = 'hallo';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: AppDefaultColors.colorPrimaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: UserCard(username: username),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // task
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    // TODO: Add widget to display if no entry added yet
    // FIXME: debug api if no entry added yet
    CustomScrollView _passwordEntryListView(data) {
      return CustomScrollView(
        // semanticChildCount: data.length,
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(bottom: 30),
            sliver: SliverAppBar(
              elevation: 0,
              // forceElevated: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              title: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      color: AppDefaultColors.colorPrimaryGrey[400],
                      blurRadius: 3,
                      spreadRadius: 0.01,
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
                        color: AppDefaultColors.colorPrimaryGrey[500],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        // controller: editingController,
                        decoration: InputDecoration(
                          // fillColor: AppDefaultColors.colorPrimaryGrey[100],
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
                        child: RawMaterialButton(
                          onPressed: () {
                            _showAccountDialog(context);
                          },
                          shape: CircleBorder(),
                        ),
                        backgroundColor: Colors.transparent,
                        radius: 15,
                        // TODO: Add user account image
                        backgroundImage: NetworkImage(
                            'https://www.w3schools.com/w3css/img_lights.jpg'),
                      ),
                    )
                  ],
                ),
              ),

              // backgroundColor: Colors.transparent,
              // flexibleSpace: FlexibleSpaceBar(),
              // collapsedHeight: 200,

              snap: true,
              floating: true,
              // pinned: true,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // getPasswordEntries();
                return PasswordEntry(
                  data[index].id,
                  data[index].url,
                  data[index].alias,
                  data[index].username,
                  data[index].password,
                  data[index].notes,
                  data[index].thumbnail,
                );
              },
              childCount: data.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              constraints: BoxConstraints(minHeight: 100),
              padding: EdgeInsets.only(top: 20),
              alignment: Alignment.topCenter,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Logos provided by ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: 'Clearbit',
                      style: TextStyle(
                          color: AppDefaultColors.colorPrimaryBlue,
                          fontSize: 12,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch('https://clearbit.com');
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      drawer: CustomDrawer(true, false, false),
      backgroundColor: Colors.white,
      // backgroundColor: AppDefaultColors.colorPrimaryGrey[200],
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
      //   backgroundColor: AppDefaultColors.colorPrimaryGrey[200],
      // ),

      bottomNavigationBar: CustomBottomNavigationBar(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: PasswordActionButtonWithDialogWidget(),
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            top: true,
            bottom: true,
            child: Stack(
              // height: 900,

              children: [
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [
                //       AppDefaultColors.colorPrimaryBlue[800],
                //       AppDefaultColors.colorPrimaryBlue[700],
                //       AppDefaultColors.colorPrimaryBlue[600],
                //       AppDefaultColors.colorPrimaryBlue[400],
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
                //         color: AppDefaultColors.colorPrimaryGrey[300],
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
                //       // fillColor: AppDefaultColors.colorPrimaryGrey[100],
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
                  // border: Border.all(color: AppDefaultColors.colorPrimaryGrey[300], width: 3),
                  // color: AppDefaultColors.colorPrimaryGrey[100],
                  // borderRadius: BorderRadius.circular(10)),

                  // TODO: Add no data handler
                  child: ['contents', 'moin'].length != 0
                      ? RefreshIndicator(
                          onRefresh: () async {
                            // TODO: add refresh function
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
                              return Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    // borderSize: 5,
                                    // backgroundColor: AppDefaultColors.colorPrimaryBlue,
                                    strokeWidth: 7,
                                    // size: 30,
                                    // inverted: true,
                                    // duration: Duration(milliseconds: 400),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: LoadingBouncingGrid.circle(
                            borderSize: 5,
                            backgroundColor: AppDefaultColors.colorPrimaryBlue,
                            size: 30,
                            inverted: true,
                            duration: Duration(milliseconds: 400),
                          ),
                        ),
                ),
              ],
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
    paint.color = AppDefaultColors.colorPrimaryGrey[300];
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
          AppDefaultColors.colorPrimaryBlue,
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
    // paint.color = AppDefaultColors.colorPrimaryBlue;
    paint
      ..shader = ui.Gradient.linear(
        Offset(width * 0, height * 0.9),
        Offset(width * 0.9, height * 0.4),
        [
          Colors.white,
          AppDefaultColors.colorPrimaryBlue,
        ],
      );
    canvas.drawPath(circlePathTwo, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
