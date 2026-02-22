import 'package:school_lms/models/question_model.dart';

class ChapterModel {
  String name;
  int id;
  String videoPath;
  String docPath;
  List<QuestionModel> questions;
  ChapterModel({
    required this.id,
    required this.name,
    required this.videoPath,
    required this.docPath,
    required this.questions
  });
}
