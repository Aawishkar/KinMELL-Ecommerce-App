import 'package:app/views/home/screens/homepage.dart';
import 'package:flutter/material.dart';

import '../widgets/notification_tiles.dart';

class Notifications extends StatefulWidget {
  static const String routeName = '/Notificationpage-screen';
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: BackButton(onPressed: () => movetoHomepage()),
      ),
      body: ListView.separated(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 10,
          itemBuilder: (context, index) {
            return NotificationTiles(
                title: 'Kinmel',
                subtitile: 'Thanks for using our app',
                image: 'assets/images/kinmell_2.png',
                tap: () =>
                    movetoHomepage() // Change homepage to a new notification page
                );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          }),
    );
  }

  movetoHomepage() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
  }
}
