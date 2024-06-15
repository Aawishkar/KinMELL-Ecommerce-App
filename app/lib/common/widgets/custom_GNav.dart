import 'package:app/views/upload/screens/uploagPage.dart';

import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

import '../../views/home/screens/searchpage.dart';

class CustomGNavBar extends StatefulWidget {
  const CustomGNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomGNavBar> createState() => _CustomGNavBarState();
}

class _CustomGNavBarState extends State<CustomGNavBar> {
  void movetoUpload() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(UploadScreen.routeName, (route) => false);
  }

  void movetoSearch() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(SearchPage.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return GNav(
      gap: 2,
      tabs: [
        GButton(
          icon: Icons.home,
          text: 'Home',
          onPressed: () {},
        ), //Add whatever icon we need for the project
        GButton(
          icon: Icons.search,
          text: 'Search',
          onPressed: () {
            movetoSearch();
          },
        ),
        GButton(
          icon: Icons.upload,
          text: 'Upload Product',
          onPressed: () {
            movetoUpload();
          },
        ),
        const GButton(icon: Icons.settings, text: 'Settings'),
      ],
    );
  }
}
