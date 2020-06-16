import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dialog_utils.dart';
import 'localization/localization.dart';

class PermissionUtils {
  static void requestPermission(
      List<PermissionGroup> permission, BuildContext context,
      {Function permissionGrant,
      Function permissionDenied,
      Function permissionNotAskAgain,
      bool isOpenSettings = false,
      bool isShowMessage = true}) {
    PermissionHandler().requestPermissions(permission).then((statuses) {
      var allPermissionGranted = true;

      statuses.forEach((key, value) {
        if (value == PermissionStatus.granted) {
          allPermissionGranted = allPermissionGranted && true;
        } else {
          allPermissionGranted = allPermissionGranted && false;
        }
      });

      if (allPermissionGranted) {
        if (permissionGrant != null) {
          permissionGrant();
        }
      } else {
        if (permissionDenied != null) {
          permissionDenied();
        }
        if (isOpenSettings) {
          DialogUtils.showOkCancelAlertDialog(
            context: context,
            message: Localization.of(context).alertPermissionNotRestricted,
            cancelButtonTitle: Platform.isAndroid
                ? Localization.of(context).no
                : Localization.of(context).cancel,
            okButtonTitle: Platform.isAndroid
                ? Localization.of(context).yes
                : Localization.of(context).ok,
            okButtonAction: AppSettings.openAppSettings,
          );
        } else if (isShowMessage) {
          DialogUtils.displayToast(
              Localization.of(context).alertPermissionNotRestricted);
        }
      }
    });
  }
}
