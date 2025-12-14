import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_data_source.dart';

class LanguageCubit extends Cubit<Locale> {
  final LanguageDataSource languageDataSource;

  LanguageCubit(this.languageDataSource, Locale initial) : super(initial);

  void getLanguage() {
    final lang = languageDataSource.getLanguage();
    emit(Locale(lang));
  }

  Future<void> setLanguage(String lang) async {
    await languageDataSource.setLanguage(lang);
    emit(Locale(lang));
  }
}
