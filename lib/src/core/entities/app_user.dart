class AppUser {
  final String id;
  final String? email;
  final String? phone;
  final Map<String, dynamic>? metadata; // لتخزين أي بيانات إضافية

  const AppUser({
    required this.id,
    this.email,
    this.phone,
    this.metadata,
  });
}