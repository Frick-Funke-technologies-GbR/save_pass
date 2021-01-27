import 'package:flutter/material.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';

class UserCard extends StatefulWidget {
  final String username;
  // TODO: Add firstname is full name identifying functionallity
  const UserCard({Key key, this.username}) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: AppDefaultColors.colorPrimaryBlue,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TODO: Add info, from UserClass
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.all(3),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 35,
                margin: EdgeInsets.only(left: 6), 
                child: Text(
                  widget.username,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}