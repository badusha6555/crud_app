import 'package:crud_app/model/student.dart';

import 'package:crud_app/screens1/splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentAdapter().typeId)) {
    Hive.registerAdapter(StudentAdapter());
  }
  runApp(MyApp());
}

bool isLoggedIn = true;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Splash',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen());
  }
}
