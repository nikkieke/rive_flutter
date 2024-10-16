import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TextRunSample extends StatefulWidget {
  const TextRunSample({super.key});

  @override
  State<TextRunSample> createState() => _TextRunSampleState();
}

class _TextRunSampleState extends State<TextRunSample> {
  TextEditingController nameCtr = TextEditingController();
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.indigo,
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextField(
                    controller: nameCtr,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Your Name",
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnimationPage(
                                userName: nameCtr.text,
                              )));
                  await Future.delayed(
                    const Duration(seconds: 2),
                  );
                  nameCtr.clear();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension _TextExtension on Artboard {
  TextValueRun? textRun(String name) => component<TextValueRun>(name);
}

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key, required this.userName});

  final String userName;

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  StateMachineController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: RiveAnimation.asset(
            artboard: 'Artboard',
            'assets/rive_assets/text_roll_effect.riv',
            stateMachines: const ["State Machine 1"],
            onInit: (artboard) {
              controller = StateMachineController.fromArtboard(
                artboard,
                "State Machine 1",
              );
              if (controller == null) return;
              artboard.addController(controller!);
              final textRun = artboard.textRun('name');
              print(textRun);
              textRun?.text = widget.userName;
            },
          ),
        ),
      ),
    );
  }
}
