import 'package:flutter/material.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'package:save_pass/screens/loginscreen.dart';
import 'package:save_pass/screens/registerscreen.dart';

FutureBuilder<bool> postSplashScreenBuilder() {
  return FutureBuilder(
    future: CacheHandler().getBoolFromCache('registered'),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Scaffold(backgroundColor: Colors.white);
      }
      if (snapshot.data == null || snapshot.data == true) {
        return RegisterScreen();
      } else {
        return LoginScreen();
      }
    },
  );
}
