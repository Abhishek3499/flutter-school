import 'package:flutter/material.dart';

class GamificationBar extends StatelessWidget {
  const GamificationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          gamItem(Icons.emoji_events, 'Badges', '3'),
          gamItem(Icons.local_fire_department, 'Streak', '3d'),
          gamItem(Icons.star, 'XP', '120'),
          gamItem(Icons.question_answer, 'Quizzes', '5'),
        ],
      ),
    );
  }

  Widget gamItem(IconData icon, String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
