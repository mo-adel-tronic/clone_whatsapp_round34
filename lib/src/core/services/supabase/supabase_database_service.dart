import 'package:clone_whatsapp_round34/src/core/error/failure.dart';
import 'package:clone_whatsapp_round34/src/core/services/database_service.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class SupabaseDatabaseService implements DatabaseService {
  final supabase.SupabaseClient _supabase;

  SupabaseDatabaseService(this._supabase);

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getData({
    required String table,
    String? orderBy,
    bool descending = false,
    int? limit,
    Map<String, dynamic>? equalFilters,
  }) async {
    try {
      dynamic query = _supabase.from(table).select();

      if (equalFilters != null) {
        equalFilters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }

      if (orderBy != null) {
        query = query.order(orderBy, ascending: !descending);
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final resp = await query.execute();
      final raw = resp.data as List<dynamic>?;
      final List<Map<String, dynamic>> result = raw == null
          ? <Map<String, dynamic>>[]
          : raw.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      return Right(result);
      
    } on supabase.PostgrestException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveData({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _supabase.from(table).insert(data);
      return const Right(unit);
    } on supabase.PostgrestException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateData({
    required String table,
    required Map<String, dynamic> data,
    required String docId,
  }) async {
    try {
      await _supabase.from(table).update(data).eq('id', docId);
      return const Right(unit);
    } on supabase.PostgrestException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteData({
    required String table,
    required String docId,
  }) async {
    try {
      await _supabase.from(table).delete().eq('id', docId);
      return const Right(unit);
    } on supabase.PostgrestException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
  
  @override
  Stream<List<Map<String, dynamic>>> streamData({
    required String table,
    String primaryKey = 'id',
  }) {
    return _supabase.from(table).stream(primaryKey: [primaryKey]);
  }
}