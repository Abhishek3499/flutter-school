import 'package:flutter/material.dart';
import '../login/login_page.dart';

class HomePage extends StatelessWidget {
  final String name;

  const HomePage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget sectionTitle(String title) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );

    Widget smallCard(String title, {String? subtitle, IconData? icon}) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: theme.brightness == Brightness.dark
                  ? Colors.black.withOpacity(0.5)
                  : Colors.black.withOpacity(0.06),
            ),
          ],
        ),
        child: Row(
          children: [
            if (icon != null)
              CircleAvatar(
                radius: 20,
                backgroundColor: theme.colorScheme.primary,
                child: Icon(icon, color: theme.colorScheme.onPrimary, size: 20),
              ),
            if (icon != null) const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        subtitle!,
                        style: TextStyle(
                          color: theme.textTheme.bodySmall?.color,
                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14),
          ],
        ),
      );
    }

    Widget bigActionCard(String title, List<String> rows, {IconData? icon}) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.dividerColor.withOpacity(0.06)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (icon != null)
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: theme.colorScheme.primary,
                      child: Icon(
                        icon,
                        size: 16,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  if (icon != null) const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rows
                    .map(
                      (r) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 8,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(r, style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          IconButton(
            tooltip: 'Logout',
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi $name 👋',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Let's continue your Flutter journey!",
                          style: TextStyle(
                            color: theme.textTheme.bodySmall?.color,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: theme.colorScheme.primary,
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '?',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Level badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Beginner',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 18),

              // Progress / Continue Card
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionTitle('Continue where you left off'),
                        const SizedBox(height: 6),
                        smallCard(
                          'Continue Watching: Dart Variables 🌱',
                          subtitle: 'Progress: 45%',
                        ),
                        const SizedBox(height: 12),
                        sectionTitle('Today\'s Learning Goal'),
                        smallCard(
                          'Goal: Complete 2 lessons today',
                          subtitle: 'Keep momentum!',
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Your Progress: 12/50 Lessons Completed',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(value: 12 / 50),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // What you will learn today - grid of big action cards
              sectionTitle('What do you want to learn?'),
              const SizedBox(height: 8),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.05,
                children: [
                  bigActionCard('Learn Dart Basics', [
                    'Variables',
                    'Loops',
                    'Functions',
                    'Classes',
                  ], icon: Icons.code),
                  bigActionCard('Learn Flutter Widgets', [
                    'Container',
                    'Row / Column',
                    'Buttons',
                    'Navigation',
                  ], icon: Icons.widgets),
                  bigActionCard('Practice Code', [
                    'Small exercises',
                    'Output examples',
                  ], icon: Icons.play_arrow),
                  bigActionCard('Mini Projects', [
                    'Calculator',
                    'Todo App',
                    'Login UI',
                  ], icon: Icons.build),
                ],
              ),

              const SizedBox(height: 18),

              sectionTitle('Popular Lessons (Beginner Friendly)'),
              const SizedBox(height: 8),
              Column(
                children: [
                  smallCard(
                    'What is Flutter?',
                    subtitle: 'Intro for beginners',
                  ),
                  const SizedBox(height: 8),
                  smallCard('What is Dart?', subtitle: 'Language basics'),
                  const SizedBox(height: 8),
                  smallCard('Widget tree', subtitle: 'How widgets compose UI'),
                ],
              ),

              const SizedBox(height: 18),

              sectionTitle('Tips for Beginners'),
              const SizedBox(height: 8),
              Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Practice daily for 15 minutes.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Understand widgets, not just copy code.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Start with UI basics first.'),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              sectionTitle('Categories'),
              SizedBox(
                height: 86,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final c in [
                      'Dart',
                      'Flutter Basics',
                      'UI Widgets',
                      'Layout',
                      'State Management',
                      'API Calls',
                      'Animations',
                      'Projects',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(label: Text(c)),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              sectionTitle('Community / Q&A'),
              const Text(
                'Ask Questions → Join community',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
