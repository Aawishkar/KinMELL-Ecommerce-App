import 'package:flutter/material.dart';

class NotificationTiles extends StatelessWidget {
  final String title, subtitile, image;
  final VoidCallback tap;

  const NotificationTiles({
    Key? key,
    required this.title,
    required this.subtitile,
    required this.image,
    required this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
      ),
      title: Text(title, style: const TextStyle(color: Colors.black)),
      subtitle: Text(subtitile, style: const TextStyle(color: Colors.black54)),
      onTap: tap,
      enabled: true,
    );
  }
}
