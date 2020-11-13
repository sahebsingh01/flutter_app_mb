import 'dart:async';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/constants.dart';
import '../../utils/navigation.dart';
import '../../utils/navigation.dart';

class SplashScreen extends StatefulWidget {
  final bool isUploadForm;
  SplashScreen({
    @required this.isUploadForm,
  });
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;
  double dimension = 0.0;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == 1) {
        setState(() {
          dimension = MediaQuery.of(context).size.width;
        });
      }
      if (timer.tick == 3) {
        widget.isUploadForm
            ? NavigationUtils.pushAndRemoveUntil(
                context, NavigationConstants.routeLaunch)
            : NavigationUtils.pushAndRemoveUntil(
                context, NavigationConstants.routeWishesScreen);
        _timer.cancel();
      }
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
      body: Container(
        child: Center(
          child: AnimatedContainer(
            height: dimension,
            width: dimension,
            curve: Curves.linearToEaseOut,
            duration: Duration(seconds: 1),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Image.asset(
                  ImageConstants.appLogoCircle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
