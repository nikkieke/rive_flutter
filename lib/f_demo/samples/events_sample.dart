import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class EventsSample extends StatefulWidget {
  const EventsSample({super.key});

  @override
  State<EventsSample> createState() => _EventsSampleState();
}

class _EventsSampleState extends State<EventsSample> {
  StateMachineController? controller;
  SMIBool? jumped;

  bool isJumped = false;

  bool showText = false;

  @override
  void initState() {
    super.initState();
  }

  void onRiveEvent(RiveEvent event) async {
    if (event.name == 'jumped') {
      print('got event');
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        setState(() {
          showText = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xff50556C),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  showText ? 'Welcome to the Flutterbytes Conference' : '',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.jost(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isJumped = true;
                      showText = false;
                    });

                    jumped?.value = true;
                    await Future.delayed(
                      const Duration(seconds: 2),
                    );
                    jumped?.value = false;
                    setState(() {
                      isJumped = false;
                    });
                  },
                  child: SizedBox(
                    height: 600,
                    width: 300,
                    child: RiveAnimation.asset(
                      artboard: 'Demo',
                      'assets/rive_assets/rig_demo.riv',
                      stateMachines: const ["State Machine 1"],
                      onInit: (artboard) {
                        controller = StateMachineController.fromArtboard(
                          artboard,
                          "State Machine 1",
                        );
                        if (controller == null) return;
                        artboard.addController(controller!);
                        jumped = controller!.findInput<bool>('jump') as SMIBool;
                        controller?.addEventListener(onRiveEvent);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
