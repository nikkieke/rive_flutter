import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../nav_icons.dart';

class OrderRideScreen extends StatefulWidget {
  const OrderRideScreen({Key? key}) : super(key: key);

  @override
  State<OrderRideScreen> createState() => _OrderRideScreenState();
}

class _OrderRideScreenState extends State<OrderRideScreen> {
  SMIBool? input;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Order a Ride and arrive on time', style: TextStyle(color: Colors.black),),
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
                  artboard: 'car',
                  onInit: (artboard){
                    StateMachineController controller =
                    NavIcons.getRiveController(artboard,
                        stateMachineName: 'car_interactivity');
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
