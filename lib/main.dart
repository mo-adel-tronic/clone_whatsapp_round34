import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clone_whatsapp_round34/src/core/localization/language_cubit.dart';
import 'package:clone_whatsapp_round34/src/core/localization/language_data_source.dart';
import 'package:clone_whatsapp_round34/src/features/settings/presentation/pages/setting_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final languageDataSource = LanguageDataSource(prefs);

  // الحصول على اللغة المخزنة أو استخدام 'en' بشكل افتراضي
  final initialLang = languageDataSource.getLanguage();

  runApp(MyApp(
    languageDataSource: languageDataSource,
    initialLocale: Locale(initialLang),
  ));
}

class MyApp extends StatelessWidget {
  final LanguageDataSource languageDataSource;
  final Locale initialLocale;

  const MyApp({
    super.key,
    required this.languageDataSource,
    required this.initialLocale,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (_) => LanguageCubit(languageDataSource, initialLocale),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: locale,
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
              Locale('es'),
              Locale('fr'),
              Locale('de'),
              Locale('hi'),
            ],
            home: const SettingsPage(),
          );
        },
      ),
    );
  }
}
