import 'package:flutter/material.dart';
import 'package:save_pass/widgets/registerscreen/headinggreeting.dart';
import 'package:save_pass/widgets/registerscreen/registerlogininput.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // TODO: Add background
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        top: true,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // TODO: change to 'Register.' widget to match the design specified in loginscreen
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
