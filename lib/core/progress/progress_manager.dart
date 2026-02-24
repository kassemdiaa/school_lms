import 'package:shared_preferences/shared_preferences.dart';

class ProgressManager {
  ProgressManager._();

  static const String _prefix = 'progress_';
  static final Map<int, Set<int>> _passedChapters = {};
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadAll();
  }

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

  static Future<void> markChapterPassed(int courseId, int chapterId) async {
    _passedChapters.putIfAbsent(courseId, () => {}).add(chapterId);
    final value = _passedChapters[courseId]!.join(',');
    await _prefs!.setString('$_prefix$courseId', value);
  }

  static bool isChapterPassed(int courseId, int chapterId) =>
      _passedChapters[courseId]?.contains(chapterId) ?? false;

  static int passedCount(int courseId) =>
      _passedChapters[courseId]?.length ?? 0;

  static double progress(int courseId, int totalChapters) {
    if (totalChapters == 0) return 0;
    return passedCount(courseId) / totalChapters;
  }
}
