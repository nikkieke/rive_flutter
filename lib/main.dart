import 'package:flutter/material.dart';
import 'package:rive_flutter/new_rive/segmented_slider.dart';
import 'package:rive_native/rive_native.dart' as rive;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await rive.RiveNative.init();
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
        //home: const DemoHome());
        //home: const AnimatedFab());
        home: const SegmentedSlider());
  }
}
