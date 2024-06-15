import 'package:app/api/api_service.dart';
import 'package:app/config/config.dart';
import 'package:app/constants/globalvariable.dart';
import 'package:app/views/auth/services/singupprovider.dart';
import 'package:app/views/auth/widgets/backtopSignupButton.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class ResetPassword extends StatefulWidget {
  final SignUpModal modal;
  static const String routeName = '/resetPassword-screen';
  const ResetPassword({required this.modal, super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  static bool isAsynccall = false;
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? newpassword;
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  String? confirmnewPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ProgressHUD(
            inAsyncCall: isAsynccall,
            key: UniqueKey(),
            opacity: 0.3,
            child: Form(key: globalKey, child: Body())),
      ),
    );
  }

  SizedBox Body() {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                " Create Password",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(30),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    height: 1.5),
              ),
              const Text(
                "Enter new password to return to you account \nand return to login",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: GlobalVariables.screenHeight * 0.07,
              ),
              passwordFields(),
              SizedBox(
                height: GlobalVariables.screenHeight * 0.01,
              ),
              Center(
                child: FormHelper.submitButton("Reset Password", () {
                  if (validateAndSave()) {
                    // API
                    setState(() {
                      isAsynccall = true;
                    });

                    APIService.reset(
                      widget.modal.email!,
                      confirmnewPassword!,
                    ).then(
                      (response) {
                        setState(() {
                          isAsynccall = false;
                        });

                        if (response) {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Password Reset Successfully\nyou will be directed to login",
                              'OK', () {
                            Navigator.of(context)
                                .popAndPushNamed('/login-screen');
                          });
                        } else {
                          FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Invalid email/password",
                              'OK', () {
                            Navigator.of(context).pop();
                          });
                        }
                      },
                    );
                  }
                },
                    btnColor: Colors.deepPurple,
                    borderColor: Colors.white,
                    borderRadius: 20,
                    txtColor: Colors.white),
              ),
              SizedBox(
                height: GlobalVariables.screenHeight * 0.01,
              ),
              backtoSignupButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Column passwordFields() {
    return Column(
      children: [
        FormHelper.inputFieldWidget(
          context,
          "password",
          "New password",
          (onValidateVal) {
            if (onValidateVal.isEmpty) return "* Required";

            return null;
          },
          (onSavedVal) {
            newpassword = onSavedVal.toString().trim();
          },
          showPrefixIcon: true,
          prefixIcon: const Icon(Icons.lock),
          borderRadius: 10,
          contentPadding: 15,
          fontSize: 14,
          prefixIconPaddingLeft: 10,
          prefixIconColor: Colors.black,
          borderColor: Colors.grey.shade400,
          hintColor: Colors.black.withOpacity(0.6),
          backgroundColor: Colors.grey.shade100,
          borderFocusColor: Colors.grey.shade200,
          obscureText: hidePassword,
          suffixIcon: IconButton(
            onPressed: () {
              setState(
                () {
                  hidePassword = !hidePassword;
                },
              );
            },
            color: Colors.purple.withOpacity(.4),
            icon: Icon(
              hidePassword ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          onChange: (val) {
            newpassword = val;
          },
        ),
        SizedBox(
          height: GlobalVariables.screenHeight * 0.02,
        ),
        FormHelper.inputFieldWidget(
          context,
          "confirmPassword",
          "Confirm New Password",
          (onValidateVal) {
            if (onValidateVal.isEmpty) return "* Required";

            if (onValidateVal != newpassword) {
              return "Confirm Password not matched";
            }

            return null;
          },
          (onSavedVal) {
            confirmnewPassword = onSavedVal.toString().trim();
          },
          showPrefixIcon: true,
          prefixIcon: const Icon(Icons.lock),
          borderRadius: 10,
          contentPadding: 15,
          fontSize: 14,
          prefixIconPaddingLeft: 10,
          prefixIconColor: Colors.black,
          borderColor: Colors.grey.shade400,
          hintColor: Colors.black.withOpacity(0.6),
          backgroundColor: Colors.grey.shade100,
          borderFocusColor: Colors.grey.shade200,
          obscureText: hideConfirmPassword,
          suffixIcon: IconButton(
            onPressed: () {
              setState(
                () {
                  hideConfirmPassword = !hideConfirmPassword;
                },
              );
            },
            color: Colors.purple.withOpacity(.4),
            icon: Icon(
              hideConfirmPassword ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
      ],
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
