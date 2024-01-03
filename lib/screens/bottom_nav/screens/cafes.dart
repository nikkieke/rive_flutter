import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../nav_icons.dart';

class CafesScreen extends StatefulWidget {
  const CafesScreen({Key? key}) : super(key: key);

  @override
  State<CafesScreen> createState() => _CafesScreenState();
}

class _CafesScreenState extends State<CafesScreen> {
  SMIBool? input;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Find Cafe spots closest to you', style: TextStyle(color: Colors.black),),
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
                  artboard: 'coffee',
                  onInit: (artboard){
                    StateMachineController controller =
                    NavIcons.getRiveController(artboard,
                        stateMachineName: 'coffee_interactivity');
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
