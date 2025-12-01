import 'package:flutter/material.dart';
import '../../widgets/gamification_bar.dart';
import '../../widgets/continue_card.dart';
import '../../services/sample_data_service.dart';
import '../../models/course_model.dart';
import '../../models/user_model.dart';

class DashboardPage extends StatefulWidget {
  final String name;
  const DashboardPage({super.key, required this.name});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final SampleDataService _svc = SampleDataService.instance;
  late UserModel user;
  late int lessonsCompleted;
  late int lessonsTotal;
  late List<CourseModel> courses;
  late List<String> recentlyViewed;

  @override
  void initState() {
    super.initState();
    user = _svc.user;
    lessonsCompleted = _svc.lessonsCompleted;
    lessonsTotal = _svc.lessonsTotal;
    courses = _svc.courses;
    recentlyViewed = _svc.recentlyViewed;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Hub'),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (_) => [
              const PopupMenuItem(value: 1, child: Text('Profile')),
              const PopupMenuItem(value: 2, child: Text('Settings')),
              const PopupMenuItem(value: 3, child: Text('Dark Mode')),
              const PopupMenuItem(value: 4, child: Text('Logout')),
            ],
            icon: CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              child: Text(widget.name.isNotEmpty ? widget.name[0].toUpperCase() : '?'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi ${user.name} 👋',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Let's continue your Flutter journey!",
                style: TextStyle(fontSize: 14, color: theme.textTheme.bodySmall?.color),
              ),
              const SizedBox(height: 16),

              // Progress bar and summary
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Progress',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: lessonsTotal > 0 ? lessonsCompleted / lessonsTotal : 0),
                      const SizedBox(height: 8),
                      Text('$lessonsCompleted/$lessonsTotal Lessons Completed'),
                      const SizedBox(height: 8),
                      // Chapters / test scores / skill level
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Chapters: 3/12'),
                          Text('Tests: 2 | 78%'),
                          Text('Skill: ${user.level} → 32%'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Continue where you left off - improved card
              sectionTitle('Continue where you left off'),
              const SizedBox(height: 8),
              ContinueCard(
                title: courses.isNotEmpty ? courses[0].title : 'Dart Variables',
                subtitle: 'Video • 6 min left',
                progressPct: courses.isNotEmpty ? (courses[0].lessonsCompleted / courses[0].lessonsTotal) : 0.45,
                difficulty: user.level,
                thumbnailColor: theme.colorScheme.primary,
              ),

              const SizedBox(height: 12),

              // Today's Goal + XP
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Today\'s Learning Goal',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 8),
                      Text('⭐ Earn 20 XP today'),
                      SizedBox(height: 6),
                      Text('🔥 Daily streak: ${user.streakDays} days'),
                      SizedBox(height: 6),
                      Text('🎁 Unlock Badge: Variables Master!'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              sectionTitle('What do you want to learn?'),
              const SizedBox(height: 8),
              // Grid of topic cards (simplified)
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3 / 2,
                children: courses.map((c) => topicCard(context, c.title, Icons.play_arrow, tag: c.recommended ? 'Recommended' : null, progress: '${c.lessonsCompleted}/${c.lessonsTotal}')).toList(),
              ),

              const SizedBox(height: 12),

              sectionTitle('Quick Practice'),
              const SizedBox(height: 8),
              Row(
                children: [
                  quickButton(context, Icons.format_align_left, 'Flashcards'),
                  const SizedBox(width: 8),
                  quickButton(context, Icons.extension, 'Mini Challenges'),
                  const SizedBox(width: 8),
                  quickButton(context, Icons.quiz, 'Quiz of the Day'),
                ],
              ),

              const SizedBox(height: 12),

              sectionTitle('Recently Viewed'),
              const SizedBox(height: 8),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                      for (final r in recentlyViewed) ...[recentCard(r), const SizedBox(width: 8)],
                  ],
                ),
              ),

              const SizedBox(height: 12),

              sectionTitle('Recommended Courses for You'),
              const SizedBox(height: 8),
              Column(
                children: [
                  for (final c in courses) ...[courseCard(c.title, c.subtitle), const SizedBox(height: 8)],
                ],
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const GamificationBar(),
    );
  }

  Widget sectionTitle(String t) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Text(
      t,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    ),
  );

  Widget topicCard(
    BuildContext context,
    String title,
    IconData icon, {
    String? tag,
    String? progress,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const Spacer(),
            if (tag != null)
              Text(
                tag,
                style: const TextStyle(fontSize: 12, color: Colors.orange),
              ),
            if (progress != null && progress.isNotEmpty)
              Text(progress, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget quickButton(BuildContext context, IconData icon, String label) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }

  Widget recentCard(String title) => Container(
    width: 160,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        const Text('Lesson • 4 min'),
      ],
    ),
  );

  Widget courseCard(String title, String subtitle) => Card(
    child: ListTile(
      leading: Container(
        width: 48,
        height: 48,
        color: Colors.deepPurple,
        child: const Icon(Icons.play_arrow, color: Colors.white),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    ),
  );
}
