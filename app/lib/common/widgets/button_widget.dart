import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const ButtonWidget({Key? key, 
  required this.text, 
  required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)=> ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: StadiumBorder(),
      
      onPrimary: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 5)
    ),
    onPressed: onClicked,
     child:Text(text),
     );
}