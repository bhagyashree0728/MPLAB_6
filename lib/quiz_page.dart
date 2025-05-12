import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'leaderboard_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String selectedCategory = "Alphabets & Numbers";

  final Map<String, List<String>> quizData = {
    "Alphabets & Numbers": [
      ...'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split(''),
      ...List.generate(10, (index) => (index + 1).toString()),
    ],
    "Solar System": [
      "sun", "moon", "earth", "mars", "venus", "jupiter", "saturn", "uranus", "neptune", "mercury",
    ],
    "Shapes": [
      "circle", "square", "triangle", "rectangle", "star", "hexagon",
    ],
  };

  late String correctAnswer;
  late List<String> options;
  int score = 0;
  int questionCount = 0;

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    final rand = Random();
    List<String> currentList = quizData[selectedCategory]!;
    correctAnswer = currentList[rand.nextInt(currentList.length)];
    options = [correctAnswer];

    while (options.length < 4) {
      String newOption = currentList[rand.nextInt(currentList.length)];
      if (!options.contains(newOption)) {
        options.add(newOption);
      }
    }

    options.shuffle();
  }

  Future<void> checkAnswer(String selectedOption) async {
    final isCorrect = selectedOption == correctAnswer;
    questionCount++;

    if (isCorrect) score++;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF15150C),
        title: Text(
          isCorrect ? "🎉 Correct!" : "❌ Oops!",
          style: TextStyle(
            color: isCorrect ? Colors.greenAccent : Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Answer: $correctAnswer",
          style: const TextStyle(color: Color(0xFFADD8E6)),
        ),
        actions: [
          TextButton(
            child: const Text(
              "Next",
              style: TextStyle(color: Color(0xFFFFD700)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if (questionCount < 10) {
                setState(() => generateQuestion());
              } else {
                showFinalScore();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> showFinalScore() async {
    final prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('username') ?? 'Anonymous';

    List<String> leaderboard = prefs.getStringList('leaderboard') ?? [];
    leaderboard.add('$name:$score');
    await prefs.setStringList('leaderboard', leaderboard);

    int currentPoints = prefs.getInt('points') ?? 0;
    await prefs.setInt('points', currentPoints + score);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LeaderboardPage()),
    );
  }

  String getImagePath(String answer) {
    switch (selectedCategory) {
      case "Alphabets & Numbers":
        return int.tryParse(answer) != null
            ? 'assets/numbers/$answer.jpg'
            : 'assets/alphabets/$answer.png';
      case "Solar System":
      // Try JPG first for planets, fallback to PNG if needed
        return 'assets/planets/pla1.jpg'; // if your planets are in .jpg
    // return 'assets/planets/$answer.png'; // uncomment if they’re .png instead
      case "Shapes":
      // Try PNG first for shapes, fallback to JPG if needed
        return 'assets/Shapes/$answer.jpg'; // if your shapes are in .png
    return 'assets/Shapes/$answer.jpg'; // uncomment if they’re .jpg instead
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background covering entire screen
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/splash/solar.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Selector
                  DropdownButton<String>(
                    dropdownColor: const Color(0xFF15150C),
                    value: selectedCategory,
                    items: quizData.keys.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedCategory = value;
                          score = 0;
                          questionCount = 0;
                          generateQuestion();
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Question ${questionCount + 1} of 10",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Which image is shown?",
                    style: TextStyle(
                      fontSize: 26,
                      color: Color(0xFFFFD700),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFADD8E6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        getImagePath(correctAnswer),
                        height: 260,
                        width: 160,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    children: options.map((option) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFD700),
                            foregroundColor: const Color(0xFF15150C),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () => checkAnswer(option),
                          child: Text(
                            option.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
