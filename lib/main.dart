import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kidz Learning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1B0036), // Cosmic Dark Purple
        primaryColor: const Color(0xFFFFD700), // Golden Yellow (Sunlight)
        fontFamily: 'ComicNeue', // Use a playful font for kids (Add in pubspec.yaml)
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFDD0), // Creamy Moonlight
            shadows: [
              Shadow(
                color: Colors.black54,
                offset: Offset(2, 2),
                blurRadius: 3,
              )
            ],
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            color: Color(0xFFADD8E6), // Light Blue
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D006B), // Deep Space Purple
          foregroundColor: Color(0xFFFFD700),
          centerTitle: true,
          elevation: 6,
          shadowColor: Colors.black54,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFD700),
          ),
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Color(0xFFFFD700),
          unselectedLabelColor: Color(0xFF87CEFA), // Sky Blue
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Color(0xFFFFD700), width: 3),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFFD700),
            foregroundColor: Color(0xFF1B0036),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            shadowColor: Colors.black45,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFFD700),
          foregroundColor: Color(0xFF1B0036),
          elevation: 10,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF2A0059), // Saturn Blue
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 6,
          shadowColor: Colors.black45,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
