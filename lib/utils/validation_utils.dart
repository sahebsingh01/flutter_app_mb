import 'package:flutter/material.dart';
import 'package:libphonenumber/libphonenumber.dart';

import 'localization/localization.dart';

String isValidEmail(BuildContext context, String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final regex = RegExp(pattern);

  if (value.isEmpty) {
    return Localization.of(context).msgEnterAddress;
  } else if (!regex.hasMatch(value.trim())) {
    return Localization.of(context).msgEnterValidAddress;
  } else {
    return null;
  }
}

String isValidEmailOptional(BuildContext context, String value) {
  if (value.isEmpty) {
    return null;
  }
  return isValidEmail(context, value);
}

String isValidName(BuildContext context, String value) {
  if (value.isEmpty) {
    return Localization.of(context).msgEnterName;
  } else if (value.trim().length < 2) {
    return Localization.of(context).msgEnterValidName;
  } else {
    return null;
  }
}

String isValidMessage(BuildContext context, String value) {
  if (value.isEmpty) {
    return Localization.of(context).msgEnterMessage;
  } else if (value.trim().length < 2) {
    return Localization.of(context).msgEnterValidMessage;
  } else {
    return null;
  }
}

String isValidGroupName(BuildContext context, String value) {
  if (value.trim().isEmpty) {
    return Localization.of(context).msgEnterGroupName;
  } else {
    return null;
  }/*
    */
}

String isValidNumber(BuildContext context, String value) {
  final pattern = RegExp(r'^[0-9]+$');

  if (value.trim().isEmpty) {
    return Localization.of(context).msgEnterMobile;
  } else if (!pattern.hasMatch(value.trim()) || value.trim().length < 10) {
    return Localization.of(context).msgEnterValidMobile;
  } else {
    return null;
  }
}

String isValidPassCode(BuildContext context, String value) {
  if (value.trim().isEmpty) {
    return Localization.of(context).msgEnterPassCode;
  } else if (value.trim().length < 6) {
    return Localization.of(context).msgEnterValidPassCode;
  } else {
    return null;
  }
}

String isValidOldPassCode(BuildContext context, String value) {
  if (value.trim().isEmpty) {
    return Localization.of(context).msgOldPasscode;
  } else if (value.trim().length < 6) {
    return Localization.of(context).msgEnterValidPassCode;
  } else {
    return null;
  }
}

String isValidNewPassCode(BuildContext context, String value) {
  if (value.trim().isEmpty) {
    return Localization.of(context).msgNewPasscode;
  } else if (value.trim().length < 6) {
    return Localization.of(context).msgEnterValidPassCode;
  } else {
    return null;
  }
}

String isValidVerificationCode(BuildContext context, String value) {
  if (value.trim().isEmpty) {
    return Localization.of(context).msgEnterPassCode;
  } else if (value.trim().length < 6) {
    return Localization.of(context).msgVerificationCode;
  } else {
    return null;
  }
}

String isValidConfirmPassCode(
    BuildContext context, String newPassword, String oldPassword) {
  if (newPassword.trim().isEmpty) {
    return Localization.of(context).msgEnterConfirmPassCode;
  } else if (newPassword.trim() != oldPassword.trim()) {
    return Localization.of(context).msgEnterValidConfirmPassCode;
  } else {
    return null;
  }
}

String isValidExpiryMonth(BuildContext context, String value) {
  if (value.isEmpty) {
    return Localization.of(context).msgEnterExpiryMonth;
  } else if (int.parse(value) > 12) {
    return Localization.of(context).msgInvalidExpiryMonth;
  } else {
    return null;
  }
}

String isValidExpiryYear(BuildContext context, String value) {
  if (value.isEmpty) {
    return Localization.of(context).msgEnterExpiryYear;
  } else if (2000 + int.parse(value) < DateTime.now().year) {
    return Localization.of(context).msgInvalidExpiryYear;
  } else {
    return null;
  }
}

String isValidCvvNumber(BuildContext context, String value) {
  if (value.isEmpty) {
    return Localization.of(context).msgEnterCvvNumber;
  } else if (int.parse(value) < 3) {
    return Localization.of(context).msgInvalidCvvNumber;
  } else {
    return null;
  }
}

Future<String> formatMobileNumber(String value, String countryCode) async {
  var formatNumber = value.replaceAll(RegExp(r'[^+\d]+'), '');

//  if (formatNumber.indexOf("+") == -1 &&
//      formatNumber.indexOf(defaultCountryCode) == -1) {
//    return defaultCountryCode + formatNumber;
//  }

  try {
    var normalizedNumber = await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: formatNumber, isoCode: countryCode);
    return normalizedNumber;
  } on Exception {
    return formatNumber;
  }
}
