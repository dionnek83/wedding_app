import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wedding_app/auth.dart';
import 'package:wedding_app/homepage.dart';
import 'package:wedding_app/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                          "Login ",
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
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
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
                          onPressed: _login,
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
                              'Login',
                              textAlign: TextAlign.center,
                              // style: GoogleFonts.jetBrainsMono(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SignUp()));
                            },
                            child: const Text(
                              "Don't have an Account? Sign Up",
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

  goToHome(BuildContext buildContext) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => const Homepage()));

  _login() async {
    final user =
        await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      log("User logged In");
      goToHome(context);
    }
  }
}
