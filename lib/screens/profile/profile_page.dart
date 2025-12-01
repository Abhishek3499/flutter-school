import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Profile')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 28, child: const Icon(Icons.person)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Abhishek',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text('Beginner • 42%'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('XP Progress'),
            const SizedBox(height: 8),
            const LinearProgressIndicator(value: 0.42),
            const SizedBox(height: 12),
            const Text('Stats'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text('Lessons: 12'), Text('Quizzes: 5')],
            ),
          ],
        ),
      ),
    );
  }
}
