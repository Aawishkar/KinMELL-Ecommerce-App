import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

Center backtoSignupButton(BuildContext context) {
  return Center(
    child: RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        children: <TextSpan>[
          const TextSpan(text: "Don't have an account? "),
          TextSpan(
              text: "SignUp",
              style: const TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/register-screen',
                    (route) => false,
                  );
                }),
        ],
      ),
    ),
  );
}
