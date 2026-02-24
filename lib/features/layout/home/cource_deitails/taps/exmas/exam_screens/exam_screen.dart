import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/exmas/exam_screens/option_title.dart';
import 'package:school_lms/features/layout/home/cource_deitails/taps/exmas/result_screen/result_screen.dart';
import 'package:school_lms/models/chapter_model.dart';
import 'package:school_lms/l10n/app_localizations.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key, required this.chapter, required this.courseId});
  final ChapterModel chapter;
  final int courseId;
  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final Map<int, String> _selectedAnswers = {};
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _slideAnim = Tween<Offset>(
            begin: const Offset(0.1, 0), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  void _nextQuestion() {
    if (_currentIndex < widget.chapter.questions.length - 1) {
      _animController.reset();
      setState(() => _currentIndex++);
      _animController.forward();
    } else {
      _submitExam();
    }
  }

  void _prevQuestion() {
    if (_currentIndex > 0) {
      _animController.reset();
      setState(() => _currentIndex--);
      _animController.forward();
    }
  }

  void _submitExam() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          questions: widget.chapter.questions,
          selectedAnswers: _selectedAnswers,
          courseId: widget.courseId,
          chapterId: widget.chapter.id,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n     = AppLocalizations.of(context)!;
    final question = widget.chapter.questions[_currentIndex];
    final progress = (_currentIndex + 1) / widget.chapter.questions.length;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Counter ────────────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${_currentIndex + 1} / ${widget.chapter.questions.length}',
                      style:  TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // ── Progress bar ───────────────────────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6.h,
                  backgroundColor: const Color.fromARGB(34, 0, 47, 150),
                  valueColor:  AlwaysStoppedAnimation(
                      Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(height: 36.h),

              // ── Question card ──────────────────────────────────────────────
              FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(28.r),
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                          color: const Color(0xFF6C63FF).withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${l10n.question} ${_currentIndex + 1}',
                          style:  TextStyle(
                            color: Theme.of(context).canvasColor,
                            fontSize: 12.sp,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          question.question,
                          style:  TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.4.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              // ── Options ────────────────────────────────────────────────────
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: ListView.separated(
                    itemCount: question.options.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, i) {
                      final option = question.options[i];
                      final isSelected =
                          _selectedAnswers[_currentIndex] == option;
                      return OptionTile(
                        label: String.fromCharCode(65 + i),
                        text: option,
                        isSelected: isSelected,
                        onTap: () => setState(
                            () => _selectedAnswers[_currentIndex] = option),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // ── Navigation buttons ─────────────────────────────────────────
              Row(
                children: [
                  if (_currentIndex > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _prevQuestion,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Color(0xFF2E2D42)),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r)),
                        ),
                        child: Text('← ${l10n.back}',style: TextStyle(color: Theme.of(context).primaryColorLight),),
                      ),
                    ),
                  if (_currentIndex > 0) SizedBox(width: 12.w),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed:
                          _selectedAnswers.containsKey(_currentIndex)
                              ? _nextQuestion
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFF2E2D42),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r)),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentIndex ==
                                widget.chapter.questions.length - 1
                            ? '${l10n.submit} →'
                            : '${l10n.next} →',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

