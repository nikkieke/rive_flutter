import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../nav_icons.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  SMIBool? input;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Explore The Area', style: TextStyle(color: Colors.black),),
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
                  artboard: 'walk',
                  onInit: (artboard){
                    StateMachineController controller =
                    NavIcons.getRiveController(artboard,
                        stateMachineName: 'walk_interactivity');
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
