import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kobar/UI/HomePage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomePage())));

    return Scaffold(
        backgroundColor: Colors.orange,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Image.asset(
                'images/kobar.png',
              ),
              Image.asset(
                'images/logo_dispar_kobar.png',
                width: 664.0,
                height: 113.0,
              ),
            ],
          ),
        ));
  }
}
