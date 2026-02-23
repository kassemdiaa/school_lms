import 'package:flutter/material.dart';
import 'package:school_lms/models/question_model.dart';
import 'package:school_lms/core/progress/progress_manager.dart';
import 'package:school_lms/l10n/app_localizations.dart';
import 'exam_screen.dart';

class ResultScreen extends StatefulWidget {
  final List<QuestionModel> questions;
  final Map<int, String> selectedAnswers;
  final int courseId;
  final int chapterId;

  const ResultScreen({
    super.key,
    required this.questions,
    required this.selectedAnswers,
    required this.courseId,
    required this.chapterId,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int get _score => widget.questions
      .asMap()
      .entries
      .where((e) => widget.selectedAnswers[e.key] == e.value.answer)
      .length;

  @override
  void initState() {
    super.initState();
    final percentage = (_score / widget.questions.length * 100).round();
    if (percentage > 50) {
      ProgressManager.markChapterPassed(widget.courseId, widget.chapterId)
          .then((_) { if (mounted) setState(() {}); });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n       = AppLocalizations.of(context)!;
    final score      = _score;
    final total      = widget.questions.length;
    final percentage = (score / total * 100).round();
    final passed     = percentage >= 60;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Score header ───────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: passed
                      ? [const Color(0xFF4CAF50), Theme.of(context).scaffoldBackgroundColor]
                      : [const Color(0xFF2E1A1A), Theme.of(context).scaffoldBackgroundColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    l10n.finish.toUpperCase(),
                    style: TextStyle(
                      color: passed
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFF2E1A1A),
                      fontSize: 12,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: score / total,
                          strokeWidth: 8,
                          backgroundColor: const Color(0xFF1E1D2E),
                          valueColor: AlwaysStoppedAnimation(
                            passed
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFFFF5252),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text('$percentage%',
                              style:  TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800)),
                          Text('$score / $total',
                              style:  TextStyle(
                                  color: Theme.of(context).primaryColorLight, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: passed
                          ? const Color(0xFF4CAF50).withOpacity(0.15)
                          : const Color(0xFFFF5252).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: passed
                            ? const Color(0xFF4CAF50).withOpacity(0.4)
                            : const Color(0xFFFF5252).withOpacity(0.4),
                      ),
                    ),
                    child: Text(
                      passed ? '🎉 ${l10n.passed}' : '❌ ${l10n.faild}',
                      style: TextStyle(
                        color: passed
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFFF5252),
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Answers list ───────────────────────────────────────────────
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 16),
                itemCount: widget.questions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final q         = widget.questions[i];
                  final selected  = widget.selectedAnswers[i];
                  final isCorrect = selected == q.answer;
                  return Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(34, 0, 47, 150),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        width: 2,
                        color: isCorrect
                            ? const Color(0xFF4CAF50).withOpacity(0.3)
                            : const Color(0xFFFF5252).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: isCorrect
                                    ? const Color(0xFF4CAF50)
                                        .withOpacity(0.15)
                                    : const Color(0xFFFF5252)
                                        .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isCorrect
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: isCorrect
                                        ? const Color(0xFF4CAF50)
                                        : const Color(0xFFFF5252),
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    isCorrect ? l10n.correct : l10n.wrong,
                                    style: TextStyle(
                                      color: isCorrect
                                          ? const Color(0xFF4CAF50)
                                          : const Color(0xFFFF5252),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text('${l10n.q}${i + 1}',
                                style:  TextStyle(
                                    color: Theme.of(context).primaryColorLight, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(q.question,
                            style:  TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        if (!isCorrect) ...[
                          _AnswerRow(
                            label: l10n.wrong,
                            value: selected ?? '',
                            color: const Color(0xFFFF5252),
                          ),
                          const SizedBox(height: 6),
                        ],
                        _AnswerRow(
                          label: l10n.correct,
                          value: q.answer,
                          color: const Color(0xFF4CAF50),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ── Continue button ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: Text(l10n.finish,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnswerRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _AnswerRow(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ',
            style: TextStyle(
                color: color.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.w600)),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  color: color, fontSize: 12, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
