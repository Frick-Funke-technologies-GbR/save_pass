import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:save_pass/models/classes/defaultcolors.dart';
import 'package:save_pass/models/resources/api.dart';
import 'package:save_pass/models/resources/cache.dart';
import 'package:save_pass/models/resources/database.dart';

class PasswordEntry extends StatefulWidget {
  // TODO: Add recursive color change, remember notes icon

  final int passwordId;
  final String storedwebadress;
  final String storedalias;
  final String storedusername;
  final String storedpassword;
  final String storednotes;
  final String storedThumbnail;
  // final _passwordShowTimeIndicator = GlobalKey<FormState>();

  const PasswordEntry(
    this.passwordId,
    this.storedwebadress,
    this.storedalias,
    this.storedusername,
    this.storedpassword,
    this.storednotes,
    this.storedThumbnail,
  );

  @override
  _PasswordEntryState createState() => _PasswordEntryState();
}

class _PasswordEntryState extends State<PasswordEntry> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(
      dividerColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );

    // Color _lightBlue = randombBlueTone();

    Color blueHue = UniqueColorGenerator.getColor();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        // color: blueHue.withAlpha(255),
        color: Colors.transparent,
        boxShadow: [
          // BoxShadow(
          //   color: blueHue.withAlpha(255),
          //   blurRadius: 7,
          //   spreadRadius: 2,
          //   // offset: Offset(2, 2),
          // ),
          // BoxShadow(
          //   color: AppDefaultColors.colorPrimaryGrey.withOpacity(0.5),
          //   spreadRadius: 2.5,
          //   blurRadius: 5,
          //   offset: Offset(0, 2), // changes position of shadow
          // ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Theme(
        data: theme,
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(vertical: 1),

          // initiallyExpanded: true,
          // leading: Checkbox(value: false, onChanged: null),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.baseline,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Icon(
                  //   Icons.vpn_key,
                  //   color: AppDefaultColors.colorPrimaryBlue,
                  // ),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    // child: Image.asset('assets/save_pass_icon_placeholder.png'),
                    // backgroundImage: NetworkImage(randInt() == 1
                    //     ? 'https://www.googlewatchblog.de/wp-content/uploads/google-icon-logo.jpg'
                    //     : randInt() == 2
                    //         ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/600px-Facebook_Logo_%282019%29.png'
                    //         : 'https://upload.wikimedia.org/wikipedia/de/thumb/9/9f/Twitter_bird_logo_2012.svg/300px-Twitter_bird_logo_2012.svg.png'),
                    child: widget.storedThumbnail != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            // decoration: BoxDecoration(
                            //   color: Colors.white,
                            //   borderRadius: BorderRadius.circular(5),
                            // ),
                            child: Image.memory(
                              base64Decode(widget.storedThumbnail),
                            ),
                          )
                        : Image.asset('assets/save_pass_icon_placeholder.png'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // color: AppDefaultColors.colorPrimaryGrey[200],
                    ),
                    constraints: BoxConstraints(
                      maxWidth: 228,
                      maxHeight: 40,
                    ),
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    // alignment: Alignment.bottomLeft,
                    // constraints: BoxConstraints(maxWidth: 300, maxHeight: 26),
                    child: OverflowBox(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.storedalias,
                        // maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          // color: _lightBlue.withOpacity(1),
                          // color: blueHue.withGreen(250).withRed(250),
                          // color: Colors.white,
                          // color: AppDefaultColors.colorPrimaryGrey[700],
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          children: <Widget>[
            Column(
              // mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 50,
                      width: 172,
                      margin: EdgeInsets.only(
                        right: 4,
                        // left: 10,
                        bottom: 8,
                      ),
                      alignment: Alignment.center,
                      // padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        // color: Colors.deepOrange[50],
                        color: AppDefaultColors.colorPrimaryGrey[50],
                      ),
                      padding: EdgeInsets.all(5),
                      child: Text(
                        widget.storedusername == ''
                            ? 'no username'
                            : widget.storedusername,
                        overflow: TextOverflow.fade,
                        style:
                            TextStyle(color: AppDefaultColors.colorPrimaryBlue),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 172,
                      margin: EdgeInsets.only(
                        left: 4,
                        bottom: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppDefaultColors.colorPrimaryBlue[50],
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
                                            //         AppDefaultColors.colorPrimaryGrey.withOpacity(0.5),
                                            //     spreadRadius: 2.5,
                                            //     blurRadius: 5,
                                            //     offset: Offset(0, 2),
                                            //   )
                                            // ],

                                            // border: Border.all(
                                            //   color: AppDefaultColors.colorPrimaryGrey[300],
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
                                                constraints: BoxConstraints(
                                                    minWidth: 500),
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  // color: Colors.yellow[100],
                                                  color: AppDefaultColors
                                                      .colorPrimaryGrey[50],
                                                  // border: Border.all(
                                                  //   color: AppDefaultColors.colorPrimaryGrey[300],
                                                  // ),
                                                ),
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: 'password: ',
                                                    style: GoogleFonts.firaCode(
                                                      color: AppDefaultColors
                                                              .colorPrimaryGrey[
                                                          800],
                                                      // color: Colors.yellow[700],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        style: GoogleFonts
                                                            .firaCode(
                                                                color: Colors
                                                                    .blue),
                                                        text: widget.storedpassword ==
                                                                ''
                                                            ? 'no password'
                                                            : widget
                                                                .storedpassword,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                height: 20,
                                                color: AppDefaultColors
                                                    .colorPrimaryGrey,
                                              ),
                                              Container(
                                                constraints: BoxConstraints(
                                                    minWidth: 500),
                                                padding: EdgeInsets.all(5),
                                                margin:
                                                    EdgeInsets.only(bottom: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  // color: Colors.yellow[100],
                                                  color: AppDefaultColors
                                                      .colorPrimaryGrey[50],
                                                  // border: Border.all(
                                                  //   color: AppDefaultColors.colorPrimaryGrey[300],
                                                  // ),
                                                ),
                                                child: RichText(
                                                  // textAlign: TextAlign.left,
                                                  softWrap: true,
                                                  text: TextSpan(
                                                    text: 'url: ',
                                                    style: GoogleFonts.firaCode(
                                                      color: AppDefaultColors
                                                              .colorPrimaryGrey[
                                                          800],
                                                      // color: Colors.yellow[700],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        style: GoogleFonts
                                                            .firaCode(
                                                                color: Colors
                                                                    .blue),
                                                        text: widget.storedwebadress ==
                                                                ''
                                                            ? 'no url'
                                                            : widget
                                                                .storedwebadress,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                constraints: BoxConstraints(
                                                    minWidth: 500),
                                                padding: EdgeInsets.all(5),
                                                margin:
                                                    EdgeInsets.only(bottom: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  // color: Colors.yellow[100],
                                                  color: AppDefaultColors
                                                      .colorPrimaryGrey[50],
                                                  // border: Border.all(
                                                  //   color: AppDefaultColors.colorPrimaryGrey[300],
                                                  // ),
                                                ),
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: 'username: ',
                                                    style: GoogleFonts.firaCode(
                                                      color: AppDefaultColors
                                                              .colorPrimaryGrey[
                                                          800],
                                                      // color: Colors.yellow[700],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        style: GoogleFonts
                                                            .firaCode(
                                                                color: Colors
                                                                    .blue),
                                                        text: widget.storedusername ==
                                                                ''
                                                            ? 'no username'
                                                            : widget
                                                                .storedusername,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            child: LinearProgressIndicator(
                                              value:
                                                  1, // Double beond one, work with Duration()
                                              minHeight: 7,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                Colors.transparent),
                                        child: Text(
                                          'Close',
                                          style: TextStyle(
                                              color: AppDefaultColors
                                                  .colorPrimaryBlue),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              color: AppDefaultColors.colorPrimaryBlue,
                            ),
                          ),
                          Container(
                            width: 40,
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
                              icon: Icon(Icons.content_copy),
                              onPressed: () {
                                Clipboard.setData(
                                  new ClipboardData(
                                      text: widget.storedpassword),
                                );
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Password copied to clipboard.'),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor:
                                        AppDefaultColors.colorPrimaryGrey[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              color: AppDefaultColors.colorPrimaryBlue,
                            ),
                          ),
                          Container(
                            width: 40,
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              color: AppDefaultColors.colorPrimaryBlue,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (_) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // title: Text('Move to bin?'),
                                    title: Text('Delete?'),
                                    // content: Text(
                                    //     'The entry will only be available for 30 days'),
                                    content:
                                        Text('The data can not be recovered.'),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                Colors.transparent),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'No',
                                          style: TextStyle(
                                              color: AppDefaultColors
                                                  .colorPrimaryBlue),
                                        ),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                        ),
                                        onPressed: () async {
                                          bool result;
                                          String exc;
                                          try {
                                            // result = await ApiProvider()
                                            //     .deleteUserPasswordEntry(
                                            //   widget.passwordId,
                                            //   false,
                                            //   await CacheHandler()
                                            //       .getSecureStringFromCache(
                                            //           'user_ident'),
                                            //   await CacheHandler()
                                            //       .getSecureStringFromCache(
                                            //           'master_password'),
                                            // );
                                            await DatabaseHandler()
                                                .deletePasswordEntry(
                                                    widget.passwordId);
                                            result = true;
                                          } catch (e) {
                                            result = false;
                                            exc = e;
                                          } finally {
                                            Navigator.of(context)
                                                .popAndPushNamed(
                                                    '/passwordscreen');
                                            Scaffold.of(context).showSnackBar(
                                              // TODO: Add screen reload here
                                              SnackBar(
                                                content: Text(result
                                                    ? 'deleted sucessfully'
                                                    : exc),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    AppDefaultColors
                                                        .colorPrimaryGrey[800],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: AppDefaultColors
                                                  .colorPrimaryRed),
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
                widget.storednotes == ''
                    ? Container()
                    : Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.yellow[50],
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
                                    color:
                                        AppDefaultColors.colorPrimaryBlue[200],
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
                                    widget.storednotes == ''
                                        ? 'no notes'
                                        : widget.storednotes,
                                    // textHeightBehavior: TextHeightBehavior(
                                    //   applyHeightToLastDescent: true,
                                    //   applyHeightToFirstAscent: true,
                                    // ),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppDefaultColors
                                          .colorPrimaryGrey[900],
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
//             style: TextStyle(color: AppDefaultColors.colorPrimaryRed),
//           ),
//         ),
//         FlatButton(
//           onPressed: null,
//           child: Text(
//             'No',
//             // style: TextStyle(color: AppDefaultColors.colorPrimaryRed),
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
