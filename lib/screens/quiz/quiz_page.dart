import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  final String title;
  const QuizPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text(
              'Timer: 30s',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text('Question 1/10'),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: const Text('What is a variable?'),
              ),
            ),
            const SizedBox(height: 12),
            Column(
              children: [
                option('A', 'A container used to store data'),
                option('B', 'A loop'),
                option('C', 'A widget'),
                option('D', 'None of the above'),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Skip')),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget option(String label, String text) =>
      Card(child: ListTile(title: Text('$label. $text')));
}
