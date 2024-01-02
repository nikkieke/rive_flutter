import 'package:rive/rive.dart';

class NavIcons{
  final String artboard,title,
      stateMachineName = 'group animation',
      path = 'assets/rive_assets/iconsTravel.riv';
  SMIBool? input;

  NavIcons({
    required this.artboard,
    required this.title,
    this.input,
  });



  set setInput(SMIBool status){
    input = status;
  }
}

List<NavIcons> iconList = [
  NavIcons(artboard: 'map', title: 'Map',),
  NavIcons(artboard: 'food', title: 'Restaurants',),
  NavIcons(artboard: 'coffee', title: 'Cafes',),
  NavIcons(artboard: 'drive', title: 'Order-A-Ride',),
];