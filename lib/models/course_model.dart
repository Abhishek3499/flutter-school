class CourseModel {
  final String id;
  final String title;
  final String subtitle;
  final int lessonsCompleted;
  final int lessonsTotal;
  final bool recommended;

  CourseModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.lessonsCompleted,
    required this.lessonsTotal,
    this.recommended = false,
  });
}
