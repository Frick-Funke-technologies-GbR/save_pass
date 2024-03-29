import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:save_pass/models/classes/defaultcolors.dart';
import 'package:save_pass/models/resources/cache.dart';

class UserCard extends StatefulWidget {
  // final String username;
  // TODO: Add firstname is full name identifying functionallity (for google sign-in only)
  // const UserCard() : super();

  @override
  _UserCardState createState() => _UserCardState();
}

_getUserDataFromMap(dataTable, String identifier) {
  String? result = dataTable[identifier] as String?;
  result ??= '';
  return result;
}

class _UserCardState extends State<UserCard> {
  Future<Map<String?, String?>> getUserData() async {
    String? userIdent =
        await CacheHandler().getSecureStringFromCache('user_ident');
    String? userName =
        await CacheHandler().getSecureStringFromCache('user_name');
    print(userName);
    String? emailAddress =
        await CacheHandler().getSecureStringFromCache('email_address');
    String? firstName =
        await CacheHandler().getSecureStringFromCache('first_name');
    String? lastName =
        await CacheHandler().getSecureStringFromCache('last_name');
    Map<String, String?> userDataList = {};
    userDataList['user_ident'] = userIdent;
    userDataList['user_name'] = userName;
    userDataList['email_address'] = emailAddress;
    userDataList['first_name'] = firstName;
    userDataList['last_name'] = lastName;
    return userDataList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String?, String?>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return SizedBox(
              height: 200,
              width: 400,
              child: Center(
                  child: Text(snapshot.error
                      .toString()
                      .replaceAll('exception', 'error'))),
            );
          }
          if (snapshot.hasData) {
            return Card(
              elevation: 20,
              shadowColor: AppDefaultColors.colorPrimaryBlue,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: EdgeInsets.all(3),
                        child: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 20,
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                _getUserDataFromMap(snapshot.data, 'user_name'),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20, left: 15),
                              child: Text(
                                _getUserDataFromMap(
                                    snapshot.data, 'user_ident'),
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 13),
                          child: Text(
                            _getUserDataFromMap(snapshot.data, 'email_address'),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 10),
                          child: Icon(
                            Icons.mail_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 13),
                          child: Text(
                            _getUserDataFromMap(snapshot.data, 'first_name') +
                                ' ' +
                                _getUserDataFromMap(snapshot.data, 'last_name'),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 10),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: SizedBox(
              height: 200,
              width: 400,
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
