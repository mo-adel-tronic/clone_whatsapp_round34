import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_ar.dart';
import 'l10n_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp Clone'**
  String get app_name;

  /// No description provided for @welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Instant WhatsApp'**
  String get welcome_title;

  /// No description provided for @welcome_btn.
  ///
  /// In en, this message translates to:
  /// **'Agree and Continue'**
  String get welcome_btn;

  /// No description provided for @policy_read.
  ///
  /// In en, this message translates to:
  /// **'Read our '**
  String get policy_read;

  /// No description provided for @policy_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy. '**
  String get policy_privacy;

  /// No description provided for @policy_tap.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Agree and continue\" to accept the '**
  String get policy_tap;

  /// No description provided for @policy_terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Services.'**
  String get policy_terms;

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get login_title;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your country code and enter your phone number'**
  String get login_subtitle;

  /// No description provided for @login_subtitle_link.
  ///
  /// In en, this message translates to:
  /// **'What\'s my number?'**
  String get login_subtitle_link;

  /// No description provided for @login_field_hint.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get login_field_hint;

  /// No description provided for @login_charges_info.
  ///
  /// In en, this message translates to:
  /// **'Carrier charges may apply'**
  String get login_charges_info;

  /// No description provided for @otp_page_title.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get otp_page_title;

  /// No description provided for @otp_page_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 6-digit verification code sent to your phone number.'**
  String get otp_page_subtitle;

  /// No description provided for @otp_page_resend_msg.
  ///
  /// In en, this message translates to:
  /// **'OTP has been resent.'**
  String get otp_page_resend_msg;

  /// No description provided for @otp_page_resend_btn.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get otp_page_resend_btn;

  /// No description provided for @otp_confirm_text.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your OTP code'**
  String get otp_confirm_text;

  /// No description provided for @linked_title.
  ///
  /// In en, this message translates to:
  /// **'Linked page'**
  String get linked_title;

  /// No description provided for @linked_desc1.
  ///
  /// In en, this message translates to:
  /// **'You can link other devices to this account.'**
  String get linked_desc1;

  /// No description provided for @linked_desc2.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get linked_desc2;

  /// No description provided for @linked_btn.
  ///
  /// In en, this message translates to:
  /// **'Link a device'**
  String get linked_btn;

  /// No description provided for @linked_status.
  ///
  /// In en, this message translates to:
  /// **'DEVICE STATUS'**
  String get linked_status;

  /// No description provided for @linked_status_text.
  ///
  /// In en, this message translates to:
  /// **'Tap a device to log out.'**
  String get linked_status_text;

  /// No description provided for @linked_device_name.
  ///
  /// In en, this message translates to:
  /// **'Windows'**
  String get linked_device_name;

  /// No description provided for @linked_device_active.
  ///
  /// In en, this message translates to:
  /// **'Last active today at 2:28 pm'**
  String get linked_device_active;

  /// No description provided for @linked_encryption1.
  ///
  /// In en, this message translates to:
  /// **'Your personal messages are '**
  String get linked_encryption1;

  /// No description provided for @linked_encryption2.
  ///
  /// In en, this message translates to:
  /// **'end-to-end encrypted'**
  String get linked_encryption2;

  /// No description provided for @linked_encryption3.
  ///
  /// In en, this message translates to:
  /// **'\n on all your devices.'**
  String get linked_encryption3;

  /// No description provided for @btn_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get btn_next;

  /// No description provided for @btn_loading.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get btn_loading;

  /// No description provided for @search_label.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_label;

  /// No description provided for @search_hint.
  ///
  /// In en, this message translates to:
  /// **'Start typing to search'**
  String get search_hint;

  /// No description provided for @error_auto_verify.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t automatically verify your phone number. Please enter it manually.'**
  String get error_auto_verify;

  /// No description provided for @error_verify_failed.
  ///
  /// In en, this message translates to:
  /// **'Verification failed. Please try again.'**
  String get error_verify_failed;

  /// No description provided for @error_unknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Please try again.'**
  String get error_unknown;

  /// No description provided for @error_country_code.
  ///
  /// In en, this message translates to:
  /// **'Invalid country code. Please check and try again.'**
  String get error_country_code;

  /// No description provided for @error_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number. Please check and try again.'**
  String get error_phone_number;

  /// No description provided for @error_phone_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number.'**
  String get error_phone_empty;

  /// No description provided for @error_otp_send_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send OTP. Please try again.'**
  String get error_otp_send_failed;

  /// No description provided for @error_otp_empty.
  ///
  /// In en, this message translates to:
  /// **'Please enter the OTP code.'**
  String get error_otp_empty;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return SAr();
    case 'en':
      return SEn();
  }

  throw FlutterError(
      'S.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
