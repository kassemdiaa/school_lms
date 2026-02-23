import 'package:flutter/material.dart';
import 'package:school_lms/models/chapter_model.dart';
import 'package:school_lms/models/question_model.dart';
import 'package:school_lms/l10n/app_localizations.dart';

class CourceModel {
  int id;
  String name;
  String instractorName;
  String imagePath;
  String coverPath;
  String description;
  List<ChapterModel> chapters;

  CourceModel({
    required this.name,
    required this.instractorName,
    required this.imagePath,
    required this.coverPath,
    required this.id,
    required this.description,
    required this.chapters,
  });

  // ── Shared chapters template (same questions for all courses) ──────────────
  static List<ChapterModel> _buildChapters() => [
        ChapterModel(
          id: 0, name: 'name', videoPath: 'assets/vid.mp4', docPath: 'assets/cv.pdf',
          questions: [
            QuestionModel(question: 'What is the capital of France?', answer: 'Paris',
                options: ['London', 'Berlin', 'Paris', 'Madrid']),
            QuestionModel(question: 'Which data structure uses LIFO order?', answer: 'Stack',
                options: ['Queue', 'Stack', 'Tree', 'Graph']),
            QuestionModel(question: 'What does HTTP stand for?', answer: 'HyperText Transfer Protocol',
                options: ['HyperText Transfer Protocol', 'High Transfer Text Protocol',
                  'Hyper Transfer Text Process', 'HyperText Transport Process']),
            QuestionModel(question: 'Which planet is known as the Red Planet?', answer: 'Mars',
                options: ['Venus', 'Jupiter', 'Mars', 'Saturn']),
            QuestionModel(question: 'What is 2^10?', answer: '1024',
                options: ['512', '1024', '2048', '256']),
          ],
        ),
        ChapterModel(
          id: 1, name: 'name', videoPath: 'assets/vid.mp4', docPath: 'assets/cv.pdf',
          questions: [
            QuestionModel(question: 'What is the capital of France?', answer: 'Paris',
                options: ['London', 'Berlin', 'Paris', 'Madrid']),
            QuestionModel(question: 'Which data structure uses LIFO order?', answer: 'Stack',
                options: ['Queue', 'Stack', 'Tree', 'Graph']),
            QuestionModel(question: 'What does HTTP stand for?', answer: 'HyperText Transfer Protocol',
                options: ['HyperText Transfer Protocol', 'High Transfer Text Protocol',
                  'Hyper Transfer Text Process', 'HyperText Transport Process']),
            QuestionModel(question: 'Which planet is known as the Red Planet?', answer: 'Mars',
                options: ['Venus', 'Jupiter', 'Mars', 'Saturn']),
            QuestionModel(question: 'What is 2^10?', answer: '1024',
                options: ['512', '1024', '2048', '256']),
          ],
        ),
        ChapterModel(
          id: 2, name: 'name', videoPath: 'assets/vid.mp4', docPath: 'assets/cv.pdf',
          questions: [
            QuestionModel(question: 'What is the capital of France?', answer: 'Paris',
                options: ['London', 'Berlin', 'Paris', 'Madrid']),
            QuestionModel(question: 'Which data structure uses LIFO order?', answer: 'Stack',
                options: ['Queue', 'Stack', 'Tree', 'Graph']),
            QuestionModel(question: 'What does HTTP stand for?', answer: 'HyperText Transfer Protocol',
                options: ['HyperText Transfer Protocol', 'High Transfer Text Protocol',
                  'Hyper Transfer Text Process', 'HyperText Transport Process']),
            QuestionModel(question: 'Which planet is known as the Red Planet?', answer: 'Mars',
                options: ['Venus', 'Jupiter', 'Mars', 'Saturn']),
            QuestionModel(question: 'What is 2^10?', answer: '1024',
                options: ['512', '1024', '2048', '256']),
          ],
        ),
        ChapterModel(
          id: 3, name: 'name', videoPath: 'assets/vid.mp4', docPath: 'assets/cv.pdf',
          questions: [
            QuestionModel(question: 'What is the capital of France?', answer: 'Paris',
                options: ['London', 'Berlin', 'Paris', 'Madrid']),
            QuestionModel(question: 'Which data structure uses LIFO order?', answer: 'Stack',
                options: ['Queue', 'Stack', 'Tree', 'Graph']),
            QuestionModel(question: 'What does HTTP stand for?', answer: 'HyperText Transfer Protocol',
                options: ['HyperText Transfer Protocol', 'High Transfer Text Protocol',
                  'Hyper Transfer Text Process', 'HyperText Transport Process']),
            QuestionModel(question: 'Which planet is known as the Red Planet?', answer: 'Mars',
                options: ['Venus', 'Jupiter', 'Mars', 'Saturn']),
            QuestionModel(question: 'What is 2^10?', answer: '1024',
                options: ['512', '1024', '2048', '256']),
          ],
        ),
      ];

  // ── Localized list — call this instead of the old static `cources` field ──
  static List<CourceModel> getCources(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      CourceModel(
        id: 0,
        name: l10n.chemistry,
        instractorName: 'Ahmed Taha',
        imagePath: 'assets/chimstry.jpg',
        coverPath: 'assets/chimstrycover.jpg',
        description:
            'The "Central Science." Chemistry looks at the microscopic building blocks of everything. You\'ll explore how atoms bond to create molecules—like why water behaves the way it does or how a battery stores energy.',
        chapters: _buildChapters(),
      ),
      CourceModel(
        id: 1,
        name: l10n.physics,
        instractorName: 'Ahmed Taha',
        imagePath: 'assets/physics.jpg',
        coverPath: 'assets/physicscover.jpg',
        description:
            'Physics is the study of matter, energy, and the fundamental forces of nature. From classical mechanics to quantum theory, you\'ll explore how the universe works at every scale.',
        chapters: _buildChapters(),
      ),
      CourceModel(
        id: 2,
        name: l10n.english,
        instractorName: 'Sara Ali',
        imagePath: 'assets/english.jpg',
        coverPath: 'assets/englishcover.jpg',
        description:
            'Master the English language through grammar, vocabulary, reading comprehension, and writing skills. A gateway to global communication and literature.',
        chapters: _buildChapters(),
      ),
      CourceModel(
        id: 3,
        name: l10n.french,
        instractorName: 'Marie Dupont',
        imagePath: 'assets/french.jpg',
        coverPath: 'assets/frenchcover.jpg',
        description:
            'French is the language of diplomacy, art, and culture. Learn to speak, read, and write in one of the most romantic languages in the world.',
        chapters: _buildChapters(),
      ),
      CourceModel(
        id: 4,
        name: l10n.math,
        instractorName: 'Ali Hisham',
        imagePath: 'assets/math.jpg',
        coverPath: 'assets/mathcover.jpg',
        description:
            'Think of Math as the "Operating System" for all other subjects. Whether you\'re dealing with Calculus or basic Algebra, you\'re training your brain to think in steps and find patterns.',
        chapters: _buildChapters(),
      ),
      CourceModel(
        id: 5,
        name: l10n.arabic,
        instractorName: 'Fathy Youssef',
        imagePath: 'assets/arabic.jpg',
        coverPath: 'assets/arabiccover.jpg',
        description:
            'A masterclass in linguistic precision and history. Known for its complex grammar and stunning poetry, Arabic is a bridge to one of the world\'s oldest cultures.',
        chapters: _buildChapters(),
      ),
    ];
  }
}
