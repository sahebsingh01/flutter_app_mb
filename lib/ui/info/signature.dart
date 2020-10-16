import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muski_bday/utils/constants.dart';
import 'package:muski_bday/utils/dialog_utils.dart';
import 'package:muski_bday/utils/firebase_manager.dart';
import 'package:muski_bday/utils/navigation.dart';
import 'package:muski_bday/utils/preference_utils.dart';
import 'package:muski_bday/widgets/custom_button.dart';
import 'package:signature/signature.dart';

import '../../utils/constants.dart';

class SignatureScreen extends StatefulWidget {
  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: ColorConstants.primaryGradientColor,
    exportBackgroundColor: Colors.transparent,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1.1,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorConstants.primaryGradientColor,
                        ColorConstants.secondaryGradientColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 25.0,
                    right: 16.0,
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Autograph Please.",
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.white.withAlpha(200),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Please add your signature:",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.32,
                                  width:
                                      MediaQuery.of(context).size.height * 0.8,
                                  color: Colors.white,
                                  child: Center(
                                    child: Signature(
                                      controller: _controller,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.28,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      backgroundColor: Colors.white,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _controller.clear();
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black.withAlpha(25),
                                    )
                                  ]),
                              child: Center(
                                  child: Text(
                                "Clear",
                                style: TextStyle(
                                  color: ColorConstants.primaryGradientColor,
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Center(
                        child: CustomButton(
                            isTitleButton: false,
                            onPressAction: () async {
                              if (_controller.isNotEmpty) {
                                var data = await _controller.toPngBytes();
                                FirebaseManager.uploadSignature(data,
                                    getString(PreferencesConst.userName));
                                NavigationUtils.push(context,
                                    NavigationConstants.routeUploadInformation,
                                    arguments: {DicParams.signature: data});
                              } else {
                                DialogUtils.showOkCancelAlertDialog(
                                    context: context,
                                    cancelButtonTitle: "No",
                                    okButtonTitle: "Yes",
                                    message:
                                        "Are you sure you want to proceed without adding your signature?",
                                    isCancelEnable: true,
                                    okButtonAction: () {
                                      NavigationUtils.push(
                                          context,
                                          NavigationConstants
                                              .routeUploadInformation,
                                          arguments: {
                                            DicParams.signature: null
                                          });
                                    });
                              }
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: CustomButton(
                            isTitleButton: true,
                            onPressAction: () {
                              NavigationUtils.pop(context);
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
