import 'package:flutter/material.dart';
import 'package:save_pass/widgets/uni/overlayStyle.dart';
import 'package:save_pass/widgets/uni/postsplashscreen.dart';
import 'package:save_pass/widgets/uni/routes.dart';
import 'package:save_pass/widgets/uni/themedata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SavePass());
}

class SavePass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    overlayStyle();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: postSplashScreenBuilder(),
      theme: themeData(),
      darkTheme: ThemeData.dark(),
      routes: routes,
    );
  }
}
