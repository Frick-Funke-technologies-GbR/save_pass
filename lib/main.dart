import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_pass/loginscreen.dart';
import 'package:save_pass/mainscreen.dart';
import 'package:save_pass/passwordscreen.dart';
import 'package:save_pass/settingsscreen.dart';
import 'package:save_pass/walletscreen.dart';
import 'package:save_pass/notificationsscreen.dart';

// void main() {
//   runApp(SavePass());
// }

void main() => runApp(SavePass());

class SavePass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      home: LoginScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      routes: <String, WidgetBuilder>{
        // "/mainscreen": (BuildContext context)=> new MainScreen(),
        "/newpasswordscreen": (BuildContext context)=> PasswordScreen(),
        "/passwordscreen": (BuildContext context)=> PasswordScreen(),
        "/settingsscreen": (BuildContext context)=> SettingsScreen(),
        "/walletscreen": (BuildContext context)=> WalletScreen(),
        // "/notificationsscreen": (BuildContext context)=> NotificationsScreen(),
      },
    );
  }
}


