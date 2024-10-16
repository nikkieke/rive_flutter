import 'package:flutter/material.dart';
import 'package:rive_flutter/f_demo/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        //home: const HomeScreen()
        home: const DemoHome());
  }
}
