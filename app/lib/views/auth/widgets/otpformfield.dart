import 'package:app/api/api_service.dart';
import 'package:app/config/config.dart';
import 'package:app/constants/globalvariable.dart';
import 'package:app/utils/keyboard.dart';
import 'package:app/views/auth/screens/resetPassword.dart';
import 'package:app/views/auth/services/singupprovider.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../screens/login.dart';

class OTPForm extends StatefulWidget {
  final String? hash;
  final bool isregisterScreen;
  final SignUpModal value;
  const OTPForm({
    required this.value,
    required this.hash,
    required this.isregisterScreen,
    super.key,
  });

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  FocusNode? pin1FocusNode;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  String pin = '';
  bool isAsyncCallProcess = false;
  @override
  void initState() {
    super.initState();

    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin1FocusNode!.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    pin = pin + value;
    if (value.length == 1 && focusNode != pin1FocusNode) {
      focusNode!.requestFocus();
    } else if (value.length == 1) {
      focusNode!.unfocus();
      KeyboardUtil.hideKeyboard(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: GlobalVariables.screenHeight * 0.15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            pinField(pin1FocusNode, pin2FocusNode),
            pinField(pin2FocusNode, pin3FocusNode),
            pinField(pin3FocusNode, pin4FocusNode),
            pinField(pin4FocusNode, pin1FocusNode),
          ],
        ),
        SizedBox(
          height: GlobalVariables.screenHeight * 0.15,
        ),
        isAsyncCallProcess
            ? SizedBox(
                width: double.infinity,
                height: getProportionateScreenHeight(56),
                child: ProgressHUD(
                  key: UniqueKey(),
                  inAsyncCall: isAsyncCallProcess,
                  child: Container(),
                ))
            : SizedBox(
                width: double.infinity,
                height: getProportionateScreenHeight(56),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      isAsyncCallProcess = true;
                    });
                    APIService.otpVerify(widget.value.email!, widget.hash!, pin)
                        .then((response) {
                      if (response["data"] != "Invalid OTP") {
                        widget.isregisterScreen
                            ? APIService.signup(
                                widget.value.name!,
                                widget.value.email!,
                                widget.value.password!,
                              ).then(
                                (response) {
                                  setState(() {
                                    isAsyncCallProcess = false;
                                  });

                                  if (response) {
                                    FormHelper.showSimpleAlertDialog(
                                        context,
                                        Config.appName,
                                        "Registration Successful",
                                        'OK', () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        LoginPage.routeName,
                                        (route) => false,
                                      );
                                    });
                                  } else {
                                    FormHelper.showSimpleAlertDialog(
                                        context,
                                        Config.appName,
                                        "This Email already registered",
                                        'OK', () {
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                              )
                            : Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        ResetPassword(
                                          modal: widget.value,
                                        )),
                                (route) => false);
                      } else {
                        FormHelper.showSimpleAlertDialog(
                            context,
                            Config.appName,
                            "OTP Verification Failed",
                            'OK', () {
                          setState(() {
                            isAsyncCallProcess = false;
                          });
                          Navigator.pop(context);
                        });
                      }
                    });
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  SizedBox pinField(
    FocusNode? pinFocusNode,
    FocusNode? nextFocusNode,
  ) {
    return SizedBox(
      width: getProportionateScreenWidth(60),
      child: TextFormField(
        focusNode: pinFocusNode,
        autofocus: false,
        style: const TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(15)),
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(15)),
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenWidth(15)),
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
        ),
        onChanged: ((value) {
          nextField(value, nextFocusNode);
        }),
      ),
    );
  }
}
