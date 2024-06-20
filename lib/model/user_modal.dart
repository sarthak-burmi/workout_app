import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String number;

  @HiveField(3)
  int age;

  @HiveField(4)
  double height;

  @HiveField(5)
  double weight;

  @HiveField(6)
  String sex;

  @HiveField(7)
  List<String> completedExercises;

  @HiveField(8)
  bool enableBackgroundMusic;

  User({
    required this.name,
    required this.email,
    required this.number,
    required this.age,
    required this.height,
    required this.weight,
    required this.sex,
    List<String>? completedExercises,
    bool? enableBackgroundMusic,
  })  : this.completedExercises = completedExercises ?? [],
        this.enableBackgroundMusic = enableBackgroundMusic ?? true;

  void addCompletedExercise(String exerciseName) {
    if (!completedExercises.contains(exerciseName)) {
      completedExercises.add(exerciseName);
    }
  }

  bool isExerciseCompleted(String exerciseName) {
    return completedExercises.contains(exerciseName);
  }
}
