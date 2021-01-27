import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';

import './toplabel.dart';

class ToplabelLogin extends StatelessWidget {
  // final String toplabelText;

  // Toplabel(this.toplabelText);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: AppDefaultColors.colorPrimaryGrey[400],
        //     blurRadius: 5,
        //     spreadRadius: 0,
        //     offset: Offset(3, 4),
        //   ),
        // ],
        // boxShadow: [
        //   BoxShadow(
        //     color: AppDefaultColors.colorPrimaryGrey[400],
        //     blurRadius: 7,
        //     spreadRadius: 1,
        //     // offset: Offset(3, 4),
        //   ),
        // ],

        // color: AppDefaultColors.colorPrimaryGrey[100],
        color: Colors.white,
        borderRadius: BorderRadius.all(
          const Radius.circular(10),
        ),
      ),
      // width: double.parse(),
      margin: EdgeInsets.only(top: 60, bottom: 120, left: 10),
      // alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(10),
      // width: 200,
      // height: 100,
      child: RichText(
        textWidthBasis: TextWidthBasis.longestLine,
        // textHeightBehavior: ,
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'L',
          style: GoogleFonts.oxygen(
              fontSize: 50, fontWeight: FontWeight.w900, color: AppDefaultColors.colorPrimaryRed),
          children: <TextSpan>[
            TextSpan(
              text: 'ogin',
          style: GoogleFonts.oxygen(
              fontSize: 50, fontWeight: FontWeight.w900, color: AppDefaultColors.colorPrimaryGrey[500]),
            ),
            TextSpan(
              text: '.',
          style: GoogleFonts.oxygen(
              fontSize: 50, fontWeight: FontWeight.w900, color: AppDefaultColors.colorPrimaryRed),
            ),
          ],
        ),
      ),
    );
  }
}

class ToplabelStartup extends StatelessWidget {
  // final String toplabelText;

  // Toplabel(this.toplabelText);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: AppDefaultColors.colorPrimaryGrey[400],
        //     blurRadius: 5,
        //     spreadRadius: 0,
        //     offset: Offset(3, 4),
        //   ),
        // ],
        color: AppDefaultColors.colorToplabelGrey,
        borderRadius: BorderRadius.all(
          const Radius.circular(10),
        ),
      ),
      // width: double.parse(),
      margin: EdgeInsets.only(top: 60, bottom: 120, left: 10),
      // alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(10),
      // width: 200,
      // height: 100,
      child: RichText(
        textWidthBasis: TextWidthBasis.longestLine,
        // textHeightBehavior: ,
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'S',
          style: GoogleFonts.oxygen(
              fontSize: 50, fontWeight: FontWeight.bold, color: AppDefaultColors.colorPrimaryRed),
          children: <TextSpan>[
            TextSpan(
              text: 'ave',
              style: GoogleFonts.oxygen(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: AppDefaultColors.colorPrimaryGrey[500]),
            ),
            TextSpan(
              text: 'P',
              style: GoogleFonts.oxygen(
                  fontSize: 50, fontWeight: FontWeight.bold, color: AppDefaultColors.colorPrimaryRed),
            ),
            TextSpan(
              text: 'ass',
              style: GoogleFonts.oxygen(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: AppDefaultColors.colorPrimaryGrey[500]),
            ),
            TextSpan(
              text: '.',
              style: GoogleFonts.oxygen(
                  fontSize: 50, fontWeight: FontWeight.bold, color: AppDefaultColors.colorPrimaryRed),
            ),
          ],
        ),
      ),
    );
  }
}

class Toplabel extends StatelessWidget {
  // final String toplabelText;

  // Toplabel(this.toplabelText);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: AppDefaultColors.colorPrimaryGrey[400],
        //     blurRadius: 7,
        //     spreadRadius: 1,
        //     // offset: Offset(3, 4),
        //   ),
        // ],
        color: AppDefaultColors.colorToplabelGrey,
        borderRadius: BorderRadius.all(
          const Radius.circular(10),
        ),
      ),
      // width: double.parse(),
      // margin: EdgeInsets.only(top: 60, bottom: 40, left: 10),
      // alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(10),
      // width: 200,
      // height: 100,
      child: RichText(
        textWidthBasis: TextWidthBasis.longestLine,
        // textHeightBehavior: ,
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'S',
          style: GoogleFonts.oxygen(
              fontSize: 50, fontWeight: FontWeight.w900, color: AppDefaultColors.colorPrimaryRed),
          children: <TextSpan>[
            TextSpan(
              text: 'ave',
              style: GoogleFonts.oxygen(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: AppDefaultColors.colorPrimaryGrey[500]),
            ),
            TextSpan(
              text: 'P',
              style: GoogleFonts.oxygen(
                  fontSize: 50, fontWeight: FontWeight.w900, color: AppDefaultColors.colorPrimaryRed),
            ),
            TextSpan(
              text: 'ass',
              style: GoogleFonts.oxygen(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: AppDefaultColors.colorPrimaryGrey[500]),
            ),
            TextSpan(
              text: '.',
              style: GoogleFonts.oxygen(
                  fontSize: 50, fontWeight: FontWeight.w900, color: AppDefaultColors.colorPrimaryRed),
            ),
          ],
        ),
      ),
    );
  }
}
