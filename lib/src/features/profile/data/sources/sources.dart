 
import '../../domain/entities/entities.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileEntity> getProfile(String userId);
}
