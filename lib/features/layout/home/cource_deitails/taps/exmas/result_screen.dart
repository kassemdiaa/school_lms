import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/exmas/answer_row.dart';
import 'package:school_lms/models/question_model.dart';
import 'package:school_lms/core/progress/progress_manager.dart';
import 'package:school_lms/l10n/app_localizations.dart';


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
                  EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
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
                      fontSize: 12.sp,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120.w,
                        height: 120.h,
                        child: CircularProgressIndicator(
                          value: score / total,
                          strokeWidth: 8.r,
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
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w800)),
                          Text('$score / $total',
                              style:  TextStyle(
                                  color: Theme.of(context).primaryColorLight, fontSize: 13.sp)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: passed
                          ? const Color(0xFF4CAF50).withOpacity(0.15)
                          : const Color(0xFFFF5252).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20.r),
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
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Answers list ───────────────────────────────────────────────
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.w, vertical: 16.h),
                itemCount: widget.questions.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, i) {
                  final q         = widget.questions[i];
                  final selected  = widget.selectedAnswers[i];
                  final isCorrect = selected == q.answer;
                  return Container(
                    padding: EdgeInsets.all(18.r),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(34, 0, 47, 150),
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                        width: 2.w,
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: isCorrect
                                    ? const Color(0xFF4CAF50)
                                        .withOpacity(0.15)
                                    : const Color(0xFFFF5252)
                                        .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8.r),
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
                                    size: 14.r,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    isCorrect ? l10n.correct : l10n.wrong,
                                    style: TextStyle(
                                      color: isCorrect
                                          ? const Color(0xFF4CAF50)
                                          : const Color(0xFFFF5252),
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text('${l10n.q}${i + 1}',
                                style:  TextStyle(
                                    color: Theme.of(context).primaryColorLight, fontSize: 12.sp)),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(q.question,
                            style:  TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 10.h),
                        if (!isCorrect) ...[
                          AnswerRow(
                            label: l10n.wrong,
                            value: selected ?? '',
                            color: const Color(0xFFFF5252),
                          ),
                          SizedBox(height: 6.h),
                        ],
                        AnswerRow(
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
              padding: EdgeInsets.all(20.r),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 52.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                  elevation: 0,
                ),
                child: Text(l10n.finish,
                    style:  TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 16.sp)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

