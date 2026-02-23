import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_lms/config/theme/theme_maneger.dart';
import 'package:school_lms/core/progress/progress_manager.dart';
import 'package:school_lms/core/routes/routes_manger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:school_lms/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── Global locale notifier ─────────────────────────────────────────────────────
final ValueNotifier<Locale> appLocale = ValueNotifier(const Locale('en'));

// ── Key used to persist the language choice ────────────────────────────────────
const _kLangKey = 'selected_language';

// ── Save chosen language to SharedPreferences ──────────────────────────────────
Future<void> saveLocale(String languageCode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_kLangKey, languageCode);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved language (defaults to 'en' if never set)
  final prefs = await SharedPreferences.getInstance();
  final savedLang = prefs.getString(_kLangKey) ?? 'en';
  appLocale.value = Locale(savedLang);

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
        builder: (context, locale, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RoutesManger.getRoute,
          initialRoute: RoutesManger.onbourdingOne,
          locale: locale,
          theme: ThemeManger.light,
          darkTheme: ThemeManger.dark,
          themeMode: ThemeMode.dark,
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
    );
  }
}
