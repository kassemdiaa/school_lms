class CourceModel {
  int id;
  String name;
  String instractorName;
  String imagePath;
  String coverPath;
  CourceModel({
    required this.name,
    required this.instractorName,
    required this.imagePath,
    required this.coverPath,
    required this.id,
  });

  static List<CourceModel> cources = [
    CourceModel(
      id: 0,
      name: 'Chemistry',
      instractorName: 'Ahmed Taha',
      imagePath: 'assets/chimstry.jpg',
      coverPath: 'assets/chimstrycover.jpg',
    ),
    CourceModel(
      id: 1,
      name: 'Physics',
      instractorName: 'Kassem Diaa',
      imagePath: 'assets/physics.jpg',
      coverPath: 'assets/physicscover.jpg',
    ),
    CourceModel(
      id: 2,
      name: 'English',
      instractorName: 'Salah Hosny',
      imagePath: 'assets/english.jpg',
      coverPath: 'assets/englishcover.jpg',
    ),
    CourceModel(
      id: 3,
      name: 'French',
      instractorName: 'Mohamed Elgendy',
      imagePath: 'assets/french.jpg',
      coverPath: 'assets/frenchcover.jpg',
    ),
    CourceModel(
      id: 4,
      name: 'Math',
      instractorName: 'Ali Hisham',
      imagePath: 'assets/math.jpg',
      coverPath: 'assets/mathcover.jpg',
    ),
    CourceModel(
      id: 5,
      name: 'Arabic',
      instractorName: 'Fathy Youssef',
      imagePath: 'assets/arabic.jpg',
      coverPath: 'assets/arabiccover.jpg',
    ),
  ];
}
