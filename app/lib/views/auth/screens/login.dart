import 'package:app/api/api_service.dart';
import 'package:app/views/auth/screens/forgotpassword.dart';
import 'package:app/views/auth/widgets/backtopSignupButton.dart';
import 'package:app/views/home/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../../config/config.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAsynCallProcess = false;
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool hidePassword = true;
  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ProgressHUD(
          inAsyncCall: isAsynCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalKey,
            child: _loginUI(),
          ),
        ),
      ),
    );
  }

  Widget _loginUI() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Image.asset(
              "assets/images/kinmell.png",
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "K I N M E L L",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Center(
            child: Text(
              "Login",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.deepPurple),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FormHelper.inputFieldWidget(
            context,
            'email',
            'Email',
            (onValidate) {
              if (onValidate.isEmpty) {
                return '* Required';
              }
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(onValidate);
              if (!emailValid) {
                return "Invalid Email";
              }

              return null;
            },
            (onSaved) {
              email = onSaved.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.email_outlined),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            prefixIconColor: Colors.black,
            borderColor: Colors.grey.shade400,
            hintColor: Colors.black.withOpacity(0.6),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade200,
          ),
          const SizedBox(
            height: 10,
          ),
          FormHelper.inputFieldWidget(
            context,
            "password",
            "Password",
            (onValidate) {
              if (onValidate.isEmpty) return "* Required";

              return null;
            },
            (onSaved) {
              password = onSaved.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.password),
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
              password = val;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.65),
            child: GestureDetector(
                onTap: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ForgotPasswordScreen(
                        isValidEmail: true,
                      ),
                    ))),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(decoration: TextDecoration.underline),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: FormHelper.submitButton("Login", () {
              if (validateAndSave()) {
                // API
                setState(() {
                  isAsynCallProcess = true;
                });

                APIService.login(
                  email!,
                  password!,
                ).then(
                  (response) {
                    setState(() {
                      isAsynCallProcess = false;
                    });

                    if (response!) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        HomePage.routeName,
                        (route) => false,
                      );
                    } else {
                      FormHelper.showSimpleAlertDialog(context, Config.appName,
                          "Invalid email/password", 'OK', () {
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
          const SizedBox(
            height: 10,
          ),
          backtoSignupButton(context),
        ],
      ),
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
