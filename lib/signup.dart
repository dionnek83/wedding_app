import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wedding_app/auth.dart';
import 'package:wedding_app/main.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final _auth = AuthService();
  final formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("./assets/backgroundimage.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 40, right: 40),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Row(children: [
                        Text(
                          "Sign Up",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 34, color: Colors.white),
                          //
                        )
                      ]),

                      const SizedBox(height: 40),
                      // converted to textformField
                      Container(
                        margin: const EdgeInsets.only(bottom: 30, right: 30),
                        child: TextFormField(
                          controller: _email,
                          minLines: 1,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            contentPadding: const EdgeInsets.only(left: 30),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 5, right: 30),
                        child: TextFormField(
                            controller: _password,
                            minLines: 1,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              contentPadding: const EdgeInsets.only(left: 30),
                            )),
                      ),

                      const SizedBox(height: 20),
                      TextButton(
                          onPressed: _signup,
                          child: Center(
                              child: Container(
                            margin: const EdgeInsets.only(right: 30),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: const Color(0xFFE68369)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: const Text(
                              'Sign up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ))),
                      const SizedBox(height: 5),
                      Expanded(
                          child: Center(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Already have an Account? Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )),
                      ))
                    ],
                  ),
                )
                // This trailing comma makes auto-formatting nicer for build methods.
                )));
  }

  goToLogin(BuildContext buildContext) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => const MyHomePage()));
  _signup() async {
    final user =
        await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      log("User created successfully");
      goToLogin(context);
    }
  }
}
