import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        //     color: Colors.grey[400],
        //     blurRadius: 5,
        //     spreadRadius: 0,
        //     offset: Offset(3, 4),
        //   ),
        // ],
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey[400],
        //     blurRadius: 7,
        //     spreadRadius: 1,
        //     // offset: Offset(3, 4),
        //   ),
        // ],
        color: Colors.grey[100],
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
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
          children: <TextSpan>[
            TextSpan(
                text: 'ogin',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),),
            TextSpan(
                text: '.',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),),
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
        //     color: Colors.grey[400],
        //     blurRadius: 5,
        //     spreadRadius: 0,
        //     offset: Offset(3, 4),
        //   ),
        // ],
        color: Colors.grey[100],
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
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
          children: <TextSpan>[
            TextSpan(
                text: 'ave',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),),
            TextSpan(
                text: 'P',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                )),
            TextSpan(
                text: 'ass',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                )),
            TextSpan(
                text: '.',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),),
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
        //     color: Colors.grey[400],
        //     blurRadius: 7,
        //     spreadRadius: 1,
        //     // offset: Offset(3, 4),
        //   ),
        // ],
        color: Colors.grey[100],
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
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
          children: <TextSpan>[
            TextSpan(
                text: 'ave',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                )),
            TextSpan(
                text: 'P',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                )),
            TextSpan(
                text: 'ass',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                )),
            TextSpan(
                text: '.',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                )),
          ],
        ),
      ),
    );
  }
}
