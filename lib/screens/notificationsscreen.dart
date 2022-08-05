import 'package:flutter/material.dart';
import 'package:save_pass/widgets/notificationsscreen/notification.dart';
// TODO: Add notifications screen (cloud-based) eg. to remind user to verificate their email

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationEntry(),
    );
  }
}

// class ChatEntry extends StatefulWidget {
//   @override
//   _ChatEntryState createState() => _ChatEntryState();
// }

// class _ChatEntryState extends State<ChatEntry> {
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       child: Stack(

//       ),
//     );
//   }
// }