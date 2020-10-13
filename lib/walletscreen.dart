import 'package:flutter/material.dart';
import 'package:save_pass/bottomnavigationbar.dart';
import 'package:save_pass/drawer.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(false,true,false),
      bottomNavigationBar: CustomBottomNavigationBar(),


    );
  }
}