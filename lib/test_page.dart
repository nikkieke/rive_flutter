import 'package:flutter/material.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RiveAnimatedIcon(
          riveIcon: RiveIcon.home,
          width: 50,
          height: 50,
          color: Colors.green,
          strokeWidth: 3,
          loopAnimation: false,
          onTap: () {},
          onHover: (value) {}),
    );
  }
}
