import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/local/preference_utils.dart';

import 'package:shop_app/utils/lang/app_localization.dart';

final Locale systemLocale = WidgetsBinding.instance.window.locales.first;

final Locale defaultSupportedLocale = AppLocalizations.SUPPORTED_LOCALES.first;

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(defaultSupportedLocale) {
    getDefaultLanguage();
  }

  Future<void> getDefaultLanguage() async {
    Locale locale;
    final savedLanguageCode = await getLanguageFromPreference();
    if (savedLanguageCode == null) {
      for (var localItem in AppLocalizations.SUPPORTED_LOCALES) {
        if (localItem.languageCode == systemLocale.languageCode) {
          locale = systemLocale;
          break;
        } else {
          locale = defaultSupportedLocale;
        }
      }
    } else {
      locale = Locale(savedLanguageCode);
    }
    emit(locale);
  }

  Future<void> changeLanguage(SupportLanguage selectedLanguage) async {
    final savedLanguageCode = await getLanguageFromPreference();
    if (selectedLanguage == SupportLanguage.AR &&
        savedLanguageCode != CODE_AR) {
      saveLanguageToPreference(CODE_AR);
      emit(Locale(CODE_AR, CON_EG));
    } else if (selectedLanguage == SupportLanguage.EN &&
        savedLanguageCode != CODE_EN) {
      saveLanguageToPreference(CODE_EN);
      emit(const Locale(CODE_EN, CON_US));
    }
  }

  Future<void> saveLanguageToPreference(String languageCode) async {
    await PreferenceUtils.setLang(languageCode);
  }

  Future<String> getLanguageFromPreference() async {
    return PreferenceUtils.getLang();
  }
}

enum SupportLanguage { EN, AR }
