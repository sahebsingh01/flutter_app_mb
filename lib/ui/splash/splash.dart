import 'dart:async';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/constants.dart';
import '../../utils/navigation.dart';
import '../../utils/navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer timer;
  void _startTimer() {
    timer = Timer(Duration(seconds: 2), () {
      NavigationUtils.push(context, NavigationConstants.routeLaunch);
      timer.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            height: MediaQuery.of(context).size.width,
        child: Center(child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(ImageConstants.appLogoCircle),
        )),
      )),
    );
  }
}
