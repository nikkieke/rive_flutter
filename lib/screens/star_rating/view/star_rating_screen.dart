import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class StarRatingScreen extends StatefulWidget {
  const StarRatingScreen({super.key});

  @override
  State<StarRatingScreen> createState() => _StarRatingScreenState();
}

class _StarRatingScreenState extends State<StarRatingScreen> {
  StateMachineController? controller;
  SMINumber? rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            switch (rating?.value) {
              case 1:
                print('Rated 1 Star');
                break;
              case 2:
                print('Rated 2 Star');
                break;
              case 3:
                print('Rated 3 Star');
                break;
              case 4:
                print('Rated 4 Star');
                break;
              case 5:
                print('Rated 5 Star');
                break;
              default:
                print('Tap on the star icon to rate');
            }
          },
          child: SizedBox(
            height: 200,
            width: 400,
            child:  RiveAnimation.asset(
                artboard: 'star-rating-artboard',
                'assets/rive_assets/rating2.riv',
              stateMachines: const ["State Machine 1"],
              onInit: (artboard) {
                controller = StateMachineController.fromArtboard(
                  artboard,
                  "State Machine 1",
                );
                controller?.isActive = false;
                if (controller == null) return;
                artboard.addController(controller!);
                rating = controller!.findInput<double>('rating') as SMINumber;
              },
            ),
          ),
        ),
      ),
    );
  }
}
