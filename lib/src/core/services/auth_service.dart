import 'package:clone_whatsapp_round34/src/core/constants/enums.dart';
import 'package:clone_whatsapp_round34/src/core/entities/app_user.dart';
import 'package:clone_whatsapp_round34/src/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthService {
  AppUser? get currentUser;
  
  String? get currentUserId;

  Future<Either<Failure, Unit>> signInWithPhone({required String phone});
  
  // إذا قررنا إرجاع مستخدم في المستقبل، سيكون AppUser أيضاً
  Future<Either<Failure, Unit>> verifyOtp({required String phone, required String token});
  
  Future<Either<Failure, Unit>> signOut();
  
  Stream<AuthStatus> get authStateChanges;
}