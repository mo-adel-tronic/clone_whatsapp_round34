 
import 'package:clone_whatsapp_round34/src/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../entities/entities.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile(String userId);
}
