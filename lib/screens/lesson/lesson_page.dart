import 'package:flutter/material.dart';

class LessonPage extends StatelessWidget {
  final String title;
  const LessonPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category: Dart Basics',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const LinearProgressIndicator(value: 0.2),
            const SizedBox(height: 8),
            const Text('Estimated time: 9 mins left'),
            const SizedBox(height: 12),
            Container(
              height: 180,
              color: Colors.black12,
              child: const Center(child: Icon(Icons.play_arrow, size: 48)),
            ),
            const SizedBox(height: 12),
            const Text(
              'Lesson Sections',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              '- What are variables?\n- Syntax\n- Examples\n- Practice tasks\n- Common mistakes',
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Take Practice Quiz'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.bookmark),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
