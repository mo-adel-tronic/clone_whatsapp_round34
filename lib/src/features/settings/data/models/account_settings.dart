class AccountSettings {
  bool securityNotifications;
  bool twoStepVerification;

  AccountSettings({
    this.securityNotifications = true,
    this.twoStepVerification = false,
  });
}
