import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_flutter/screens/bottom_nav/nav_icons.dart';
import 'screens/screens.dart';

import 'bottom_nav_bar.dart';



class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);


  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  TabNotifier tabNotifier = TabNotifier();
  
  SMIBool? input;

  List<Widget> pages = const [
    ExploreScreen(),
    CompassScreen(),
    CafesScreen(),
    OrderRideScreen(),
    TrackLocation(),
  ];


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      //backgroundColor: const Color(0xff769fe4),
      body: ValueListenableBuilder(
          valueListenable: tabNotifier.currentIndex,
          builder: (context, value, child){
            return pages[tabNotifier.currentIndex.value];
          }),

      floatingActionButton: ValueListenableBuilder(
        valueListenable: tabNotifier.currentIndex,
        builder: (context, value, child){
          return  FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: const Color(0xff20274b),
            onPressed: (){
              tabNotifier.setCenterPage();
              input!.change(true);
              Future.delayed(const Duration(seconds: 2), (){
                input!.change(false);
              });
            },
            child:  SizedBox(
              height: 50,
              width: 50,
              child: RiveAnimation.asset(
                'assets/rive_assets/iconsT.riv',
                artboard: 'GPS',
                onInit: (artboard){
                  StateMachineController controller =
                  NavIcons.getRiveController(artboard,
                      stateMachineName: 'gps_interactivity');
                  input = controller.findSMI("active") as SMIBool;
                },
              ),
            ),
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        backgroundColor: const Color(0xff2e3d7a),
        leftCornerRadius: 30,
        rightCornerRadius: 30,
        shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Color(0xff33449a),
        ),
        child: ValueListenableBuilder(
          valueListenable: tabNotifier.currentIndex,
          builder: (context, value, child){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(iconList.length,
                        (index) => GestureDetector(
                      onTap: (){
                        tabNotifier.setIndex(index);
                        iconList[index].input!.change(true);
                        Future.delayed(const Duration(seconds: 2), (){
                          iconList[index].input!.change(false);
                        }
                        );
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: RiveAnimation.asset(
                              iconList.first.path,
                              artboard: iconList[index].artboard,
                              onInit: (artboard){
                                StateMachineController controller =
                                NavIcons.getRiveController(artboard,
                                    stateMachineName: iconList[index].stateMachineName);
                                iconList[index].input =
                                controller.findSMI("active") as SMIBool;
                              },

                            ),
                          ),
                          Text(iconList[index].title, style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),)
                        ],
                      ),
                    ))
              ],
            );
          },
        ),
      )

    );
  }
}

class TabNotifier{

  ValueNotifier currentIndex = ValueNotifier(0);

  void setIndex(int index){
    currentIndex.value = index;
  }

  void setCenterPage(){
    currentIndex.value = 4;
  }

}








