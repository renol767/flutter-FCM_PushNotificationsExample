import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NotificationPage());
  }
}

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  FirebaseMessaging fm = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    fm.getToken().then((value) => print("token : $value"));
    fm.configure(
      onMessage: (message) async {
        fm.requestNotificationPermissions(const IosNotificationSettings(
            sound: true, badge: true, alert: true));
        print(message);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    content: ListTile(
                  title: Text(message['notification']['title']),
                  subtitle: Text(message['notification']['body']),
                )));
      },
      onLaunch: (message) async {
        print(message);
      },
      onResume: (message) async {
        print(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Test"),
      ),
    );
  }
}
