import 'package:flutter/material.dart';
import 'package:wedding_app/auth.dart';
import 'package:wedding_app/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          title: const Text(
            'Dashboard',
            style: TextStyle(color: Colors.white),
          ),
          // elevation: 0.00,
          backgroundColor: const Color(0xFFE68369),
          centerTitle: true,
          toolbarHeight: 100,
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.only(top: 40, left: 30),
                  child: Text(
                    "We are getting married!!",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Dancing Script',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 40, left: 30),
                  child: Column(children: [
                    const Center(
                      child: Text(
                        'Photos',
                        style: TextStyle(
                          fontFamily: 'Dancing Script',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          await _auth.signout();
                          goToLogin(context);
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(fontSize: 15),
                        )),
                  ])),
              // displayPhotos()
            ]));
  }

  goToLogin(BuildContext buildContext) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => const MyHomePage()));
}
