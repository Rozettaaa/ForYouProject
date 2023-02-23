// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'main.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 4,
        navigateAfterSeconds: firstpagelogin(),
        title: Text(
          'For You \nApplication',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26.0,
              color: Colors.yellow[700],
              fontFamily: 'Athiti'),
          textAlign: TextAlign.center,
        ),
        image: Image.asset('assets/images/logo_foryou.jpg'),
        backgroundColor: Colors.white,
        photoSize: 150.0,
        loaderColor: Colors.yellow.shade700);
  }
}
