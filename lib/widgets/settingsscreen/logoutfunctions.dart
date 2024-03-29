import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'package:save_pass/models/resources/backup.dart';
import 'package:save_pass/models/resources/database.dart';

void showLogOutDialog(BuildContext context) async {
  Directory? storageDirectory = await CacheHandler().getStorageDirectory();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text('Log out?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Your data will be saved as a backup, so if you want to log in again, you will need to import this backup using your master-password.\n',
                        overflow: TextOverflow.visible,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'To export the data, the Backup will be available under: \n\n',
                            ),
                            TextSpan(
                                style: TextStyle(
                                  color: AppDefaultColors.colorPrimaryBlue,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Clipboard.setData(ClipboardData(
                                        text: storageDirectory!.path));
                                  },
                                text:
                                    '${storageDirectory!.path} (Tap to copy)\n\n'),
                            TextSpan(
                              text:
                                  '(It is not recommendet to handle the backup manually. You will be able to import the data from the settings menu later.)\n\nIf you have cloud sync eneabled, your data will stay in the cloud.',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          ButtonBar(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: AppDefaultColors.colorPrimaryGrey,
                  ),
                ),
                onPressed: Navigator.of(context).pop,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppDefaultColors.colorPrimaryRed,
                ),
                child: Text(
                  'Log out',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  bool errorOccured = !(await _createBackup());
                  if (await _requestStoragePermission(Permission.storage) &&
                      !errorOccured) {
                    // _createBackup(storageDirectory);
                    _localLogout();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/registerscreen',
                        (route) => false); // close all previous routes
                    // TODO: Delete all Data except the backup, figure out, how to get to Register-screen
                  } else {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: errorOccured
                                        ? 'Unfortunately, an error occured during backup process.\n\n'
                                        : '',
                                    style: TextStyle(
                                        color:
                                            AppDefaultColors.colorPrimaryRed)),
                                TextSpan(
                                  text:
                                      'Do you want to continue without a backup creation? In case, you did\'t have cloud sync turned on, ',
                                ),
                                TextSpan(
                                  text: 'All your data will be lost!',
                                  style: TextStyle(
                                    color: AppDefaultColors.colorPrimaryRed,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            ButtonBar(
                              children: [
                                TextButton(
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color:
                                            AppDefaultColors.colorPrimaryGrey,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        AppDefaultColors.colorPrimaryRed,
                                  ),
                                  child: Text(
                                    'Continue',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    _localLogout();
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                        '/registerscreen',
                                        (route) =>
                                            false); // close all previous routes
                                    // TODO: Add logout process
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<bool> _createBackup() async {
  bool success = await Backup().backupData();
  return success;
}

Future<bool> _localLogout() async {
  CacheHandler cache = CacheHandler();
  DatabaseHandler db = DatabaseHandler();

  try {
    // clear most important cache entries
    await cache.removeFromCache('master_password');
    await cache.removeFromCache('user_name');
    await cache.removeFromCache('user_ident');
    await cache.removeFromCache('first_name');
    await cache.removeFromCache('last_name');
    await cache.removeFromCache('email_address');

    //clear all data stores in db
    await db.deleteAllPasswordEntries();

    return true;
  } catch (exception) {
    print(
        '[DEBUG] exception occured during local logout: ${exception.toString()}');
    return false;
  }
}

Future<bool> _requestStoragePermission(Permission permission) async {
  if (await permission.isGranted) {
    print('Permission already granted');
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      print('Permission granted');
      return true;
    }
  }
  print('Permission denied');
  return false;
}
