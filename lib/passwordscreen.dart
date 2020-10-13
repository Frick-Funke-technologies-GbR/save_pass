
import 'package:flutter/material.dart';
import 'package:save_pass/bottomnavigationbar.dart';
import 'package:save_pass/drawer.dart';
import 'package:save_pass/passwordentry.dart';


class PasswordScreen extends StatelessWidget {
  final List<String> contents = [
    'skjadfh',
    'sadgareAEF',
    'skjadfh',
    'sadgareAEF',
    'skjadfh',
    'sadgareAEF',
    'skjadfh',
    'sadgareAEF',
    'skjadfh',
    'sadgareAEF',
    'skjadfh',
    'sadgareAEF',
    'skjadfh',
    'sadgareAEF',
    'skjadfh',
    'sadgareAEF',
    'skjadfh',
    'sadgareAEF',
    'skjadfh',
    'sadgareAEF',
    'skjadfh',
    'sadgareAEF',
    'skjadfh',
    'sadgareAEF',
  ];

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
    return Scaffold(
      drawer: CustomDrawer(true,false,false),
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
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => SimpleDialog(
                title: Text('Create password entry'),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                ],
              ),
            );
          },
          elevation: 8,
          icon: Icon(Icons.add),
          label: Text('Add password')
          // label: Text('Add password')
          ),
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
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 100),
                    itemCount: contents.length,
                    itemBuilder: (context, i) {
                      return PasswordEntry(
                        contents[i],
                        contents[i + 1],
                        contents[i + 2],
                        contents[i + 3],
                      );
                    },
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
                            backgroundImage:
                                NetworkImage('https://via.placeholder.com/150'),
                          ),
                        )
                      ],
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
