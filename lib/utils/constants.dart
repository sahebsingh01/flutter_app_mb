import 'package:flutter/material.dart';

class AppConstants {}

class NavigationConstants {
  static const String routeLaunch = "routeLaunch";
  static const String routeUploadProfileInfo = "routeUploadProfileInfo";
  static const String routeUploadPicture = "routeUploadPicture";
  static const String routeSplashScreen = "routeSplashScreen";
  static const String routeSignatureScreen = "routeSignatureScreen";
  static const String routeUploadInformation = "routeUploadInformation";
}

class ColorConstants {
  static const Color primaryGradientColor = Color(0xff9d00ff);
  static const Color secondaryGradientColor = Color(0xff00d0ff);
}

class DicParams{
  static const String signature = "signature";
}

class FontConstants {
  static const double fontSize14 = 14.0;
}

class PreferencesConst{
  static const String userName = "name";
}

class ImageConstants{
  static const String userDefaultImage = "assets/images/default_profile.webp";
  static const String appLogoCircle = "assets/images/mb_circle.png";
  static const String appLogoUnderline = "assets/images/mb_underline.png";
  static const String defaultPicture = "assets/images/default_picture.png";
  static const String selectPicture = "assets/images/photography.png";
  static const String defaultGroupPhoto = "assets/images/group_photo.jpg";
}
