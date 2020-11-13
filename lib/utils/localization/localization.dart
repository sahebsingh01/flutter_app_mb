import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'localization_en.dart';

class MyLocalizationsDelegate extends LocalizationsDelegate<Localization> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
      ].contains(locale.languageCode);

// @override
//   bool isSupported(Locale locale)
//   => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<Localization> load(Locale locale) => _load(locale);

  static Future<Localization> _load(Locale locale) async {
    final String name =
        (locale.countryCode == null || locale.countryCode.isEmpty)
            ? locale.languageCode
            : locale;

    final localeName = Intl.canonicalizedLocale(name);
    Intl.defaultLocale = localeName;

    // if( locale.languageCode == "fr" ) {
    //   return LocalizationFR();
    // } else {
    //   return LocalizationEN();
    // }

    return LocalizationEN();
  }

  @override
  bool shouldReload(LocalizationsDelegate<Localization> old) => false;
}

abstract class Localization {
  static Localization of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  String get appName;

  String get titleHome;
  String get titleAddMember;
  String get titleAddBank;
  String get titlePayNow;
  String get titleSelectMembers;

  String get internetNotConnected;
  String get internetConnectionFailed;
  String get connectionTimeOut;
  String get email;
  String get name;
  String get mobile;
  String get forgotPassword;
  String get loginTitle;
  String get signInTitle;
  String get password;
  String get confirmPassword;
  String get signIn;
  String get save;

/* Splash Screen Text */
  String get splashScreenText;

/* Sign up String */
  String get labelSignUpNote;
  String get labelSignUp;
  String get labelSignInNote;
  String get labelSignIn;
  String get labelPhoneNumber;
  String get labelEmailId;
  String get labelPassCode;
  String get labelConfirmPassCode;
  String get labelNext;
  String get labelBackToLogin;
  String get labelPhone;
  String get labelIAccept;
  String get labelTerms;
  String get and;
  String get privacyPolicy;
  String get msgTermsAndPrivacy;

  String get hintName;
  String get hintNumber;
  String get hintEmail;
  String get hintPassCode;
  String get hintConfirmPassCode;
  String get hintOldPasscode;
  String get hintNewPasscode;

/* Error Messages*/

  String get msgEnterAddress;
  String get msgEnterValidAddress;
  String get msgEnterName;
  String get msgEnterValidName;
  String get msgEnterMessage;
  String get msgEnterValidMessage;
  String get msgEnterMobile;
  String get msgEnterValidMobile;
  String get msgEnterPassCode;
  String get msgEnterConfirmPassCode;
  String get msgEnterValidPassCode;
  String get msgEnterValidConfirmPassCode;
  String get msgVerificationCode;
  String get msgConfirmPasscode;
  String get msgOldPasscode;
  String get msgNewPasscode;
  String get msgSelectDate;
  String get msgSelectPeriodicity;
  String get msgSelectAmount;
  String get msgSelectMembers;
  String get msgEnterGroupName;
  String get msgInviteShare;

  /* Button Titles*/
  String get submit;
  String get backToLogin;
  String get editTitle;

  /* Welcome screen */
  String get forgotPasscode;
  String get forgotPasscodeNote;
  String get resetPasscode;
  String get resetPasscodeNote;
  String get verificationCode;
  String get newPasscode;
  String get oldPasscode;
  String get confirmPasscode;
  String get changePasscodeNote;
  String get labelVerificationCode;
  String get resendVerificationCode;
  String get cameraTitle;
  String get galleryTitle;
  String get cancel;
  String get resend;
  String get ok;
  String get labelEdit;
  String get labelDelete;

  String get labelWelcomeMoney;
  String get labelWelcomeMoneyNote;

  String get menuLabelProfile;
  String get menuLabelInvitation;
  String get menuLabelHistory;
  String get menuLabelLogout;
  String get pushNotifications;
  String get myCards;
  String get bankDetails;
  String get labelNotifications;

  /* Create Group Screen */
  String get createGroupNote;
  String get labelGroupName;
  String get labelStartDate;
  String get labelDueDate;
  String get labelEndDate;
  String get hintSelectDate;
  String get labelWeekly;
  String get labelBiWeekly;
  String get labelEvery3Weeks;
  String get labelDaily;
  String get labelMonthly;
  String get labelAmount;
  String get labelPeriodicity;
  String get labelMembers;
  String get labelMember;
  String get labelCreator;
  String get addMembers;
  String get labelGroupCreator;
  String get labelMembersJoined;
  String get labelJungiMembers;

  //AppBar Titles
  String get myProfileTitle;
  String get editProfileTitle;
  String get changePasscodeTitle;
  String get totalPaidAmount;
  String get totalAmountReceived;
  String get admin;

  /* AppBar Titles */
  String get navMyProfileTitle;
  String get navProfileTitle;
  String get navAccountSettings;
  String get navCreateGroup;
  String get navAddCards;

  String get groupClosed;
  String groupJoiningNote(String value);

  String get labelCountryCode;

  String get labelNoGroupFound;
  String get labelNoInvitationsFound;
  String get labelNoNotificationsFound;
  String get labelNoContactFound;
  String get labelNoCardFound;
  String get labelBankDetailsFound;
  String get labelNoPayUserFound;
  String get labelDataFound;
  String get labelNoDataFound;

  String get labelAdd;
  String get labelAdded;
  String get labelSent;
  String get labelInvite;
  String get labelDecline;
  String get labelJoin;

  String get labelJungiContacts;
  String get labelAllContacts;
  String get labelSearch;

  String get alertPermissionNotGrant;
  String get alertPermissionNotRestricted;

  String get alertCameraPermissionNotRestricted;
  String get alertGalleryPermissionNotRestricted;

  String get labelVerifyCode;
  String get labelVerifyCodeNote;

  String get labelProceed;

  String get errorInvalidOtp;
  String get blankOtp;

  String get labelWelcome;
  String get msgLogout;
  String get msgDeleteNotification;
  String get msgClearAllNotifications;
  String get yes;
  String get no;
  String get msgResetPassword;
  String get msgCannotGoBack;
  String get msgJoinGroup;
  String get msgDeclineInvitation;
  String get msgEditSequence;
  String get labelNoCardsFound;

  String get errorTimeOut;
  String get labelSticksAmount;
  String get labelPaidDate;
  String get labelPending;
  String get labelRandom;
  String get labelManual;
  String get remove;
  String get receivingMoney;
  String get receivedMoney;
  String get nextInLine;
  String get statusPending;

  String get labelPaid;
  String get labelReceived;
  String get labelUnpaid;
  String get labelChat;
  String get labelPayNow;
  String get labelDeleteGroup;
  String get labelRestartGroup;
  String get labeladdMembers;
  String get labelEditSequence;
  String get msgDeleteGroup;
  String get msgRestartGroup;
  String get msgDeleteCard;
  String get msgAddMember;
  String get msgChangeSequence;

  //Toast Titles

  /* Add Card Screen Labels*/
  String get cardDetails;
  String get addCardNote;
  String get labelCardNumber;
  String get labelNameOnCard;
  String get labelExpiryMonth;
  String get labelExpiryYear;
  String get labelCvvNumber;
  String get hintCardNumber;
  String get hintCvvNumber;
  String get hintExpiryMonth;
  String get hintExpiryYear;
  String get msgEnterCardNumber;
  String get msgEnterExpiryMonth;
  String get msgInvalidExpiryMonth;
  String get msgEnterExpiryYear;
  String get msgInvalidExpiryYear;
  String get msgEnterCvvNumber;
  String get msgInvalidCvvNumber;
  String get labelAccountHolder;
  String get msgNoCardSelected;

  /* Bank related strings */
  String get labelBankName;
  String get labelAccountHolderName;
  String get labelAccountNumber;
  String get labelRoutingNumber;
  String get labelPayNowNote;
  String get labelShareViaSMS;
  String get labelShareViaOthers;
  String get labelAccountHolderC;
  String get labelAccountNumberC;
  String get labelExpiry;
  String get labelRecurring;
  String get labelPay;
  String get labelTotalAmount;
  String get labelTransactionCharge;
  String get labelTotalDeduction;
  String get labelClearAll;

  String get msgNoSelectedUser;

  String get msgAddBankBeforeCreateGroup;
  String get msgAddBankBeforeInvitations;

  String get msgShowInvitation;

  /*Chat*/
  String get chatTitle;
  String get typeYourMessage;
  String get noMessage;
  String get banking;
  String get debitAmount;

  String get msgAddNewBank;
  String get labelNewBank;
  String get labelExistingBank;

  String get msgGoBack;

  String get msgPaymentSuccess;
  String get msgPaymentFail;
  String get msgNoTransactionFound;
  String get msgAlreadyJoin;
  String get msgAlreadyDeclined;
  String get msgPaymentOwnTurn;

  String get msgAddCardBeforePay;
  String get lblEndDate;
  String get labOptional;

  String get msgBankAddSuccess;
  String get msgBankAddFailed;
  String get msgNoBankAdded;
  String get labelCreate;
  String get labelSubmitLower;

  String get alertSendInvitation;
  String getInvitationMsg(String message);

  String getPaymentSuccessFailedMsg(String success, String failed);
}
