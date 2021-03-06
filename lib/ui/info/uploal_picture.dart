import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muski_bday/utils/check_network_connection.dart';
import 'package:muski_bday/utils/constants.dart';
import 'package:muski_bday/utils/dialog_utils.dart';
import 'package:muski_bday/utils/firebase_manager.dart';
import 'package:muski_bday/utils/navigation.dart';
import 'package:muski_bday/utils/permission_utils.dart';
import 'package:muski_bday/utils/preference_utils.dart';
import 'package:muski_bday/widgets/custom_button.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/constants.dart';

class UploadPicture extends StatefulWidget {
  @override
  _UploadPictureState createState() => _UploadPictureState();
}

class _UploadPictureState extends State<UploadPicture> {
  File _image;
  File _picture;
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
                      "Say Cheese.",
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.white.withAlpha(200),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Please upload a picture of yourself with muskan:",
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
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.height * 0.8,
                                color: Colors.white,
                                child: _image != null
                                    ? Image.file(
                                        _image,
                                        fit: BoxFit.cover,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: "",
                                        fit: BoxFit.cover,
                                        errorWidget: (context, value, error) =>
                                            Container(
                                          child: Image.asset(
                                            ImageConstants.defaultGroupPhoto,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                      ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  _getImageFromGallery();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.black.withAlpha(25),
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      ImageConstants.selectPicture,
                                      height: 25,
                                      width: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: CustomButton(
                            isTitleButton: false,
                            onPressAction: () {
                              if (_image == null) {
                                DialogUtils.showOkCancelAlertDialog(
                                    context: context,
                                    isCancelEnable: true,
                                    cancelButtonTitle: "No",
                                    cancelButtonAction: () {
                                      _getImageFromGallery();
                                    },
                                    message:
                                        "Do you wish to proceed without adding a picture of you with Muskan?",
                                    okButtonTitle: "Yes",
                                    okButtonAction: () {
                                      NavigationUtils.push(
                                          context,
                                          NavigationConstants
                                              .routeUploadPicture);
                                    });
                              } else {
                                NavigationUtils.push(context,
                                    NavigationConstants.routeMessageScreen);
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

  _getImageSourceBottomSheet(BuildContext buildContext) {
    showModalBottomSheet(
        context: buildContext,
        builder: (buildContext) => FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _getBottomSheetACtion(false, context),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: _getBottomSheetACtion(true, context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget _getBottomSheetACtion(bool isGallery, BuildContext context) =>
      FittedBox(
        child: InkWell(
          onTap: isGallery
              ? () {
                  _askGalleryPermission();
                  NavigationUtils.pop(context);
                }
              : () {
                  _askCameraPermission();
                  NavigationUtils.pop(context);
                },
          child: Column(
            children: <Widget>[
              Icon(
                isGallery ? Icons.photo : Icons.camera_alt,
                color: ColorConstants.primaryGradientColor,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  isGallery ? "Gallery" : "Camera",
                  style: TextStyle(fontSize: 10.0),
                ),
              ),
            ],
          ),
        ),
      );

  _askCameraPermission() {
    PermissionUtils.requestPermission([PermissionGroup.camera], context,
        isOpenSettings: true,
        permissionGrant: _getImageFromCamera,
        permissionDenied: () {});
  }

  _askGalleryPermission() {
    PermissionUtils.requestPermission(
        Platform.isAndroid
            ? [PermissionGroup.storage]
            : [PermissionGroup.photos],
        context,
        isOpenSettings: true,
        permissionGrant: _getImageFromGallery,
        permissionDenied: () {});
  }

  Future _getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (await checkNetworkConnection(context)) {
      setState(() {
        _image = image;
      });
    }
  }

  Future _getImageFromGallery() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _cropImage(pickedImage.path);
    }
  }

  Future<Null> _cropImage(String path) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: ColorConstants.primaryGradientColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Mb',
        ));
    if (croppedFile != null) {
      setState(() async {
        setState(() {
          _image = croppedFile;
        });
        if (await checkNetworkConnection(context)) {
          FirebaseManager.uploadImage(
              croppedFile, false, getString(PreferencesConst.userName));
        }
      });
    }
  }
}
