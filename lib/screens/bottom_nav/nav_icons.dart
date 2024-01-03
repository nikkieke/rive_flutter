import 'package:rive/rive.dart';

class NavIcons{
  final String artboard, title,
      stateMachineName,
      path = 'assets/rive_assets/iconsT.riv';
  SMIBool? input;

  NavIcons({
    required this.stateMachineName,
    required this.artboard,
    required this.title,
    this.input,
  });



  set setInput(SMIBool status){
    input = status;
  }

  static StateMachineController getRiveController(Artboard artboard,
      {stateMachineName = "State Machine 1"}){
    StateMachineController? controller =
    StateMachineController.fromArtboard(artboard,stateMachineName );
    artboard.addController(controller!);
    return controller;
  }

}

List<NavIcons> iconList = [
  NavIcons(artboard: 'walk', title: 'Explore', stateMachineName: 'walk_interactivity',),
  NavIcons(artboard: 'compass', title: 'Compass', stateMachineName: 'compass_interactivity',),
  NavIcons(artboard: 'coffee', title: 'Cafes Near me', stateMachineName: 'coffee_interactivity',),
  NavIcons(artboard: 'car', title: 'Order Ride', stateMachineName: 'car_interactivity',),
];