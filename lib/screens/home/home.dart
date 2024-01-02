import 'package:flutter/material.dart';
import 'package:rive_flutter/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      drawer: const SideDrawer(),
    );
  }
}

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: 200,
        backgroundColor: Colors.black,
        child: Container(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
                children: [
                  ListTile(
                      leading: const Icon(Icons.arrow_drop_down_circle_outlined),
                      title: const Text("Archery Pull to refresh",style: TextStyle(
                          color: Colors.white,  fontSize: 15)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=> const ArcheryScreen()));
                      }
                  ),
                  ListTile(
                      leading: const Icon(Icons.arrow_drop_down_circle_outlined),
                      title: const Text("Tree Planting Timer",style: TextStyle(
                          color: Colors.white,  fontSize: 15)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=> const TreePlantingScreen()));
                      }
                  ),
                  ListTile(
                      leading: const Icon(Icons.arrow_drop_down_circle_outlined),
                      title: const Text("Bottom Nav Icons",style: TextStyle(
                          color: Colors.white,  fontSize: 15)),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=> const BottomNav()));
                      }
                  ),

                ]
            )
        )
    );
  }
}
