import 'package:flutter/material.dart';
import 'package:poc/src/google_signin.dart';
import 'package:poc/src/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/sign-in/google': (context) => GoogleSignInComponent(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF005DAA)),
      ),
    );
  }
}
