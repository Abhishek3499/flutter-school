import 'package:flutter/material.dart';

class FlashcardsPage extends StatelessWidget {
  const FlashcardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcards - Dart Basics')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Flashcard: What is a variable?'),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: () {}, child: const Text('Flip')),
          ],
        ),
      ),
    );
  }
}
