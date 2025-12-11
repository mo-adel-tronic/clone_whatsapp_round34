import '../../domain/entities/entities.dart';

class ProfileModel {
  final String name;
  final String phone;

  ProfileModel({
    required this.name,
    required this.phone,
  });

  // تحويل JSON إلى Model
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  // تحويل Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  // تحويل Model إلى Entity
  ProfileEntity toEntity() {
    return ProfileEntity(
      name: name,
      phone: phone,
      avatarLetter: name.isNotEmpty ? name[0].toUpperCase() : '',
    );
  }
}
