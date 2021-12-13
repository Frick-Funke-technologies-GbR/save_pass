import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'package:save_pass/models/resources/sync.dart';
import 'package:save_pass/widgets/settingsscreen/logoutfunctions.dart';
import 'package:save_pass/widgets/uni/usercard.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _dark = true;
  bool _showSyncProgressIndicator = false;

  Future<bool> _getSyncStatus() async {
    bool result = await CacheHandler().getBoolFromCache('sync_active');
    result ??= false;
    return result;
  }

  Future<bool> _syncronize(CacheHandler cache) async {
    bool success = false;
    try {
      success = await Sync().normalSync();
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppDefaultColors.colorPrimaryGrey,
          content: Text(
            e.toString(),
          ),
        ),
      );
      return success;
    }
    bool didSync = await cache.getBoolFromCache('did_send_to_cloud') ||
        await cache.getBoolFromCache('did_send_to_db');
    didSync ??= false;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: success
          ? AppDefaultColors.colorPrimaryGrey
          : AppDefaultColors.colorPrimaryRed,
      content: RichText(
        text: TextSpan(
          text: success
              ? didSync
                  ? 'Passwords successfully synced with our server'
                  : 'Passwords already up-to-date'
              : 'An error occured during syncronization process. Please try again later. Maybe you could try to ',
          children: [
            TextSpan(
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
              text: success ? '' : 'log in again',
              recognizer: TapGestureRecognizer()
                ..onTap = () {/*TODO: add login process*/},
            ),
          ],
        ),
      ),
    ));
    return success;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _dark ? null : Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        // brightness: _getBrightness(),
        iconTheme: IconThemeData(
            color: _dark ? AppDefaultColors.colorPrimaryBlue : Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings',
          style: TextStyle(
              color: _dark ? AppDefaultColors.colorPrimaryBlue : Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.nightlight_round,
              color: AppDefaultColors.colorPrimaryBlue,
            ),
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
                  elevation: 20,
                  shadowColor: AppDefaultColors.colorPrimaryGrey[200],
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
                          // TODO: Add change passwords function
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
                          showLogOutDialog(context);
                          // TODO: Add Log Out screen
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
                          // TODO: Add acount deletion function
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
                FutureBuilder(
                    future: _getSyncStatus(),
                    builder: (context, snapshot) {
                      bool syncStatus = snapshot.data;
                      syncStatus ??= false;
                      return Column(
                        children: [
                          SwitchListTile(
                            secondary: AnimatedCrossFade(
                              crossFadeState: _showSyncProgressIndicator
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: Duration(milliseconds: 20),
                              firstChild: TextButton(
                                child: Text('sync now'),
                                onPressed: syncStatus
                                    ? () async {
                                        setState(() {
                                          _showSyncProgressIndicator = true;
                                        });
                                        CacheHandler cache = CacheHandler();
                                        await _syncronize(cache);
                                        setState(() {
                                          _showSyncProgressIndicator = false;
                                        });
                                      }
                                    : null,
                              ),
                              secondChild: Container(
                                child: CircularProgressIndicator(),
                                padding: EdgeInsets.all(10),
                              ),
                            ),
                            // activeColor: AppDefaultColors.colorPrimaryBlue,
                            contentPadding: const EdgeInsets.only(
                                right: 15, left: 15, top: 20),
                            value: syncStatus,
                            title: Text("Cloud sync"),
                            onChanged: (switchState) async {
                              setState(() {
                                syncStatus = switchState;
                              });
                              CacheHandler cache = CacheHandler();
                              if (switchState) {
                                bool success = await _syncronize(cache);
                                cache.addBoolToCache(
                                    'sync_active', success ? true : false);
                                if (!success) {
                                  setState(() {
                                    syncStatus = false;
                                  });
                                }
                              } else {
                                cache.addBoolToCache('sync_active', false);
                              }
                            },
                          ),
                          FutureBuilder<Object>(
                              future: CacheHandler()
                                  .getBoolFromCache('sync_over_cellular'),
                              builder: (context, snapshot) {
                                bool cellularSyncActive = snapshot.data;
                                cellularSyncActive ??= false;
                                return SwitchListTile(
                                  title: Text('Sync over cellular'),
                                  value:
                                      syncStatus ? cellularSyncActive : false,
                                  onChanged: (switchState) async {
                                    await CacheHandler().addBoolToCache(
                                        'sync_over_cellular',
                                        switchState ? true : false);
                                    setState(() {
                                      cellularSyncActive = switchState;
                                    });
                                  },
                                );
                              })
                          // TODO: add an option to create backups in own file format
                          // TODO: add an option to import backups in own file format
                          // TODO: add an option to delete all backups (data privacy)
                        ],
                      );
                    }),
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
        horizontal: 20.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
