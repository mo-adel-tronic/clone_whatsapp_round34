import 'package:clone_whatsapp_round34/src/core/localization/localization.dart';
import 'package:clone_whatsapp_round34/src/core/services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

class GetItInit {
  static Future<void> setup() async {
    // ! ===================== Core =====================
    // Localization Service
    getIt.registerLazySingleton<LanguageDataSource>(
        () => LanguageDataSource(getIt<SharedPreferences>()));
    getIt.registerFactory<LanguageCubit>(() => LanguageCubit(
          getIt<LanguageDataSource>(),
          Locale(getIt<LanguageDataSource>().getLanguage()),
        ));

    // ! ===================== Services =====================
    // Auth Services
    getIt.registerLazySingleton<AuthService>(
      () => SupabaseAuthService(getIt()),
    );
    // Storage Services
    getIt.registerLazySingleton<StorageService>(
      () => SupabaseStorageService(getIt()),
    );
    // Validation Services
    getIt.registerLazySingleton<PhoneNumberService>(
        () => PhoneNumbersParserService());
    // Database Services
    getIt.registerLazySingleton<DatabaseService>(
      () => SupabaseDatabaseService(getIt()),
    );

    // ! ===================== External =====================
    // SupabaseClient
    getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
    // SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => prefs);
  }
}
