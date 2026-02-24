import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_lms/config/theme/theme_maneger.dart';
import 'package:school_lms/core/progress/progress_manager.dart';
import 'package:school_lms/core/routes/routes_manger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:school_lms/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ValueNotifier<Locale> appLocale = ValueNotifier(const Locale('en'));

final ValueNotifier<ThemeMode> appTheme = ValueNotifier(ThemeMode.light);

const _kLangKey  = 'selected_language';
const _kThemeKey = 'selected_theme';

Future<void> saveLocale(String languageCode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kLangKey, languageCode);
}

Future<void> saveTheme(ThemeMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kThemeKey, mode == ThemeMode.dark ? 'dark' : 'light');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  //locale
  final savedLang = prefs.getString(_kLangKey) ?? 'en';
  appLocale.value = Locale(savedLang);

  //theme
  final savedTheme = prefs.getString(_kThemeKey) ?? 'light';
  appTheme.value = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;

  await ProgressManager.init();
  runApp(const SchoolLms());
}

class SchoolLms extends StatelessWidget {
  const SchoolLms({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => ValueListenableBuilder<Locale>(
        valueListenable: appLocale,
        builder: (context, locale, _) => ValueListenableBuilder<ThemeMode>(
          valueListenable: appTheme,
          builder: (context, themeMode, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RoutesManger.getRoute,
            initialRoute: RoutesManger.onbourdingOne,
            locale: locale,
            theme: ThemeManger.light,
            darkTheme: ThemeManger.dark,
            themeMode: themeMode,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
          ),
        ),
      ),
    );
  }
}
