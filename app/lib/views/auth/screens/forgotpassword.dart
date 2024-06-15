import 'package:app/api/api_service.dart';
import 'package:app/constants/globalvariable.dart';
import 'package:app/views/auth/screens/otpscreen.dart';
import 'package:app/views/auth/services/singupprovider.dart';
import 'package:app/views/auth/widgets/backtopSignupButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgotpassword-screen';

  final bool isValidEmail;
  const ForgotPasswordScreen({
    required this.isValidEmail,
    super.key,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  static bool isValidEmail = false;
  static bool isAsynccall = false;
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String email = '';
  @override
  void initState() {
    super.initState();
    isValidEmail = widget.isValidEmail;
  }

  @override
  Widget build(BuildContext context) {
    GlobalVariables().init(context);
    return ChangeNotifierProvider(
      create: (context) => SignUpModal(),
      child: Consumer<SignUpModal>(builder: ((context, value, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
          ),
          body: SafeArea(
            child: ProgressHUD(
                inAsyncCall: isAsynccall,
                key: UniqueKey(),
                opacity: 0.3,
                child: Form(key: globalKey, child: Body())),
          ),
        );
      })),
    );
  }

  Consumer Body() {
    return Consumer<SignUpModal>(builder: ((context, value, child) {
      return SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: emailFormScreen(value)),
        ),
      );
    }));
  }

//*******************Enter Email Screen**************
  Column emailFormScreen(SignUpModal value) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Text(
          "Forgot Password",
          style: TextStyle(
              fontSize: getProportionateScreenWidth(27),
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        const Text(
          "Please enter your email and we will send \nyou an OTP",
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: GlobalVariables.screenHeight * 0.05,
        ),
        emailFormField(value),
        SizedBox(
          height: GlobalVariables.screenHeight * 0.01,
        ),
        Center(
          child: FormHelper.submitButton("Get OTP", () {
            if (validateAndSave()) {
              // API
              setState(() {
                isAsynccall = true;
              });

              APIService.otpSend(value.email!).then((response) {
                setState(() {
                  isAsynccall = false;
                });

                if (response != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OtpScreen(
                          modal: value,
                          hash: response.data,
                          isregisterScreen: false,
                        ),
                      ));
                }
              });
              if (true) {
                setState(() {
                  isValidEmail = true;
                  isAsynccall = false;
                });
              } else {}
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
    );
  }

//**********************Creates Email Field*******************
  Container emailFormField(SignUpModal value) {
    return Container(
      child: FormHelper.inputFieldWidget(
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
          value.email = onSaved.toString().trim();
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
