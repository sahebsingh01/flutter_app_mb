import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:muski_bday/ui/uploadform/model/wish_model.dart';
import 'package:muski_bday/utils/check_network_connection.dart';
import 'package:muski_bday/utils/constants.dart';
import 'package:muski_bday/utils/firebase_manager.dart';
import 'package:muski_bday/utils/navigation.dart';
import 'package:muski_bday/utils/preference_utils.dart';
import 'package:muski_bday/utils/progress_dialog.dart';
import 'package:muski_bday/widgets/custom_button.dart';

class UploadInformation extends StatefulWidget {
  Uint8List signature;
  WishModel wishModel;
  UploadInformation({this.signature, this.wishModel});
  @override
  _UploadInformationState createState() => _UploadInformationState();
}

class _UploadInformationState extends State<UploadInformation> {
  String _name;
  String _message;
  String _profileUrl;
  String _pictureUrl;
  String _signatureUrl;
  ConfettiController _controllerBottomRight;
  ConfettiController _controllerBottomLeft;

  @override
  void dispose() {
    _controllerBottomRight.dispose();
    _controllerBottomLeft.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.wishModel == null) {
      _name = getString(PreferencesConst.userName);
      _message = getString(PreferencesConst.message);
      _profileUrl = getString(PreferencesConst.profilePic);
      _pictureUrl = getString(PreferencesConst.pictureUrl);
      _signatureUrl = getString(PreferencesConst.signature);
    } else {
      _controllerBottomRight =
          ConfettiController(duration: const Duration(seconds: 1));
      _controllerBottomLeft =
          ConfettiController(duration: const Duration(seconds: 1));
      _controllerBottomRight.play();
      _controllerBottomLeft.play();
    }
  }

  _uploadWish() async {
    if (await checkNetworkConnection(context)) {
      ProgressDialogUtils.showProgressDialog(context);
      await FirebaseManager.addBirthdayWish(WishModel(
        message: _message,
        name: _name,
        pictureUrl: _pictureUrl,
        profilePic: _profileUrl,
        signatureUrl: _signatureUrl,
      )).then((value) {
        ProgressDialogUtils.dismissProgressDialog();
        NavigationUtils.push(context, NavigationConstants.routeCompletionScreen,
            arguments: {
              DicParams.name: _name,
            });
      }).catchError((error) {
        ProgressDialogUtils.dismissProgressDialog();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              NavigationUtils.pop(context);
            }),
        title:
            Text(widget.wishModel != null ? widget.wishModel.name : "Summary"),
        centerTitle: true,
        backgroundColor: ColorConstants.primaryGradientColor,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getTitle("Name"),
                  _getName(),
                  _getTitle("Profile Picture"),
                  _getProfilePicture(),
                  _getTitle("Picture with Muskan"),
                  _getPictureWithMuskan(),
                  _getTitle("Message"),
                  _getMessage(),
                  widget.signature != null || widget.wishModel != null
                      ? _getTitle("Signature")
                      : Container(),
                  widget.signature != null || widget.wishModel != null
                      ? _getSignature()
                      : Container(),
                  widget.wishModel != null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomButton(
                                  isTitleButton: true,
                                  isUploadButton: true,
                                  onPressAction: () {
                                    _uploadWish();
                                  }),
                            ],
                          ),
                        )
                ],
              ),
            ),
            widget.wishModel == null
                ? Container()
                : Positioned(
                    bottom: 0,
                    right: 0,
                    child: ConfettiWidget(
                      confettiController: _controllerBottomRight,
                      blastDirection: -(2 * pi) / 3, // radial value - LEFT
                      particleDrag: 0.05, // apply drag to the confetti
                      emissionFrequency: 0.2, // how often it should emit
                      numberOfParticles: 2, // number of particles to emit
                      gravity: 0.05, // gravity - or fall speed
                      shouldLoop: false,
                      maxBlastForce: 100,
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
            widget.wishModel == null
                ? Container()
                : Positioned(
                    bottom: 0,
                    left: 0,
                    child: ConfettiWidget(
                      confettiController: _controllerBottomLeft,
                      blastDirection: 30, // radial value - LEFT
                      particleDrag: 0.05, // apply drag to the confetti
                      emissionFrequency: 0.2, // how often it should emit
                      numberOfParticles: 2, // number of particles to emit
                      gravity: 0.05, // gravity - or fall speed
                      shouldLoop: false,
                      maxBlastForce: 100,
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
          ],
        ),
      ),
    );
  }

  Widget _getTitle(String title) => Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
        ),
        child: Text(
          "$title:",
          style: TextStyle(
            color: Colors.blueGrey,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
      );

  Widget _getProfilePicture() => Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.12,
          backgroundColor: ColorConstants.primaryGradientColor,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.height * 0.4,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: widget.wishModel != null
                      ? widget.wishModel.profilePic
                      : (_profileUrl == null ? "" : _profileUrl),
                  fit: BoxFit.cover,
                  errorWidget: (context, value, error) =>
                      Image.asset(ImageConstants.userDefaultImage),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _getName() => Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorConstants.primaryGradientColor,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.wishModel != null ? widget.wishModel.name : _name,
              style: TextStyle(
                color: ColorConstants.primaryGradientColor,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      );

  Widget _getMessage() => Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorConstants.primaryGradientColor,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.wishModel != null ? widget.wishModel.message : _message,
              style: TextStyle(
                color: ColorConstants.primaryGradientColor,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      );

  Widget _getPictureWithMuskan() => Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          color: ColorConstants.primaryGradientColor,
          child: CachedNetworkImage(
            imageUrl: widget.wishModel != null
                ? widget.wishModel.pictureUrl
                : (_pictureUrl == null ? "" : _pictureUrl),
            fit: BoxFit.cover,
            errorWidget: (context, value, error) => Container(
              child: Image.asset(
                ImageConstants.defaultGroupPhoto,
                fit: BoxFit.cover,
              ),
            ),
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
          ),
        ),
      );

  Widget _getSignature() => Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.width * 0.25,
          width: MediaQuery.of(context).size.width * 0.3,
          child: widget.wishModel != null
              ? CachedNetworkImage(
                  imageUrl: widget.wishModel.signatureUrl,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                )
              : Image.memory(
                  widget.signature,
                ),
        ),
      );
}
