import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../nav_icons.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({Key? key}) : super(key: key);

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  SMIBool? input;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Feeling lost? Check your compass', style: TextStyle(color: Colors.black),),
              const SizedBox(height: 20,),
              Container(
                width: 200,
                height: 200,
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: Color(0xff20274b),

                ),
                child: RiveAnimation.asset(
                  'assets/rive_assets/iconsT.riv',
                  artboard: 'compass',
                  onInit: (artboard){
                    StateMachineController controller =
                    NavIcons.getRiveController(artboard,
                        stateMachineName: 'compass_interactivity');
                    input =
                    controller.findSMI("active") as SMIBool;
                    input!.change(true);
                  },

                ),
              ),
            ],
          )),
    );
  }
}
