import 'package:flutter/material.dart';
import 'package:traq/shared/app_texts.dart';
import 'package:traq/theme/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTexts.appName,
      debugShowCheckedModeBanner: false,
      theme: Pallete.lightModeAppTheme,
      home: Scaffold(),
    );
  }
}
