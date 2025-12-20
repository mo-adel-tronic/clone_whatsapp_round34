import 'dart:io';
import 'package:clone_whatsapp_round34/src/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class StorageService {
  Future<Either<Failure, String>> uploadFile({
    required File file,
    required String path,
    required String bucketName,
  });

  String getPublicUrl({
    required String path,
    required String bucketName,
  });

  Future<Either<Failure, Unit>> deleteFile({
    required String path, 
    required String bucketName,
  });
}