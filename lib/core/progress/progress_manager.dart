import 'package:shared_preferences/shared_preferences.dart';

/// Tracks which chapters have been passed (score > 50%) per course.
/// Persisted to device storage via SharedPreferences.
///
/// SETUP — pubspec.yaml:
///   shared_preferences: ^2.3.2
///
/// main.dart:
///   void main() async {
///     WidgetsFlutterBinding.ensureInitialized();
///     await ProgressManager.init();
///     runApp(const MyApp());
///   }
class ProgressManager {
  ProgressManager._();

  static const String _prefix = 'progress_';
  static final Map<int, Set<int>> _passedChapters = {};
  static SharedPreferences? _prefs; // ← reuse same instance, never call getInstance() twice

  /// Must be called once in main() before runApp.
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadAll();
  }

  // Read everything from prefs into memory cache
  static void _loadAll() {
    final keys = _prefs!.getKeys().where((k) => k.startsWith(_prefix));
    for (final key in keys) {
      final courseId = int.tryParse(key.replaceFirst(_prefix, ''));
      if (courseId == null) continue;
      final raw = _prefs!.getString(key) ?? '';
      _passedChapters[courseId] = raw
          .split(',')
          .where((s) => s.isNotEmpty)
          .map(int.tryParse)
          .whereType<int>()
          .toSet();
    }
  }

  /// Call this from ResultScreen when a student passes an exam.
  static Future<void> markChapterPassed(int courseId, int chapterId) async {
    _passedChapters.putIfAbsent(courseId, () => {}).add(chapterId);
    final value = _passedChapters[courseId]!.join(',');
    await _prefs!.setString('$_prefix$courseId', value);
  }

  /// Whether a specific chapter has been passed.
  static bool isChapterPassed(int courseId, int chapterId) =>
      _passedChapters[courseId]?.contains(chapterId) ?? false;

  /// How many chapters have been passed in this course.
  static int passedCount(int courseId) =>
      _passedChapters[courseId]?.length ?? 0;

  /// Progress as a fraction [0.0 – 1.0].
  static double progress(int courseId, int totalChapters) {
    if (totalChapters == 0) return 0;
    return passedCount(courseId) / totalChapters;
  }
}
