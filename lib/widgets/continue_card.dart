import 'package:flutter/material.dart';

class ContinueCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progressPct;
  final String difficulty;
  final Color thumbnailColor;

  const ContinueCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progressPct,
    required this.difficulty,
    required this.thumbnailColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // thumbnail
            Container(
              width: 84,
              height: 56,
              color: thumbnailColor,
              child: const Icon(Icons.play_arrow, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: progressPct),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      difficultyTag(difficulty),
                      const SizedBox(width: 8),
                      Text(
                        '${(progressPct * 100).round()}% completed',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget difficultyTag(String s) {
    Color c;
    if (s.toLowerCase().contains('beginner'))
      c = Colors.green;
    else if (s.toLowerCase().contains('inter'))
      c = Colors.orange;
    else
      c = Colors.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: c.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: c, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(s, style: TextStyle(color: c, fontSize: 12)),
        ],
      ),
    );
  }
}
