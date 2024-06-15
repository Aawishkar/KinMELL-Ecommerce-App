import 'package:app/api/api_service.dart';
import 'package:app/constants/globalvariable.dart';
import 'package:app/utils/keyboard.dart';
import 'package:app/views/auth/widgets/otpformfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../services/singupprovider.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = '/otp-screen';
  final bool isregisterScreen;
  final String? hash;
  final SignUpModal modal;

  const OtpScreen({
    required this.isregisterScreen,
    required this.modal,
    required this.hash,
    super.key,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static bool showResendOTP = false;
  static bool isTimerRunning = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: body(),
    );
  }

  SizedBox body() {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SafeArea(
            child: otpFormScreen(),
          ),
        ),
      ),
    );
  }

  Column otpFormScreen() {
    return Column(
      children: [
        SizedBox(
          height: GlobalVariables.screenHeight * 0.05,
        ),
        Text(
          "OTP Verification",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(28),
            fontWeight: FontWeight.bold,
            color: Colors.black,
            height: 1.5,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            children: <TextSpan>[
              const TextSpan(text: "OTP sent to "),
              TextSpan(
                text: widget.modal.email,
                style: const TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(
                text: " check inbox/spam folder",
              ),
            ],
          ),
        ),
        SizedBox(
          height: GlobalVariables.screenHeight * 0.05,
        ),
        isTimerRunning ? showtime() : Container(),
        OTPForm(
          value: widget.modal,
          hash: widget.hash,
          isregisterScreen: widget.isregisterScreen,
        ),
        SizedBox(
          height: GlobalVariables.screenHeight * 0.1,
        ),
        showResendOTP
            ? RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: "Resend OTP?",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            APIService.otpSend(widget.modal.email!);
                            setState(() {
                              showResendOTP = false;
                              isTimerRunning = true;
                            });
                          }),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  // bool validateAndSave() {
  Row showtime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Resend OTP in '),
        TweenAnimationBuilder(
            tween: Tween(
              begin: 30.0,
              end: 0.0,
            ),
            onEnd: () {
              setState(() {
                showResendOTP = true;
                KeyboardUtil.hideKeyboard(context);
                isTimerRunning = false;
              });
            },
            duration: const Duration(seconds: 30),
            builder: (_, dynamic value, child) => Text("00:${value.toInt()}"))
      ],
    );
  }
}
