// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `WhatsApp Clone`
  String get app_name {
    return Intl.message('WhatsApp Clone', name: 'app_name', desc: '', args: []);
  }

  /// `Welcome to Instant WhatsApp`
  String get welcome_title {
    return Intl.message(
      'Welcome to Instant WhatsApp',
      name: 'welcome_title',
      desc: '',
      args: [],
    );
  }

  /// `Agree and Continue`
  String get welcome_btn {
    return Intl.message(
      'Agree and Continue',
      name: 'welcome_btn',
      desc: '',
      args: [],
    );
  }

  /// `Read our `
  String get policy_read {
    return Intl.message('Read our ', name: 'policy_read', desc: '', args: []);
  }

  /// `Privacy Policy. `
  String get policy_privacy {
    return Intl.message(
      'Privacy Policy. ',
      name: 'policy_privacy',
      desc: '',
      args: [],
    );
  }

  /// `Tap "Agree and continue" to accept the `
  String get policy_tap {
    return Intl.message(
      'Tap "Agree and continue" to accept the ',
      name: 'policy_tap',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Services.`
  String get policy_terms {
    return Intl.message(
      'Terms of Services.',
      name: 'policy_terms',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get login_title {
    return Intl.message(
      'Enter your phone number',
      name: 'login_title',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your country code and enter your phone number`
  String get login_subtitle {
    return Intl.message(
      'Please confirm your country code and enter your phone number',
      name: 'login_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `What's my number?`
  String get login_subtitle_link {
    return Intl.message(
      'What\'s my number?',
      name: 'login_subtitle_link',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get login_field_hint {
    return Intl.message(
      'Phone number',
      name: 'login_field_hint',
      desc: '',
      args: [],
    );
  }

  /// `Carrier charges may apply`
  String get login_charges_info {
    return Intl.message(
      'Carrier charges may apply',
      name: 'login_charges_info',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP`
  String get otp_page_title {
    return Intl.message(
      'Enter OTP',
      name: 'otp_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the 6-digit verification code sent to your phone number.`
  String get otp_page_subtitle {
    return Intl.message(
      'Please enter the 6-digit verification code sent to your phone number.',
      name: 'otp_page_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `OTP has been resent.`
  String get otp_page_resend_msg {
    return Intl.message(
      'OTP has been resent.',
      name: 'otp_page_resend_msg',
      desc: '',
      args: [],
    );
  }

  /// `Resend code`
  String get otp_page_resend_btn {
    return Intl.message(
      'Resend code',
      name: 'otp_page_resend_btn',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your OTP code`
  String get otp_confirm_text {
    return Intl.message(
      'Please confirm your OTP code',
      name: 'otp_confirm_text',
      desc: '',
      args: [],
    );
  }

  /// `Linked page`
  String get linked_title {
    return Intl.message(
      'Linked page',
      name: 'linked_title',
      desc: '',
      args: [],
    );
  }

  /// `You can link other devices to this account.`
  String get linked_desc1 {
    return Intl.message(
      'You can link other devices to this account.',
      name: 'linked_desc1',
      desc: '',
      args: [],
    );
  }

  /// `Learn more`
  String get linked_desc2 {
    return Intl.message('Learn more', name: 'linked_desc2', desc: '', args: []);
  }

  /// `Link a device`
  String get linked_btn {
    return Intl.message(
      'Link a device',
      name: 'linked_btn',
      desc: '',
      args: [],
    );
  }

  /// `DEVICE STATUS`
  String get linked_status {
    return Intl.message(
      'DEVICE STATUS',
      name: 'linked_status',
      desc: '',
      args: [],
    );
  }

  /// `Tap a device to log out.`
  String get linked_status_text {
    return Intl.message(
      'Tap a device to log out.',
      name: 'linked_status_text',
      desc: '',
      args: [],
    );
  }

  /// `Windows`
  String get linked_device_name {
    return Intl.message(
      'Windows',
      name: 'linked_device_name',
      desc: '',
      args: [],
    );
  }

  /// `Last active today at 2:28 pm`
  String get linked_device_active {
    return Intl.message(
      'Last active today at 2:28 pm',
      name: 'linked_device_active',
      desc: '',
      args: [],
    );
  }

  /// `Your personal messages are `
  String get linked_encryption1 {
    return Intl.message(
      'Your personal messages are ',
      name: 'linked_encryption1',
      desc: '',
      args: [],
    );
  }

  /// `end-to-end encrypted`
  String get linked_encryption2 {
    return Intl.message(
      'end-to-end encrypted',
      name: 'linked_encryption2',
      desc: '',
      args: [],
    );
  }

  /// `\n on all your devices.`
  String get linked_encryption3 {
    return Intl.message(
      '\n on all your devices.',
      name: 'linked_encryption3',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get btn_next {
    return Intl.message('Next', name: 'btn_next', desc: '', args: []);
  }

  /// `Processing...`
  String get btn_loading {
    return Intl.message(
      'Processing...',
      name: 'btn_loading',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search_label {
    return Intl.message('Search', name: 'search_label', desc: '', args: []);
  }

  /// `Start typing to search`
  String get search_hint {
    return Intl.message(
      'Start typing to search',
      name: 'search_hint',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't automatically verify your phone number. Please enter it manually.`
  String get error_auto_verify {
    return Intl.message(
      'We couldn\'t automatically verify your phone number. Please enter it manually.',
      name: 'error_auto_verify',
      desc: '',
      args: [],
    );
  }

  /// `Verification failed. Please try again.`
  String get error_verify_failed {
    return Intl.message(
      'Verification failed. Please try again.',
      name: 'error_verify_failed',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error occurred. Please try again.`
  String get error_unknown {
    return Intl.message(
      'An unknown error occurred. Please try again.',
      name: 'error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Invalid country code. Please check and try again.`
  String get error_country_code {
    return Intl.message(
      'Invalid country code. Please check and try again.',
      name: 'error_country_code',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number. Please check and try again.`
  String get error_phone_number {
    return Intl.message(
      'Invalid phone number. Please check and try again.',
      name: 'error_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number.`
  String get error_phone_empty {
    return Intl.message(
      'Please enter your phone number.',
      name: 'error_phone_empty',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send OTP. Please try again.`
  String get error_otp_send_failed {
    return Intl.message(
      'Failed to send OTP. Please try again.',
      name: 'error_otp_send_failed',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the OTP code.`
  String get error_otp_empty {
    return Intl.message(
      'Please enter the OTP code.',
      name: 'error_otp_empty',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
