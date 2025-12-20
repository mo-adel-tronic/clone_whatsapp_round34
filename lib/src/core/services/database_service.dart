import 'package:clone_whatsapp_round34/src/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class DatabaseService {
  Future<Either<Failure, List<Map<String, dynamic>>>> getData({
    required String table,
    String? orderBy,
    bool descending = false,
    int? limit,
    Map<String, dynamic>? equalFilters,
  });

  Future<Either<Failure, Unit>> saveData({
    required String table,
    required Map<String, dynamic> data,
  });

  Future<Either<Failure, Unit>> updateData({
    required String table,
    required Map<String, dynamic> data,
    required String docId,
  });
  
  Future<Either<Failure, Unit>> deleteData({
    required String table,
    required String docId,
  });
  
  Stream<List<Map<String, dynamic>>> streamData({
    required String table,
    String primaryKey = 'id',
  });
}