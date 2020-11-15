import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // shape: CircularNotchedRectangle(),
      color: Colors.white,
      // notchMargin: 4,
      child: Builder(
        builder: (context) => Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Container(
            //   height: 40,
            //   width: 250,
            //   alignment: Alignment.center,
            //   margin: EdgeInsets.only(left: 10, top: 3),
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //     borderRadius: BorderRadius.circular(20)
            //   ),
            //   child: Row(
            //     children: [
            // IconButton(
            //   icon: Icon(Icons.account_balance_wallet),
            //   onPressed: null,
            //   padding: EdgeInsets.symmetric(horizontal: 30),
            //   color: Colors.white,
            // ),
            IconButton(
              icon: Icon(Icons.feedback),
              onPressed: null,
              // padding: EdgeInsets.symmetric(horizontal: 30),
              color: Colors.grey,
            ),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              // padding: EdgeInsets.symmetric(horizontal: 30),
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavigationBarWalletScr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.white,
      notchMargin: 6,
      child: Builder(
        builder: (context) => Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Container(
            //   height: 40,
            //   width: 250,
            //   alignment: Alignment.center,
            //   margin: EdgeInsets.only(left: 10, top: 3),
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //     borderRadius: BorderRadius.circular(20)
            //   ),
            //   child: Row(
            //     children: [
            // IconButton(
            //   icon: Icon(Icons.account_balance_wallet),
            //   onPressed: null,
            //   padding: EdgeInsets.symmetric(horizontal: 30),
            //   color: Colors.white,
            // ),
            IconButton(
              icon: Icon(Icons.feedback),
              onPressed: null,
              // padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey,
            ),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              // padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

