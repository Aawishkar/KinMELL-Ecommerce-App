import 'dart:io';

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imgPath;
  final VoidCallback onClicked;
  final bool isEdit;
  const ProfileWidget(
      {Key? key,
      required this.imgPath,
      this.isEdit = false,
      required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.blue;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(bottom: 0, right: 4, child: buildEditIcon(color)),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = imgPath.contains('assets/')
        ? AssetImage(imgPath)
        : FileImage(File(imgPath));

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 110,
          height: 110,
          child: GestureDetector(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          color: color,
          child: child,
          padding: EdgeInsets.all(all),
        ),
      );
}
