import 'dart:io';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:muski_bday/utils/constants.dart';
import 'package:muski_bday/utils/navigation.dart';
import 'package:muski_bday/widgets/custom_button.dart';

class CompletionScreen extends StatefulWidget {
  final String name;
  CompletionScreen({
    this.name,
  });
  @override
  _CompletionScreenState createState() => _CompletionScreenState();
}

class _CompletionScreenState extends State<CompletionScreen> {
  ConfettiController _controllerCenterRight;
  String firstName = "";

  @override
  void initState() {
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 3));
    _controllerCenterRight.play();
    firstName = widget.name == null ? "" : widget.name.split(" ")[0];
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenterRight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                child: FlareActor(
                  ImageConstants.completedFlare,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.contain,
                  animation: AppConstants.completedFlareAnimation,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: ConfettiWidget(
                confettiController: _controllerCenterRight,
                blastDirection: pi, // radial value - LEFT
                particleDrag: 0.05, // apply drag to the confetti
                emissionFrequency: 0.2, // how often it should emit
                numberOfParticles: 2, // number of particles to emit
                gravity: 0.05, // gravity - or fall speed
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.purple,
                  Colors.amber,
                  Colors.teal,
                ], // manually specify the colors to be used
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
                child: Text(
                  "Thank you${" " + firstName} for your kind and thoughtful birthday wishes.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstants.primaryGradientColor.withAlpha(200),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 60.0,
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    isTitleButton: true,
                    isUploadButton: false,
                    title: "Upload Another",
                    onPressAction: () {
                      NavigationUtils.pushAndRemoveUntil(
                          context, NavigationConstants.routeLaunch);
                    },
                  ),
                  CustomButton(
                    isTitleButton: true,
                    isUploadButton: false,
                    title: "Exit",
                    onPressAction: () {
                      exit(0);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
