import 'package:dartz/dartz.dart';
import 'package:clone_whatsapp_round34/src/core/error/failure.dart';
import '../../domain/entities/entities.dart';
import '../sources/sources.dart';
import '../../domain/repositories/repositories.dart';

class ProfileRepositoryImp implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> getProfile(String userId) async {
    try {
      final profile = await remoteDataSource.getProfile(userId);
      return Right(profile);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));

    }
  }
}
