import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:muski_bday/ui/info/name_info.dart';
import 'package:muski_bday/ui/info/signature.dart';
import 'package:muski_bday/ui/info/upload_profile.dart';
import 'package:muski_bday/ui/info/uploal_picture.dart';
import 'package:muski_bday/ui/splash/splash.dart';
import 'package:muski_bday/ui/uploadform/upload_Info.dart';
import 'package:muski_bday/utils/constants.dart';

class NavigationUtils {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic> args = settings.arguments;
    switch (settings.name) {
      case NavigationConstants.routeLaunch:
        return MaterialPageRoute(builder: (_) => NameInfo());
      case NavigationConstants.routeUploadProfileInfo:
        return MaterialPageRoute(builder: (_) => UploadProfileInfo());
      case NavigationConstants.routeUploadPicture:
        return MaterialPageRoute(builder: (_) => UploadPicture());
      case NavigationConstants.routeSplashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case NavigationConstants.routeSignatureScreen:
        return MaterialPageRoute(builder: (_) => SignatureScreen());
      case NavigationConstants.routeUploadInformation:
        final Uint8List signature = args[DicParams.signature];
        return MaterialPageRoute(
            builder: (_) => UploadInformation(
                  signature: signature,
                ));
      default:
        return _errorRoute(" Coming soon...");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('Error')),
          body: Center(child: Text(message)));
    });
  }

  static void pushReplacement(BuildContext context, String routeName,
      {Object arguments}) {
    Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> push(BuildContext context, String routeName,
      {Object arguments}) {
    return Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  static void pop(BuildContext context, {dynamic args}) {
    Navigator.of(context).pop(args);
  }

  static Future<dynamic> pushAndRemoveUntil(
      BuildContext context, String routeName,
      {Object arguments}) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }
}
