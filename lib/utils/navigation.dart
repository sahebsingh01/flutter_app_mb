import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muski_bday/ui/info/name_info.dart';
import 'package:muski_bday/ui/info/upload_profile.dart';
import 'package:muski_bday/ui/info/uploal_picture.dart';
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
