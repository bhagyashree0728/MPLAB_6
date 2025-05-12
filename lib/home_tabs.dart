import 'package:flutter/material.dart';
import 'practice_page.dart';
import 'quiz_page.dart';
import 'leaderboard_page.dart';
import 'profile_page.dart';
import 'YoutubeTestimonialsPage.dart'; // Import the YouTube Testimonials Page

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Updated length to 5 to include the YouTube Testimonials tab
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            "🚀 Space Kidz Learning",
            style: TextStyle(
              fontFamily: 'Orbitron',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          bottom: const TabBar(
            indicatorColor: Colors.yellowAccent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorWeight: 4,
            tabs: [
              Tab(icon: Icon(Icons.auto_awesome), text: 'Practice'),
              Tab(icon: Icon(Icons.quiz), text: 'Quiz'),
              Tab(icon: Icon(Icons.emoji_events), text: 'Leaderboard'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
              Tab(icon: Icon(Icons.video_library), text: 'Testimonials'), // Added new tab
            ],
          ),
        ),
        body: Stack(
          children: [
            // 🚀 Solar system animated background
            Positioned.fill(
              child: Image.asset(
                'assets/splash/solar.gif',
                fit: BoxFit.cover,
              ),
            ),

            // 🕶️ Overlay for text readability
            Container(color: Colors.black.withOpacity(0.4)),

            // 🧠 Learning Tabs
            TabBarView(
              children: [
                PracticePage(),
                QuizPage(),
                LeaderboardPage(),
                ProfilePage(),
                YoutubeTestimonialsPage(), // Added the YouTube Testimonials Page
              ],
            ),
          ],
        ),
      ),
    );
  }
}
