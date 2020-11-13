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

class UploadProfileInfo extends StatefulWidget {
  @override
  _UploadProfileInfoState createState() => _UploadProfileInfoState();
}

class _UploadProfileInfoState extends State<UploadProfileInfo> {
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
                      "Selfie Time.",
                      style: TextStyle(
                        fontSize: 55.0,
                        color: Colors.white.withAlpha(200),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        "Please upload a picture of yourself which will be shown in the list:",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor:
                                ColorConstants.primaryGradientColor,
                            radius: MediaQuery.of(context).size.width * 0.2,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.height * 0.2,
                                  backgroundColor:
                                      ColorConstants.primaryGradientColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: ClipOval(
                                        child: _image != null
                                            ? Image.file(
                                                _image,
                                                fit: BoxFit.fill,
                                              )
                                            : CachedNetworkImage(
                                                imageUrl:
                                                    "", //"https://images.pexels.com/photos/736230/pexels-photo-736230.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                                fit: BoxFit.cover,
                                                errorWidget: (context, value,
                                                        error) =>
                                                    Image.asset(ImageConstants
                                                        .userDefaultImage),
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: InkWell(
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            ImageConstants.defaultPicture,
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        _getImageFromGallery();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                        "Do you wish to proceed without adding a profile picture?",
                                    okButtonTitle: "Yes",
                                    okButtonAction: () {
                                      NavigationUtils.push(
                                          context,
                                          NavigationConstants
                                              .routeUploadPicture);
                                    });
                              } else {
                                NavigationUtils.push(context,
                                    NavigationConstants.routeUploadPicture);
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
                  // _askCameraPermission();
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

  // _askCameraPermission() {
  //   PermissionUtils.requestPermission([PermissionGroup.camera], context,
  //       isOpenSettings: true,
  //       permissionGrant: _getImageFromCamera,
  //       permissionDenied: () {});
  // }

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

  // Future _getImageFromCamera() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   if (await checkNetworkConnection(context)) {
  //     // _uploadImage(image);
  //     setState(() {
  //       _image = File(image.path);
  //     });
  //   }
  // }

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
          await FirebaseManager.uploadImage(
              croppedFile, true, getString(PreferencesConst.userName));
        }
      });
    }
  }
}
