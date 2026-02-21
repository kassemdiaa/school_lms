import 'package:school_lms/models/chapter_model.dart';
import 'package:school_lms/models/question_model.dart';

class CourceModel {
  int id;
  String name;
  String instractorName;
  String imagePath;
  String coverPath;
  String description;
  List<ChapterModel> chapters;
  List<QuestionModel> questions;

  CourceModel({
    required this.name,
    required this.instractorName,
    required this.imagePath,
    required this.coverPath,
    required this.id,
    required this.description,
    required this.chapters,
    required this.questions,
  });

  static List<CourceModel> cources = [
    CourceModel(
      questions: [
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
      ],
      chapters: [
        ChapterModel(
          id: 0,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 1,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 2,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 3,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
      ],
      id: 0,
      name: 'Chemistry',
      instractorName: 'Ahmed Taha',
      imagePath: 'assets/chimstry.jpg',
      coverPath: 'assets/chimstrycover.jpg',
      description:
          'The "Central Science." Chemistry looks at the microscopic building blocks of everything. You’ll explore how atoms bond to create molecules—like why water behaves the way it does or how a battery stores energy. It’s about transformation and reactions.',
    ),
    CourceModel(
      questions: [
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
      ],
      chapters: [
        ChapterModel(
          id: 0,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 1,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 2,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 3,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
      ],
      id: 1,
      name: 'Physics',
      instractorName: 'Kassem Diaa',
      imagePath: 'assets/physics.jpg',
      coverPath: 'assets/physicscover.jpg',
      description:
          'The study of the "Rules of the Universe." From the way a football flies through the air to the way light travels through space, Physics uses math to explain motion, energy, and force. It’s about fundamental laws and logic.',
    ),
    CourceModel(
      questions: [
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
      ],
      chapters: [
        ChapterModel(
          id: 0,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 1,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 2,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 3,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
      ],
      id: 2,
      name: 'English',
      instractorName: 'Salah Hosny',
      imagePath: 'assets/english.jpg',
      coverPath: 'assets/englishcover.jpg',
      description:
          'This is the art of storytelling and critical thinking. You’ll dive into literature to understand the human condition and sharpen your writing to make sure your own voice is heard clearly. It’s about analysis—learning to see the "why" behind the "what."',
    ),
    CourceModel(
      questions: [
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
      ],
      chapters: [
        ChapterModel(
          id: 0,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 1,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 2,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 3,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
      ],
      id: 3,
      name: 'French',
      instractorName: 'Mohamed Elgendy',
      imagePath: 'assets/french.jpg',
      coverPath: 'assets/frenchcover.jpg',
      description:
          'Often called the "language of diplomacy." Beyond the romantic reputation, French is incredibly logical. It opens doors to European history, African commerce, and the world of high fashion and culinary arts. It’s about rhythm and nuance.',
    ),
    CourceModel(
      questions: [
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
      ],
      chapters: [
        ChapterModel(
          id: 0,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 1,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 2,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 3,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
      ],
      id: 4,
      name: 'Math',
      instractorName: 'Ali Hisham',
      imagePath: 'assets/math.jpg',
      coverPath: 'assets/mathcover.jpg',
      description:
          'Think of Math as the "Operating System" for all the other subjects. Without it, Physics has no formulas, and Chemistry has no measurements. It’s the purest form of problem-solving. Whether you’re dealing with Calculus or basic Algebra, you’re training your brain to think in steps and find patterns.',
    ),
    CourceModel(
      questions: [
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
        QuestionModel(question: 'question', answer: 'answer'),
      ],
      chapters: [
        ChapterModel(
          id: 0,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 1,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 2,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
        ChapterModel(
          id: 3,
          name: 'name',
          videoPath: 'videoPath',
          docPath: 'docPath',
        ),
      ],
      id: 5,
      name: 'Arabic',
      instractorName: 'Fathy Youssef',
      imagePath: 'assets/arabic.jpg',
      coverPath: 'assets/arabiccover.jpg',
      description:
          'A masterclass in linguistic precision and history. Known for its complex grammar (Nahw) and stunning poetry, Arabic is a bridge to one of the worlds oldest cultures. It challenges you to master depth and eloquence, whether through classical texts or modern media.',
    ),
  ];
}
