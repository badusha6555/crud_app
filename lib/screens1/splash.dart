=prefimport 'dart:async';

import 'package:crud_app/main.dart';
import 'package:crud_app/screens/list_student.dart';
import 'package:crud_app/screens1/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      //   if(isLoggedIn==true){
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      //   }else{
      //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ListStudent()));
      // }
    });
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ListStudent()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ),
    );
  }
}
