//@dart=2.9
// ignore_for_file: camel_case_types

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wallpaper/Screens/Home/Home_Screen.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/SplashScreen/splash.png"),
                fit: BoxFit.cover),
          ),
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Wallpaper",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
