import '../models/user_model.dart';
import '../models/course_model.dart';

class SampleDataService {
  // Singleton
  SampleDataService._();
  static final SampleDataService instance = SampleDataService._();

  // In-memory sample user
  UserModel user = UserModel(
    name: 'Abhi',
    xp: 120,
    streakDays: 3,
    level: 'Beginner',
  );

  // Sample progress
  int lessonsCompleted = 12;
  int lessonsTotal = 50;

  // Sample recently viewed
  List<String> recentlyViewed = ['Variables', 'Loops', 'Functions'];

  // Sample courses
  List<CourseModel> courses = [
    CourseModel(
      id: 'dart_vars',
      title: 'Dart Variables',
      subtitle: 'Beginner • 8 mins',
      lessonsCompleted: 3,
      lessonsTotal: 10,
      recommended: true,
    ),
    CourseModel(
      id: 'dart_oop',
      title: 'Dart OOP',
      subtitle: 'Intermediate • 20 mins',
      lessonsCompleted: 0,
      lessonsTotal: 8,
    ),
    CourseModel(
      id: 'flutter_layout',
      title: 'Flutter Layout',
      subtitle: 'Beginner • 12 mins',
      lessonsCompleted: 1,
      lessonsTotal: 6,
    ),
  ];

  // Methods to modify data (simulate progress)
  void earnXp(int points) {
    user.xp += points;
  }

  void completeLesson() {
    lessonsCompleted = (lessonsCompleted + 1).clamp(0, lessonsTotal);
  }
}
