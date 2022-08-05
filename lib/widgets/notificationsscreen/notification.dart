import 'package:flutter/material.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';

class NotificationEntry extends StatelessWidget {
  const NotificationEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppDefaultColors.colorPrimaryBlue,
      ),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
    );
  }
}
