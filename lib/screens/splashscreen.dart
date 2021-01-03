import 'package:flutter/material.dart';
import 'package:save_pass/widgets/toplabel.dart';

class StartupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      
      child: Center(
        child: ToplabelStartup()
      ),
    );
  }
}