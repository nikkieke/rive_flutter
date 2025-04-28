import 'package:flutter/material.dart';
import 'package:rive_flutter/rive_player.dart';
import 'package:rive_native/rive_native.dart' as rive;

class AnimatedFab extends StatefulWidget {
  const AnimatedFab({super.key});

  @override
  State<AnimatedFab> createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab> {
  late rive.StateMachine stateMachine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 110,
              height: 300,
              child: RivePlayer(
                asset: "assets/rive_assets/liquid-fab.riv",
                artboardName: "Artboard",
                fit: rive.Fit.contain,
                stateMachineName: "State Machine 1",
                autoBind: true,
                withStateMachine: (sm) {
                  stateMachine = sm;
                },
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
