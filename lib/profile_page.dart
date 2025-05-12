import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  String userName = '';
  int totalPoints = 0;
  bool isEditing = false;
  TextEditingController nameController = TextEditingController();

  final List<String> randomAvatars = [
    '🦁', '🐵', '🦊', '🐰', '🐱', '🐼', '🐸', '🐯', '🐶'
  ];

  late AnimationController _avatarController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    loadProfile();

    _avatarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _avatarController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _avatarController.dispose();
    super.dispose();
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? '';
      totalPoints = prefs.getInt('points') ?? 0;
    });
  }

  Future<void> saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    setState(() {
      userName = name;
      isEditing = false;
    });
  }

  String getAvatarEmoji() {
    if (userName.isNotEmpty) {
      return userName[0].toUpperCase();
    } else {
      return randomAvatars[Random().nextInt(randomAvatars.length)];
    }
  }

  Widget buildProfileCard(String title, String value, IconData icon) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutBack,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFADD8E6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF4B0082)),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4B0082),
          ),
        ),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF4B0082),
          ),
        ),
      ),
    );
  }

  Widget buildAwardCard(String awardName, String description) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: const Color(0xFF4B0082),
      child: ListTile(
        leading: const Icon(Icons.star, color: Colors.white),
        title: Text(
          awardName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            color: Colors.white60,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // 🌌 Background GIF
            Positioned.fill(
              child: Image.asset(
                'assets/splash/solar.gif',
                fit: BoxFit.cover,
              ),
            ),
            // 🔮 Semi-transparent overlay (optional for contrast)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            // 🌟 Main Content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (_, child) {
                        return Transform.translate(
                          offset: Offset(0, -_bounceAnimation.value),
                          child: child,
                        );
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: const Color(0xFFFFD700),
                        child: Text(
                          getAvatarEmoji(),
                          style: const TextStyle(fontSize: 48, color: Color(0xFF4B0082)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      userName.isEmpty ? "Hello, Kiddo!" : "Hello, $userName!",
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFD700),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (userName.isEmpty || isEditing)
                      Column(
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: "Enter your name",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFD700),
                            ),
                            onPressed: () {
                              if (nameController.text.trim().isNotEmpty) {
                                saveName(nameController.text.trim());
                              }
                            },
                            icon: const Icon(Icons.check, color: Color(0xFF4B0082)),
                            label: const Text(
                              "Save",
                              style: TextStyle(color: Color(0xFF4B0082)),
                            ),
                          ),
                        ],
                      ),
                    if (userName.isNotEmpty && !isEditing)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isEditing = true;
                            nameController.text = userName;
                          });
                        },
                        child: const Text(
                          "✏️ Edit Name",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    const SizedBox(height: 20),
                    buildProfileCard("Name", userName.isEmpty ? "Not set" : userName, Icons.person),
                    buildProfileCard("Age", "6 years", Icons.cake),
                    buildProfileCard("Favorite Subject", "Alphabets", Icons.school),
                    buildProfileCard("Total Points", "$totalPoints pts", Icons.star),

                    // 🎖️ Awards Section
                    const SizedBox(height: 30),
                    const Text(
                      "Awards",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFD700),
                      ),
                    ),
                    const SizedBox(height: 10),
                    buildAwardCard("First Quiz Complete", "Congrats for completing your first quiz! 🎉"),
                    buildAwardCard("Top Scorer", "You scored the highest in this challenge! 🏆"),
                    buildAwardCard("Curiosity Explorer", "You explored all the categories! 🌟"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
