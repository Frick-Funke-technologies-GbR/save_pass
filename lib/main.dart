import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_pass/screens/loginscreen.dart';
import 'package:save_pass/screens/mainscreen.dart';
import 'package:save_pass/screens/passwordscreen.dart';
import 'package:save_pass/screens/registerscreen.dart';
import 'package:save_pass/screens/settingsscreen.dart';
import 'package:save_pass/screens/walletscreen.dart';
import 'package:save_pass/screens/notificationsscreen.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';

// void main() {
//   runApp(SavePass());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("settings");
  runApp(SavePass());
}

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
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      theme: ThemeData(primarySwatch: AppDefaultColors.colorPrimaryBlue),
      darkTheme: ThemeData.dark(),
      routes: <String, WidgetBuilder> {
        // "/mainscreen": (BuildContext context) => new MainScreen(),
        "/newpasswordscreen": (BuildContext context) => PasswordScreen(),
        "/passwordscreen": (BuildContext context) => PasswordScreen(),
        "/settingsscreen": (BuildContext context) => SettingsScreen(),
        "/walletscreen": (BuildContext context) => WalletScreen(),
        "/registerscreen": (BuildContext context) => RegisterScreen(),
        // "/notificationsscreen": (BuildContext context) => NotificationsScreen(),
      },
    );
  }
}
