// import 'package:flutter/material.dart';
// import 'package:save_pass/drawer.dart';
// import 'package:save_pass/bottomnavigationbar.dart';
// import 'package:save_pass/passwordscreen.dart';

// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: CustomDrawer(),
//       // backgroundColor: Colors.transparent,
//       backgroundColor: AppDefaultColors.colorPrimaryGrey[200],
//       // bottomNavigationBar: BottomNavigationBar(
//       //   currentIndex: 0,
//       //   items: [
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.vpn_key),
//       //       title: Text('Passwords'),
//       //     ),
//       //     // BottomNavigationBarItem(
//       //     //   icon: Icon(Icons.account_balance_wallet),
//       //     //   title: Text('Wallet'),
//       //     // ),
//       //     BottomNavigationBarItem(
//       //         icon: Icon(Icons.notification_important),
//       //         title: Text('Notifications')),
//       //   ],
//       //   backgroundColor: AppDefaultColors.colorPrimaryGrey[200],
//       // ),

//       bottomNavigationBar: CustomBottomNavigationBar(),

//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {},
//           elevation: 8,
//           icon: Icon(Icons.add),
//           label: Text('Add password')
//           // label: Text('Add password')
//           ),
//       body: PasswordScreen(),
//     );
//   }
// }
