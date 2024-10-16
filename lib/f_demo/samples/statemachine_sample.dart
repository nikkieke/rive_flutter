import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class StatemachineSample extends StatefulWidget {
  const StatemachineSample({super.key});

  @override
  State<StatemachineSample> createState() => _StatemachineSampleState();
}

class _StatemachineSampleState extends State<StatemachineSample> {
  static const int maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  StateMachineController? controller;
  SMIBool? downloading;
  SMINumber? progress;

  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    final percentage = (1 - seconds / maxSeconds).clamp(0.0, 1.1) * 100;
    progress?.value = percentage;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xff101926),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            children: [
              Expanded(
                child: RiveAnimation.asset(
                  artboard: 'Artboard',
                  'assets/rive_assets/loader_icon.riv',
                  stateMachines: const ["State machine 1"],
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      "State machine 1",
                    );
                    if (controller == null) return;
                    artboard.addController(controller!);
                    progress =
                        controller!.findInput<double>('Progress') as SMINumber;
                    downloading =
                        controller!.findInput<bool>('Downloading') as SMIBool;
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  downloading?.value = true;

                  timer = Timer.periodic(const Duration(milliseconds: 300),
                      (timer) {
                    setState(() {
                      if (seconds > 0) {
                        seconds--;
                      } else {
                        timer.cancel();
                      }
                      isDownloading = true;
                    });
                  });
                },
                child: isDownloading
                    ? Container()
                    : Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 200,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: const Text(
                          'Start Download',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
