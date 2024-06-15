// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppButtons extends StatelessWidget {
  double size;
  final Color color;
  String? text;
  IconData? icon;
  final Color backgroundColor;
  final Color bordercolor;
  bool? isIcon;
  AppButtons({
    required this.size,
    Key? key,
    this.text,
    this.icon,
    required this.color,
    required this.backgroundColor,
    required this.bordercolor,
    this.isIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          border: Border.all(
            color: bordercolor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15),
          color: Colors.black),
      child: isIcon == false
          ? Center(
              child: Text(
                text!,
                style: TextStyle(color: Colors.black),
              ),
            )
          : Icon(
              icon,
              color: color,
            ),
    );
  }
}
