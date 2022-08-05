import 'package:flutter/material.dart';
import 'package:save_pass/screens/loginscreen.dart';
import 'package:save_pass/screens/passwordscreen.dart';
import 'package:save_pass/screens/registerscreen.dart';
import 'package:save_pass/screens/settingsscreen.dart';
import 'package:save_pass/screens/walletscreen.dart';
import 'package:save_pass/screens/notificationsscreen.dart';

Map<String, WidgetBuilder> get routes {
  return <String, WidgetBuilder>{
    // "/mainscreen": (BuildContext context) => new MainScreen(),
    '/loginscreen': (BuildContext context) => LoginScreen(),
    '/newpasswordscreen': (BuildContext context) => PasswordScreen(),
    '/passwordscreen': (BuildContext context) => PasswordScreen(),
    '/settingsscreen': (BuildContext context) => SettingsScreen(),
    '/walletscreen': (BuildContext context) => WalletScreen(),
    '/registerscreen': (BuildContext context) => RegisterScreen(),
    '/notificationsscreen': (BuildContext context) => NotificationsScreen(),
  };
}
