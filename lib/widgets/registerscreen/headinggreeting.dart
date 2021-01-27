import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';
import 'package:save_pass/widgets/uni/toplabel.dart';

class HeadingGreetingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 100),
            child: Text(
              'Welcome to',
              style: GoogleFonts.oxygen(
                fontWeight: FontWeight.w900,
                color: AppDefaultColors.colorPrimaryGrey[500],
                fontSize: 20,
              ),
            ),
          ),
          Toplabel()
        ],
      ),
    );
  }
}
