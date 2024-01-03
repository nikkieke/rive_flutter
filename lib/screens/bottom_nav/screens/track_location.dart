import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../nav_icons.dart';

class TrackLocation extends StatefulWidget {
  const TrackLocation({Key? key}) : super(key: key);

  @override
  State<TrackLocation> createState() => _TrackLocationState();
}

class _TrackLocationState extends State<TrackLocation> {
  SMIBool? input;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Track your current location', style: TextStyle(color: Colors.black),),
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
                  artboard: 'GPS',
                  onInit: (artboard){
                    StateMachineController controller =
                    NavIcons.getRiveController(artboard,
                        stateMachineName: 'gps_interactivity');
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
