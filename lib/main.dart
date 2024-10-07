import 'package:emergencyapp/ai_text_detector.dart';
import 'package:emergencyapp/humanitize_text.dart';
import 'package:emergencyapp/splash_screen.dart';
import 'package:emergencyapp/text_paraphrase.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
     home: TextParaphrasingPage(),
    );
  }
}

