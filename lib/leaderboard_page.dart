import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<Map<String, dynamic>> leaders = [];

  @override
  void initState() {
    super.initState();
    loadLeaderboard();
  }

  Future<void> loadLeaderboard() async {
    final prefs = await SharedPreferences.getInstance();
    final leaderboard = prefs.getStringList('leaderboard') ?? [];

    leaders = leaderboard.map((entry) {
      final parts = entry.split(':');
      return {
        'name': parts[0],
        'score': int.tryParse(parts[1]) ?? 0,
      };
    }).toList();

    leaders.sort((a, b) => b['score'].compareTo(a['score']));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/splash/solar.gif',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5), // Optional: dim background
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFD700),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: leaders.isEmpty
                      ? const Center(
                    child: Text(
                      "No scores yet!",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                      : ListView.builder(
                    itemCount: leaders.length,
                    itemBuilder: (context, index) {
                      final leader = leaders[index];
                      return Card(
                        color: const Color(0xFFADD8E6).withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFFFD700),
                            child: Text(
                              "#${index + 1}",
                              style: const TextStyle(
                                color: Color(0xFF4B0082),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            leader["name"],
                            style: const TextStyle(
                              color: Color(0xFF4B0082),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          trailing: Text(
                            "${leader["score"]} pts",
                            style: const TextStyle(
                              color: Color(0xFF4B0082),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
