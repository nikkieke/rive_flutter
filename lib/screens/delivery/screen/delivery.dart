import'package:flutter/material.dart';
import 'package:rive/rive.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  /// rive controller
  StateMachineController? controller;

  /// input values
  SMINumber? state;
  SMITrigger? isPressed;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: TextButton(
          onPressed: (){
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.topCenter,
            height: 200,
            color: Colors.black12,
            width: double.maxFinite,
            child: GestureDetector(
              onTap: (){
                isPressed?.fire();
              },
              child: SizedBox(
                height: 150,
                child: RiveAnimation.asset(
                'assets/rive_assets/delivery_demo.riv',
                fit: BoxFit.cover,
                  stateMachines: const ["State Machine 1"],
                  artboard: 'DeliveryDemo',
                  onInit: (artboard) {
                    controller = StateMachineController.fromArtboard(
                      artboard,
                      "State Machine 1",
                    );
                    controller?.isActive = false;
                    if (controller == null) return;
                    artboard.addController(controller!);
                    state = controller!.findInput<double>('State') as SMINumber;
                    isPressed = controller!.findInput<bool>('isPressed')as SMITrigger;
                  },
                ),
              ),
            )
          );
        },
      );

          },
          child: Container(
            alignment: Alignment.center,
            height: 70,
            width: 200,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: const Text('Track Order', style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}

