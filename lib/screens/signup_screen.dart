import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iterview_task/main.dart';
import 'package:flutter_iterview_task/screens/login_screen.dart';
import 'package:flutter_iterview_task/service/auth_service.dart';
import '../components/submit_components.dart';
import '../components/text_form_field.dart';
import '../extensions/system_utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var countryCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                EventTextBoxWidget(
                  hintText: "Enter Phone",
                  controller: phoneController,
                  prefixWidget: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CountryCodePicker(
                          initialSelection: countryCode,
                          showCountryOnly: false,
                          //dialogSize: Size(),
                          showFlag: true,
                          showFlagDialog: true,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                          dialogBackgroundColor: Theme.of(context).cardColor,
                          barrierColor: Colors.black12,
                          searchDecoration: InputDecoration(
                              iconColor: Theme.of(context).dividerColor,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).dividerColor)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide())),
                          onInit: (c) {
                            countryCode = c!.dialCode!;
                          },
                          onChanged: (c) {
                            countryCode = c.dialCode!;
                          },
                        ),
                        VerticalDivider(color: Colors.grey.withOpacity(0.5))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                EventTextBoxWidget(
                  hintText: "Enter Email",
                  controller: emailController,
                ),
                SizedBox(
                  height: 15,
                ),
                EventTextBoxWidget(
                  hintText: "Enter Passsword",
                  controller: passwordController,
                ),
                SizedBox(
                  height: 15,
                ),
                buttonWidget("SignUp", () {
                  if (_formKey.currentState!.validate()) {
                    authServices
                        .createAuthUser(
                            emailController.text, passwordController.text)
                        .then((value) => {
                              print(value),
                              if (value!.uid != null)
                                {
                                  Navigator.pushReplacement<void, void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const LoginScreen(),
                                    ),
                                  )
                                }
                            });
                  }
                }, context)
              ]),
        ),
      ),
    );
  }
}
