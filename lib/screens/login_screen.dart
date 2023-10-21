import 'package:flutter/material.dart';
import 'package:flutter_iterview_task/components/submit_components.dart';
import 'package:flutter_iterview_task/main.dart';
import 'package:flutter_iterview_task/screens/home_list_screen.dart';
import 'package:flutter_iterview_task/screens/signup_screen.dart';
import 'package:flutter_iterview_task/service/auth_service.dart';
import '../components/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
          onTap: () {
            Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const SignupScreen(),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80, left: 80),
            child: Text("Sign UP?"),
          )),
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
                  controller: emailController,
                  hintText: "Enter Email",
                ),
                SizedBox(
                  height: 15,
                ),
                EventTextBoxWidget(
                  controller: passwordController,
                  hintText: "Enter Passsword",
                ),
                SizedBox(
                  height: 15,
                ),
                buttonWidget("Login", () {
                  authServices.signInWithEmailPassword(context,
                      email: emailController.text,
                      password: passwordController.text);
                }, context),
                SizedBox(
                  height: 15,
                ),
                buttonWidget(
                  "Sign In With Google",
                  () {
                    if (_formKey.currentState!.validate()) {
                      authServices.googleSignIn(context).then((value) => {
                            if (value.accessToken != null)
                              {
                                Navigator.pushReplacement<void, void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const HomeListScreen(),
                                  ),
                                )
                              }
                          });
                    }
                  },
                  context,
                ),
                buttonWidget(
                  "Login As Admin",
                  () {
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
                  },
                  context,
                ),
              ]),
        ),
      ),
    );
  }
}
