import 'package:flutter/material.dart';

class PasswordEntry extends StatelessWidget {
  final String storedaddress;
  final String storedusername;
  final String storedpassword;
  final String storednotes;

  const PasswordEntry(
    this.storedaddress,
    this.storedusername,
    this.storedpassword,
    this.storednotes,
  );
  // const PasswordEntry(this.storedusername);
  // PasswordEntry(this.storedaddress);
  // PasswordEntry(this.storednotes);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 22,
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue[200],
        boxShadow: [
          BoxShadow(
            color: Colors.blue[100],
            blurRadius: 7,
            offset: Offset(2, 2),
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(vertical: 8),
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
                storedaddress,
                style: TextStyle(
                  color: Colors.blue,
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
                    // color: Colors.yellow,
                    height: 50,
                    width: 140,
                    margin: EdgeInsets.only(
                      // right: 10,
                      // left: 10,
                      bottom: 8,
                    ),
                    alignment: Alignment.center,
                    // padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.yellow[100],
                    ),
                    child: Text(storednotes),
                  ),
                  Container(
                    height: 50,
                    width: 140,
                    margin: EdgeInsets.only(
                      // left: 10,
                      bottom: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
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
                                  content: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[100],
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.yellow[500],
                                        width: 2,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      storedpassword,
                                      style: TextStyle(color: Colors.grey[800]),
                                    ),
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
            ],
          ),
        ],
      ),
    );
  }
}

class DeletePasswordEntryDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Move to bin?'),
      content: Text('The entry will only be available for 30 days'),
      actions: [
        FlatButton(
          onPressed: null,
          child: Text(
            'No',
            style: TextStyle(color: Colors.red),
          ),
        ),
        FlatButton(
          onPressed: null,
          child: Text(
            'No',
            // style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}