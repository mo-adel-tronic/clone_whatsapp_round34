import 'package:clone_whatsapp_round34/src/core/error/failure.dart';

import '../entities/entities.dart';
import '../repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetProfile {
  final ProfileRepository repository;

  GetProfile(this.repository);

  Future<Either<Failure, ProfileEntity>> call(String userId) async {
    return await repository.getProfile(userId);
  }
}
