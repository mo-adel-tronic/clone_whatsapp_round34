import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_whatsapp_round34/src/core/localization/language_cubit.dart';
 //page to change app language from settings page
class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLang =
        context.watch<LanguageCubit>().state.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("App language"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          _languageTile(
            context,
            title: "English",
            value: "en",
            groupValue: currentLang,
          ),
          _languageTile(
            context,
            title: "العربية",
            value: "ar",
            groupValue: currentLang,
          ),
          _languageTile(
            context,
            title: "Español",
            value: "es",
            groupValue: currentLang,
          ),
          _languageTile(
            context,
            title: "Français",
            value: "fr",
            groupValue: currentLang,
          ),
          _languageTile(
            context,
            title: "Deutsch",
            value: "de",
            groupValue: currentLang,
          ),
          _languageTile(
            context,
            title: "हिन्दी",
            value: "hi",
            groupValue: currentLang,
          ),

        ],
      ),
    );
  }

  Widget _languageTile(
    BuildContext context, {
    required String title,
    required String value,
    required String groupValue,
  }) {
    return RadioListTile<String>(
      title: Text(title),
      value: value,
      groupValue: groupValue,
      onChanged: (val) {
        if (val != null) {
          context.read<LanguageCubit>().setLanguage(val);
        }
      },
    );
  }
}
