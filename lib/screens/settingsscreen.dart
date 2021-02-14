import 'package:flutter/material.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';
import 'package:save_pass/widgets/uni/usercard.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dark = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _dark ? null : Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          // brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? AppDefaultColors.colorPrimaryBlue : Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: _dark ? AppDefaultColors.colorPrimaryBlue : Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.nightlight_round, color: AppDefaultColors.colorPrimaryBlue,),
              onPressed: () {
                setState(() {
                  _dark = !_dark;
                });
              },
            )
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UserCard(),
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline_rounded,
                            color: AppDefaultColors.colorPrimaryBlue,
                          ),
                          title: Text("Change password"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change password
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: AppDefaultColors.colorPrimaryBlue,
                          ),
                          title: Text("Log out"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change location
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.delete_outline_rounded,
                            color: AppDefaultColors.colorPrimaryRed,
                          ),
                          title: Text("Delete account"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change language
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Data settings",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: AppDefaultColors.colorPrimaryBlue,
                    ),
                  ),
                  SwitchListTile(
                    activeColor: AppDefaultColors.colorPrimaryBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: false,
                    title: Text("Cloud sync"),
                    onChanged: null,
                  ),
                  // SwitchListTile(
                  //   activeColor: AppDefaultColors.colorPrimaryBlue,
                  //   contentPadding: const EdgeInsets.all(0),
                  //   value: false,
                  //   title: Text("Received newsletter"),
                  //   onChanged: null,
                  // ),
                  // SwitchListTile(
                  //   activeColor: AppDefaultColors.colorPrimaryBlue,
                  //   contentPadding: const EdgeInsets.all(0),
                  //   value: true,
                  //   title: Text("Received Offer Notification"),
                  //   onChanged: (val) {},
                  // ),
                  // SwitchListTile(
                  //   activeColor: AppDefaultColors.colorPrimaryBlue,
                  //   contentPadding: const EdgeInsets.all(0),
                  //   value: true,
                  //   title: Text("Received App Updates"),
                  //   onChanged: null,
                  // ),
                  // const SizedBox(height: 60.0),
                ],
              ),
            ),
          ],
        ),
      );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
