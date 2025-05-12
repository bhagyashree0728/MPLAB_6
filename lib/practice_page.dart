import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:animate_do/animate_do.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FlutterTts tts = FlutterTts();

  final List<String> alphabets = List.generate(26, (index) => String.fromCharCode(65 + index));
  final List<String> numbers = List.generate(10, (index) => (index + 1).toString());
  final List<String> shapes = ['Circle', 'square', 'Triangle', 'rectangle', 'star', 'heart'];
  final List<String> planets = ['Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Future<void> speak(String value) async {
    await tts.setLanguage("en-US");
    await tts.setPitch(1);
    await tts.setSpeechRate(0.4);
    await tts.speak(value);
  }

  Widget buildGridSection(List<String> items, String type) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.8,
      children: items.map((item) {
        final isPlanet = type == 'planets';
        final imagePathPlanets = 'assets/planets/pla1.jpg';
        final imagePathJpg = 'assets/$type/$item.jpg';
        final imagePathPng = 'assets/$type/$item.png';

        return BounceInDown(
          child: GestureDetector(
            onTap: () => speak(item),
            child: Card(
              color: Colors.white.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        isPlanet ? imagePathPlanets : imagePathJpg,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            isPlanet ? imagePathPlanets : imagePathPng,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Text(
                                  'Image not found',
                                  style: TextStyle(color: Colors.red, fontSize: 16),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item[0].toUpperCase() + item.substring(1),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Alphabets'),
            Tab(text: 'Numbers'),
            Tab(text: 'Solar System'),
            Tab(text: 'Shapes'),
          ],
        ),
      ),
      body: Stack(
        children: [
          // 🌌 Background GIF
          Positioned.fill(
            child: Image.asset(
              'assets/splash/solar.gif',
              fit: BoxFit.cover,
            ),
          ),

          // 🌑 Dark overlay for readability
          Container(
            color: Colors.black.withOpacity(0.6),
          ),

          // 🔤 Content on top
          TabBarView(
            controller: _tabController,
            children: [
              SingleChildScrollView(child: buildGridSection(alphabets, 'alphabets')),
              SingleChildScrollView(child: buildGridSection(numbers, 'numbers')),
              SingleChildScrollView(child: buildGridSection(planets, 'planets')),
              SingleChildScrollView(child: buildGridSection(shapes, 'Shapes')), // Folder name is case-sensitive
            ],
          ),
        ],
      ),
    );
  }
}
