import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TreePlantingScreen extends StatefulWidget {
  const TreePlantingScreen({Key? key}) : super(key: key);

  @override
  State<TreePlantingScreen> createState() => _TreePlantingScreenState();
}

class _TreePlantingScreenState extends State<TreePlantingScreen> {
  static const int maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;
  void resetTimer()=> seconds = maxSeconds;

  /// rive controller and input values
  StateMachineController? controller;
  SMINumber? input;

  @override
  Widget build(BuildContext context) {
    String displaySeconds = (seconds % 60).toInt().toString().padLeft(2, '0');
    String displayMinutes = ((seconds / 60)% 60).toInt().toString().padLeft(2, '0');
    final isRunning = timer == null? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;
    final percentage = (1 - seconds / maxSeconds).clamp(0.0, 1.1) * 100;
    input?.value = percentage;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff271528),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text('Plant your Tree', style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      backgroundColor: const Color(0xff4d4c61),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: RiveAnimation.asset(
                'assets/rive_assets/tree.riv',
                fit: BoxFit.cover,
                stateMachines: const ["State Machine 1"],
                artboard: 'New Artboard',
                onInit: (artboard) {
                  controller = StateMachineController.fromArtboard(
                    artboard,
                    "State Machine 1",
                  );
                  controller?.isActive = false;
                  if (controller == null) return;
                  artboard.addController(controller!);
                  input = controller!.findInput<double>('input') as SMINumber;
                },
              ),
            ),
            const SizedBox(height: 30,),
            seconds == 0?
            const Text('Yay! your tree is all grown 🎉',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200, color: Colors.white),):
            Text('$displayMinutes : $displaySeconds',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w200, color: Colors.white),),
            const SizedBox(height: 30,),
            isRunning || !isCompleted?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(pressed: () {
                  if(isRunning){
                    stopTimer(reset: false);
                  }else{
                    startTimer(reset: false);
                  }

                }, text: isRunning? 'Pause' : 'Resume', bgColor: const Color(0xff822C59),),
                const SizedBox(width: 30,),
                ButtonWidget(pressed: () {
                  stopTimer();
                }, text: 'Cancel', bgColor: const Color(0xff822C59),),
              ],
            ):
            ButtonWidget(pressed: () {
              startTimer();
            }, text: 'Plant', bgColor: const Color(0xff822C59),)
          ],
        ),
      ),
    );
  }
  void startTimer({bool reset = true}){
    if (reset){
      resetTimer();
    }
    timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if(seconds > 0){
        setState(() {
          seconds --;
        });
      }else{
        stopTimer(reset: false);
      }
    });
  }

  void stopTimer({bool reset = true}){
    if(reset){
      resetTimer();
    }
    setState(() {
      timer?.cancel();
    });
  }


}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key, required this.pressed, required this.text, required this.bgColor,
  });
  final VoidCallback pressed;
  final String text;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        backgroundColor: bgColor,
      ),
        onPressed: pressed,
        child:  Text(text, style: const TextStyle(color: Colors.white),),
    );
  }
}
