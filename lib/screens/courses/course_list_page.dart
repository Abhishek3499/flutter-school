import 'package:flutter/material.dart';

class CourseListPage extends StatelessWidget {
  const CourseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dart Learning Track')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          courseTile('Dart Variables', 'Beginner • 8 mins', 3, 10),
          courseTile('Dart OOP', 'Intermediate • 20 mins', 0, 8),
          courseTile('Flutter Basics', 'Beginner • 12 mins', 1, 6),
        ],
      ),
    );
  }

  Widget courseTile(String title, String subtitle, int done, int total) => Card(
    child: ListTile(
      leading: Container(width: 56, height: 56, color: Colors.deepPurple),
      title: Text(title),
      subtitle: Text('$subtitle \nProgress: $done/$total'),
      isThreeLine: true,
      trailing: const Icon(Icons.chevron_right),
    ),
  );
}
