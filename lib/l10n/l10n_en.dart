// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'WhatsApp Clone';

  @override
  String get welcome_title => 'Welcome to Instant WhatsApp';

  @override
  String get welcome_btn => 'Agree and Continue';

  @override
  String get policy_read => 'Read our ';

  @override
  String get policy_privacy => 'Privacy Policy. ';

  @override
  String get policy_tap => 'Tap \"Agree and continue\" to accept the ';

  @override
  String get policy_terms => 'Terms of Services.';

  @override
  String get login_title => 'Enter your phone number';

  @override
  String get login_subtitle =>
      'Please confirm your country code and enter your phone number';

  @override
  String get login_subtitle_link => 'What\'s my number?';

  @override
  String get login_field_hint => 'Phone number';

  @override
  String get login_charges_info => 'Carrier charges may apply';

  @override
  String get otp_page_title => 'Enter OTP';

  @override
  String get otp_page_subtitle =>
      'Please enter the 6-digit verification code sent to your phone number.';

  @override
  String get otp_page_resend_msg => 'OTP has been resent.';

  @override
  String get otp_page_resend_btn => 'Resend code';

  @override
  String get otp_confirm_text => 'Please confirm your OTP code';

  @override
  String get linked_title => 'Linked page';

  @override
  String get linked_desc1 => 'You can link other devices to this account.';

  @override
  String get linked_desc2 => 'Learn more';

  @override
  String get linked_btn => 'Link a device';

  @override
  String get linked_status => 'DEVICE STATUS';

  @override
  String get linked_status_text => 'Tap a device to log out.';

  @override
  String get linked_device_name => 'Windows';

  @override
  String get linked_device_active => 'Last active today at 2:28 pm';

  @override
  String get linked_encryption1 => 'Your personal messages are ';

  @override
  String get linked_encryption2 => 'end-to-end encrypted';

  @override
  String get linked_encryption3 => '\n on all your devices.';

  @override
  String get btn_next => 'Next';

  @override
  String get btn_loading => 'Processing...';

  @override
  String get search_label => 'Search';

  @override
  String get search_hint => 'Start typing to search';

  @override
  String get error_auto_verify =>
      'We couldn\'t automatically verify your phone number. Please enter it manually.';

  @override
  String get error_verify_failed => 'Verification failed. Please try again.';

  @override
  String get error_unknown => 'An unknown error occurred. Please try again.';

  @override
  String get error_country_code =>
      'Invalid country code. Please check and try again.';

  @override
  String get error_phone_number =>
      'Invalid phone number. Please check and try again.';

  @override
  String get error_phone_empty => 'Please enter your phone number.';

  @override
  String get error_otp_send_failed => 'Failed to send OTP. Please try again.';

  @override
  String get error_otp_empty => 'Please enter the OTP code.';
}
