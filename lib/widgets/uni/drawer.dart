import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';
import 'package:save_pass/widgets/uni/toplabel.dart';


class CustomDrawer extends StatefulWidget {
  final bool _selectedPasswords;
  final bool _selectedWallet;
  final bool _selectedSettings;

  const CustomDrawer(
    this._selectedPasswords,
    this._selectedWallet,
    this._selectedSettings,
  );

  @override
  _CustomDrawerState createState() => _CustomDrawerState(
      this._selectedPasswords, this._selectedWallet, this._selectedSettings);
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _selectedPasswords = false;
  // bool _selectedPasswordsFirst = false;
  bool _selectedWallet = false;
  bool _selectedSettings = false;

  _CustomDrawerState(
    this._selectedPasswords,
    this._selectedWallet,
    this._selectedSettings,
  );
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            // margin: EdgeInsets.symmetric(vertical: 0),
            // margin: EdgeInsets.zero,

            decoration: BoxDecoration(
              color: AppDefaultColors.colorPrimaryBlue,
            ),
            child: Center(
              child: Toplabel(),
            ),
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: this._selectedPasswords
                  ? AppDefaultColors.colorPrimaryBlue[100]
                  : Colors.transparent,
            ),
            child: ListTile(
              dense: true,
              selected: this._selectedPasswords,
              // autofocus: true,
              leading: Icon(
                Icons.vpn_key,
              ),
              onTap: () {
                Navigator.of(context).pop();
                if (!_selectedPasswords) {
                  Navigator.of(context).pushReplacementNamed('/passwordscreen');
                } else {
                  Navigator.of(context).pushNamed('/passwordscreen');
                }
                setState(() {
                  this._selectedPasswords = true;
                  this._selectedSettings
                      ? this._selectedSettings = !this._selectedSettings
                      : null;
                  this._selectedWallet
                      ? this._selectedWallet = !this._selectedWallet
                      : null;
                });
              },
              title: Text('Passwords'),
            ),
          ),

          Container(
            height: 50,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: this._selectedWallet
                  ? AppDefaultColors.colorPrimaryBlue[100]
                  : Colors.transparent,
            ),
            child: ListTile(
              dense: true,
              selected: this._selectedWallet,
              // autofocus: true,
              leading: Icon(
                Icons.account_balance_wallet,
              ),
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  this._selectedWallet = true;
                  this._selectedSettings
                      ? this._selectedSettings = !this._selectedSettings
                      : null;
                  this._selectedPasswords
                      ? this._selectedPasswords = !this._selectedPasswords
                      : null;
                });
                Navigator.of(context).pushNamed('/walletscreen');
              },
              title: Text('Wallet'),
            ),
          ),
          Divider(
            indent: 15,
            endIndent: 15,
            thickness: 1,
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: this._selectedSettings
                  ? AppDefaultColors.colorPrimaryBlue[100]
                  : Colors.transparent,
            ),
            child: ListTile(
              dense: true,
              selected: this._selectedSettings,
              // autofocus: true,
              leading: Icon(
                Icons.settings,
              ),
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  this._selectedSettings = true;
                  this._selectedWallet
                      ? this._selectedWallet = !this._selectedWallet
                      : null;
                  this._selectedPasswords
                      ? this._selectedPasswords = !this._selectedPasswords
                      : null;
                });
                Navigator.of(context).pushNamed('/settingsscreen');
              },
              title: Text('Settings'),
            ),
          ),
          // ListTile(
          //   focusColor: AppDefaultColors.colorPrimaryBlue[200],
          //   onTap: () {
          //     Navigator.of(context).pop();
          //   },
          //   leading: Icon(Icons.account_balance_wallet),
          //   title: Text('Wallet'),
          // ),

          // ListTile(
          //   focusColor: AppDefaultColors.colorPrimaryBlue[200],
          //   onTap: () {
          //     Navigator.of(context).pop();
          //   },
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   selected: true,
          // ),

          // Container(
          //   // height: 300,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,

          //     children: [
          //       Container(
          //         // height: 50,
          //         // width: ,
          //         // : AppDefaultColors.colorPrimaryBlue[100],
          //         // alignment: Alignment.center,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(5),
          //           color: AppDefaultColors.colorPrimaryBlue[100],
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [

          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
