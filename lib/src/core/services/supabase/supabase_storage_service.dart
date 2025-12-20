import 'dart:io';

import 'package:clone_whatsapp_round34/src/core/error/failure.dart';
import 'package:clone_whatsapp_round34/src/core/services/storage_service.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class SupabaseStorageService implements StorageService {
  final supabase.SupabaseClient _supabase;

  SupabaseStorageService(this._supabase);

  @override
  Future<Either<Failure, String>> uploadFile({
    required File file,
    required String path,
    required String bucketName,
  }) async {
    try {
      await _supabase.storage.from(bucketName).upload(
            path,
            file,
            fileOptions: const supabase.FileOptions(cacheControl: '3600', upsert: true),
          );
      final url = getPublicUrl(path: path, bucketName: bucketName);
      return Right(url);
      
    } on supabase.StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(StorageFailure("Image upload failed: $e"));
    }
  }

  @override
  String getPublicUrl({required String path, required String bucketName}) {
    return _supabase.storage.from(bucketName).getPublicUrl(path);
  }

  @override
  Future<Either<Failure, Unit>> deleteFile({
    required String path,
    required String bucketName,
  }) async {
    try {
      await _supabase.storage.from(bucketName).remove([path]);
      
      return const Right(unit);
      
    } on supabase.StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(StorageFailure("Delete failed: $e"));
    }
  }
}