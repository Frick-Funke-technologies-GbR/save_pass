import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:random_color/random_color.dart';

class PasswordEntry extends StatelessWidget {
  // TODO: Add recursive color change, remember notes icon

  final int passwordId;
  final String storedwebadress;
  final String storedalias;
  final String storedusername;
  final String storedpassword;
  final String storednotes;
  // final _passwordShowTimeIndicator = GlobalKey<FormState>();

  const PasswordEntry(
    this.passwordId,
    this.storedwebadress,
    this.storedalias,
    this.storedusername,
    this.storedpassword,
    this.storednotes,
  );

  // Color randombBlueTone() {
  //   RandomColor _randomColor = RandomColor();
  //   Color blueTone = _randomColor.randomColor(
  //     colorHue: ColorHue.custom(Range(200, 225)),
  //     colorBrightness: ColorBrightness.random,
  //     // colorSaturation: ColorSaturation.highSaturation,
  //   );
  //   return blueTone;
  // }

  // const PasswordEntry(this.storedusername);
  // PasswordEntry(this.storedalias);
  // PasswordEntry(this.storednotes);
  @override
  Widget build(BuildContext context) {
    // Color _lightBlue = randombBlueTone();

    Color blueHue = UniqueColorGenerator.getColor();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 22,
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        // color: blueHue.withAlpha(255),
        color: Colors.white,
        boxShadow: [
          // BoxShadow(
          //   color: blueHue.withAlpha(255),
          //   blurRadius: 7,
          //   spreadRadius: 2,
          //   // offset: Offset(2, 2),
          // ),
          // BoxShadow(
          //   color: Colors.grey.withOpacity(0.5),
          //   spreadRadius: 2.5,
          //   blurRadius: 5,
          //   offset: Offset(0, 2), // changes position of shadow
          // ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(vertical: 8),

        // initiallyExpanded: true,
        // leading: Checkbox(value: false, onChanged: null),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Icon(
            //   Icons.vpn_key,
            //   color: Colors.blue,
            // ),
            CircleAvatar(
              backgroundColor: Colors.blue[200],
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                storedalias,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  // color: _lightBlue.withOpacity(1),
                  // color: blueHue.withGreen(250).withRed(250),
                  // color: Colors.white,
                  color: Colors.grey[300],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        children: <Widget>[
          Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 149,
                    margin: EdgeInsets.only(
                      // right: 10,
                      // left: 10,
                      bottom: 8,
                    ),
                    alignment: Alignment.center,
                    // padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.deepOrange[50],
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      storedusername,
                      overflow: TextOverflow.fade,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 149,
                    margin: EdgeInsets.only(
                      // left: 10,
                      bottom: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue[50],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 40,
                          // margin: EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Show password'),
                                  // TODO: Add time indicator!
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        // height: 50,
                                        decoration: BoxDecoration(
                                          // color: Colors.yellow[200],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color:
                                          //         Colors.grey.withOpacity(0.5),
                                          //     spreadRadius: 2.5,
                                          //     blurRadius: 5,
                                          //     offset: Offset(0, 2),
                                          //   )
                                          // ],

                                          // border: Border.all(
                                          //   color: Colors.grey[300],
                                          //   // width: 2,
                                          // ),
                                        ),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          // mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(minWidth: 500),
                                              padding: EdgeInsets.all(5),
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                // color: Colors.yellow[100],
                                                color: Colors.grey[200],
                                                // border: Border.all(
                                                //   color: Colors.grey[300],
                                                // ),
                                              ),
                                              child: RichText(
                                                // textAlign: TextAlign.left,
                                                softWrap: true,
                                                text: TextSpan(
                                                  text: 'webadress: ',
                                                  style: GoogleFonts.firaCode(
                                                    color: Colors.grey[500],
                                                    // color: Colors.yellow[700],
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      style:
                                                          GoogleFonts.firaCode(
                                                              color:
                                                                  Colors.blue),
                                                      text: storedwebadress,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              constraints:
                                                  BoxConstraints(minWidth: 500),
                                              padding: EdgeInsets.all(5),
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                // color: Colors.yellow[100],
                                                color: Colors.grey[200],
                                                // border: Border.all(
                                                //   color: Colors.grey[300],
                                                // ),
                                              ),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'username: ',
                                                  style: GoogleFonts.firaCode(
                                                    color: Colors.grey[500],
                                                    // color: Colors.yellow[700],
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      style:
                                                          GoogleFonts.firaCode(
                                                              color:
                                                                  Colors.blue),
                                                      text: storedusername,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              constraints:
                                                  BoxConstraints(minWidth: 500),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                // color: Colors.yellow[100],
                                                color: Colors.grey[200],
                                                // border: Border.all(
                                                //   color: Colors.grey[300],
                                                // ),
                                              ),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'password: ',
                                                  style: GoogleFonts.firaCode(
                                                    color: Colors.grey[500],
                                                    // color: Colors.yellow[700],
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      style:
                                                          GoogleFonts.firaCode(
                                                              color:
                                                                  Colors.blue),
                                                      text: storedpassword,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          child: LinearProgressIndicator(
                                            value: 1, // Double beond one
                                            minHeight: 7,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    FlatButton(
                                      child: Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          width: 40,
                          // margin: EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                            icon: Icon(Icons.content_copy),
                            onPressed: () {
                              Clipboard.setData(
                                new ClipboardData(text: storedpassword),
                              );
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Password copied to clipboard.'),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.grey[800],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              );
                            },
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          width: 40,
                          // margin: EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.blue,
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (_) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  title: Text('Move to bin?'),
                                  content: Text(
                                      'The entry will only be available for 30 days'),
                                  actions: [
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'No',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: null,
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.yellow[100],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 25,
                            left: 2,
                          ),
                          child: Icon(
                            Icons.note,
                            color: Colors.blue[200],
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 282,
                            maxHeight: 50,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 4.25,
                            horizontal: 10,
                          ),
                          alignment: Alignment.topLeft,
                          child: Text(
                            storednotes,
                            // textHeightBehavior: TextHeightBehavior(
                            //   applyHeightToLastDescent: true,
                            //   applyHeightToFirstAscent: true,
                            // ),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class DeletePasswordEntryDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Move to bin?'),
//       content: Text('The entry will only be available for 30 days'),
//       actions: [
//         FlatButton(
//           onPressed: null,
//           child: Text(
//             'No',
//             style: TextStyle(color: Colors.red),
//           ),
//         ),
//         FlatButton(
//           onPressed: null,
//           child: Text(
//             'No',
//             // style: TextStyle(color: Colors.red),
//           ),
//         ),
//       ],
//     );
//   }
// }

class UniqueColorGenerator {
  static Random random = new Random();
  static Color getColor() {
    return Color.fromARGB(255, 0, random.nextInt(255), 255);
  }
}
