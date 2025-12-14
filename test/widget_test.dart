// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:clone_whatsapp_round34/main.dart';
import 'package:clone_whatsapp_round34/src/core/constants/constants.dart';
import 'package:clone_whatsapp_round34/src/core/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('LanguagePage shows up and allows changing language',
      (WidgetTester tester) async {
    // Mock SharedPreferences for testing
    SharedPreferences.setMockInitialValues(
        {PreferencesKey.appLanguage: 'en'});
    final prefs = await SharedPreferences.getInstance();
    final languageDataSource = LanguageDataSource(prefs);

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
        languageDataSource: languageDataSource, initialLocale: const Locale('en')));
    // Verify that LanguagePage is shown
    expect(find.text('App language'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
  });
}
