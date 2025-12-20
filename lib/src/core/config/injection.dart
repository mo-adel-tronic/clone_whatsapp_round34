import 'package:clone_whatsapp_round34/src/core/config/config.dart';
import 'package:clone_whatsapp_round34/src/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DependencyInjection {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      AppLogger.f('Failed to load .env file: $e');
    }

    final supabaseUrl = dotenv.env['SUPABASE_PROJECT_URL'] ?? '';
    final supabaseAnonKey = dotenv.env['SUPABASE_Anon_KEY'] ?? '';

    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
    } catch (e) {
      AppLogger.f('Supabase initialization failed: $e');
    }
    await GetItInit.setup();
  }
}