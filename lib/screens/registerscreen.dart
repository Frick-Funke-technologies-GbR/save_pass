import 'package:flutter/material.dart';
import 'package:save_pass/widgets/registerscreen/headinggreeting.dart';
import 'package:save_pass/widgets/registerscreen/registerlogininput.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        top: true,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [HeadingGreetingWidget()],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [RegisterLoginInputWidget()],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
