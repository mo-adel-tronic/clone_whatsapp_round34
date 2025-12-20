import 'package:clone_whatsapp_round34/src/core/constants/enums.dart';
import 'package:clone_whatsapp_round34/src/core/entities/app_user.dart';
import 'package:clone_whatsapp_round34/src/core/error/failure.dart';
import 'package:clone_whatsapp_round34/src/core/services/services.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class SupabaseAuthService implements AuthService {
  final supabase.SupabaseClient _supabase;

  SupabaseAuthService(this._supabase);

  @override
  AppUser? get currentUser {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;
    
    return AppUser(
      id: user.id,
      email: user.email,
      phone: user.phone,
      metadata: user.userMetadata,
    );
  }

  @override
  String? get currentUserId => _supabase.auth.currentUser?.id;

  @override
  Stream<AuthStatus> get authStateChanges {
    return _supabase.auth.onAuthStateChange.map((data) {
      final session = data.session;
      
      if (session != null) {
        return AuthStatus.authenticated;
      } else {
        return AuthStatus.unauthenticated;
      }
    });
  }

  @override
  Future<Either<Failure, Unit>> signInWithPhone({required String phone}) async {
    try {
      await _supabase.auth.signInWithOtp(phone: phone);
      return const Right(unit);
    } on supabase.AuthException catch (e) {
      return Left(AuthenticationFailure(e.message)); 
    } catch (e) {
      return Left(AuthenticationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyOtp({required String phone, required String token}) async {
    try {
      await _supabase.auth.verifyOTP(
        phone: phone, 
        token: token, 
        type: supabase.OtpType.sms,
      );
      return const Right(unit);
    } on supabase.AuthException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(AuthenticationFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await _supabase.auth.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(AuthenticationFailure(e.toString()));
    }
  }
  
}