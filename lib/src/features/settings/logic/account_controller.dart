import '../data/models/account_settings.dart';

class AccountController {
  final AccountSettings settings = AccountSettings();

  void toggleSecurityNotifications(bool value) {
    settings.securityNotifications = value;
  }

  void toggleTwoStepVerification(bool value) {
    settings.twoStepVerification = value;
  }
}
