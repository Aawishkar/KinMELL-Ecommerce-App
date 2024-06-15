import 'package:app/utils/user_preference.dart';
import 'package:app/views/home/screens/edit_profile_page.dart';
import 'package:app/views/home/widgets/appbar_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../models/user/User-Profile.dart';
import '../widgets/profile_widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferance.getUser();
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imgPath: user.imgPath,
            onClicked: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
              setState(() {});
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 48),
          buildAbout(user),
        ],
      ),
    );
  }
}

Widget buildName(User_Profile user) => Column(
      children: [
        Text(
          user.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          user.contact,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          user.location,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );

Widget buildAbout(User_Profile user) => Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, height: 1.5),
          ),
          const SizedBox(height: 16),
          Text(
            user.about, // this data is taken from util/user_preference
            style: TextStyle(fontSize: 16, height: 1.4),
          )
        ],
      ),
    );
